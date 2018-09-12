library(shiny)
library(DT)
library(magick)
library(rlist)
library(visNetwork)
library(shinyjs)

args <- commandArgs(trailingOnly=TRUE)
out_dir <- args[1]

## Summary
gen_sum=read.csv(paste0(out_dir,"/reports/general_report.csv"),sep="\t",header = F,row.names = 1)
sam_sum=read.csv(paste0(out_dir,"/reports/sample_report.csv"),sep="\t")

## FastQ quality
sam=as.character(sam_sum$sample_name)
screen1=list()
screen2=list()
fastqc1=list()
fastqc2=list()
for (i in 1:length(sam)) {
  img1=image_read(list.files(path=paste0(out_dir,"/Quality/",sam[i]),pattern="_screen.png$",full.names = T)[1])
  screen1=list.append(screen1,img1)
  img2=image_read(list.files(path=paste0(out_dir,"/Quality/",sam[i]),pattern="_screen.png$",full.names = T)[2])
  screen2=list.append(screen2,img2)
  img3=image_read(paste0(list.dirs(path=paste0(out_dir,"/Quality/",sam[i]),recursive = F)[1],"/Images/per_base_quality.png"))
  img3=image_annotate(img3,list.dirs(path=paste0(out_dir,"/Quality/",sam[i]),recursive = F,full.names = F)[1],size=30)
  fastqc1=list.append(fastqc1,img3)
  img4=image_read(paste0(list.dirs(path=paste0(out_dir,"/Quality/",sam[i]),recursive = F)[2],"/Images/per_base_quality.png"))
  img4=image_annotate(img4,list.dirs(path=paste0(out_dir,"/Quality/",sam[i]),recursive = F,full.names = F)[2],size=30)
  fastqc2=list.append(fastqc2,img4)
}

## BAM Quality
if (gen_sum[3,1]=="hisat") {dir_a="/HISAT2/"}
if (gen_sum[3,1]=="tophat") {dir_a="/TopHat2/"}
stat=list()
read_d=list()
inn_d=list()
for (i in 1:length(sam)) {
  stat=list.append(stat,list.files(path=paste0(out_dir,dir_a,sam[i],"/RSeQC"),patter="bam_stat.txt",full.names = T))
  read_d=list.append(read_d,list.files(path=paste0(out_dir,dir_a,sam[i],"/RSeQC"),patter="read_distribution.txt",full.names = T))
  img=image_read_pdf(list.files(path=paste0(out_dir,dir_a,sam[i],"/RSeQC"),patter="inner_distance_plot.pdf",full.names = T))
  img=image_annotate(img,"Inner distance plot",gravity = "North",size = 70)
  inn_d=list.append(inn_d,img)
}

processFile = function(filepath,title) {
  cat(title,"\n")
  con = file(filepath, "r")
  while ( TRUE ) {
    line = readLines(con, n = 1)
    if ( length(line) == 0 ) {
      break
    }
    cat(line,"\n")
  }
  close(con)
} 

## Differential expression analysis
data_test=read.csv(paste0(out_dir,"/Quantification_and_DEA/",list.files(path=paste0(out_dir,"/Quantification_and_DEA/"),pattern="-diffexpr-results.csv")), row.names = 1,dec = ".")
for (i in 3:ncol(data_test)){data_test[,i]=signif(data_test[,i],digits=3)}
pca=image_read(list.files(path=paste0(out_dir,"/Quantification_and_DEA"),
                          pattern = "-pca.png",
                          full.names = T))
volcano=image_read(list.files(path=paste0(out_dir,"/Quantification_and_DEA"),
                              pattern = "-volcanoplot.png",
                              full.names = T))
heat1=image_read(list.files(path=paste0(out_dir,"/Quantification_and_DEA"),
                            pattern = "-heatmap-topVarGenes.png",
                            full.names = T))
heat2=image_read(list.files(path=paste0(out_dir,"/Quantification_and_DEA"),
                            pattern = "-heatmap-samples.png",
                            full.names = T))


## Meta-analysis
GO=read.csv(paste0(out_dir,"/Meta-analysis/Gene_ontology/GO_fc1.5_pv0.05.csv"))
GO=GO[,c(1,2,3,4,5,6,7,9,10,8)]
for (i in 5:7){GO[,i]=signif(GO[,i],digits=3)}
GO_gene=read.csv(paste0(out_dir,"/Meta-analysis/Gene_ontology/tab_GO_genes.csv"))
GO_gene$logFC=signif(GO_gene$logFC,digits = 3)
tree=image_read_pdf(paste0(out_dir,"/Meta-analysis/Gene_ontology/treemap_GO_fc1.5_pv0.05.pdf"))
dot_go=image_read_pdf(paste0(out_dir,"/Meta-analysis/Gene_ontology/dotplot_GO.pdf"))
path=read.csv(paste0(out_dir,"/Meta-analysis/Pathway_analysis/pathway_FC1.5_pv0.05.csv"))
for (i in 5:7){path[,i]=signif(path[,i],digits=3)}
path=path[,c(1,2,3,4,5,6,7,9,8)]
dot=image_read_pdf(paste0(out_dir,"/Meta-analysis/Pathway_analysis/dotplot_pathways.pdf"))


## report
fakeDataProcessing <- function(duration) {
  Sys.sleep(duration)
}


## Server
shinyServer(function(input, output, session) {
  
  ## Summary
  output$gen_sum <- renderTable({
    gen_sum
  }, rownames = T, colnames = F)
  
  output$sam_sum <- renderTable({
    sam_sum
  })
  
  ## FastQ quality
  output$quality1 <- renderPlot({
    for (i in 1:length(sam)) {
      if (input$FastQ==sam[i]) {plot(screen1[[i]])}
    }
  })
  
  output$quality2 <- renderPlot({
    for (i in 1:length(sam)) {
      if (input$FastQ==sam[i]) {plot(screen2[[i]])}
    }
  })
  
  output$quality3 <- renderPlot({
    for (i in 1:length(sam)) {
      if (input$FastQ==sam[i]) {plot(fastqc1[[i]])}
    }
  })
  
  output$quality4 <- renderPlot({
    for (i in 1:length(sam)) {
      if (input$FastQ==sam[i]) {plot(fastqc2[[i]])}
    }
  })
  
  ## BAM quality
  output$stat <- renderPrint({
    for (i in 1:length(sam)) {
      if (input$BAM==sam[i]) {processFile(stat[[i]],"#### Statistics ####")}
    }
  })
  
  output$read <- renderPrint({
    for (i in 1:length(sam)) {
      if (input$BAM==sam[i]) {processFile(read_d[[i]], "#### Read distribution ####\n")}
    }
  })
  
  output$inn <- renderPlot({
    for (i in 1:length(sam)) {
      if (input$BAM==sam[i]) {plot(inn_d[[i]])}
    }
  })
  
  ## Differential expression analysis
  output$DEA_tab <- renderDataTable({
    data_test
  },
  filter = 'top',
  rownames = FALSE,
  options = list(pageLength = 10, autoWidth = TRUE)
  )
  
  output$pca <- renderPlot({
    plot(pca)
  })
  
  output$volcano <- renderPlot({
    plot(volcano)
  })
  
  output$heat1 <- renderPlot({
    plot(heat1)
  })
  
  output$heat2 <- renderPlot({
    plot(heat2)
  })
  
  ## Gene Ontology
  output$GO <- renderDataTable({
    GO
  },
  filter = 'top',
  rownames = FALSE,
  options = list(pageLength = 5, autoWidth = T)
  )
  
  output$GO_gene <- renderDataTable({
    GO_gene
  },
  filter = 'top',
  rownames = FALSE,
  options = list(pageLength = 5, autoWidth = T)
  )
  
  output$network <- renderVisNetwork ({
    n_cat=input$n_cat
    GOb=GO[GO$GO_domain=="biological_process",]
    GOa=as.character(GOb$Description[1:n_cat])
    gene=c()
    for (i in 1:length(GOa)) {
      gene=append(gene,as.character(GO_gene[GO_gene$GO==GOa[i],"Gene"]))
    }
    to=gene
    gene=unique(gene)
    g_gene=c()
    fc=c()
    for (i in 1:length(gene)) {
      fc[i]=GO_gene[GO_gene==gene[i],"logFC"]
      if (fc[i]<0) {g_gene[i]="down"}
      if (fc[i]>=0) {g_gene[i]="up"}
    }
    group=c(rep("GO", length(GOa)), g_gene)
    value=c(rep(85,length(GOa)),(abs(fc))*10)
    col=c()
    for (i in 1:length(group)) {
      if (group[i]=="GO") {col[i]="bisque"}
      if (group[i]=="down") {col[i]="dodgerblue"}
      if (group[i]=="up") {col[i]="red"}
    }
    nodes=data.frame(id = c(GOa,gene), group = group,label=c(GOa,gene),title=c(GOa,gene),
                     value = value,color=col,font.size = 25)
    from=c()
    for (i in 1:length(GOa)) {
      from=append(from,rep(GOa[i],GOb[GO$Description==GOa[i],"Count"]))
    }
    edges=data.frame(from=from,to=to,color="#8DA0CB")
    
    visNetwork(nodes,edges,main="GO Biological Process") %>%
      visIgraphLayout(physics = F,smooth = F,type = "full") %>% 
      visOptions(highlightNearest = TRUE, nodesIdSelection = TRUE)
    
  })
  
  output$network1 <- renderVisNetwork ({
    n_cat=input$n_cat
    GOb=GO[GO$GO_domain=="cellular_component",]
    GOa=as.character(GOb$Description[1:n_cat])
    gene=c()
    for (i in 1:length(GOa)) {
      gene=append(gene,as.character(GO_gene[GO_gene$GO==GOa[i],"Gene"]))
    }
    to=gene
    gene=unique(gene)
    g_gene=c()
    fc=c()
    for (i in 1:length(gene)) {
      fc[i]=GO_gene[GO_gene==gene[i],"logFC"]
      if (fc[i]<0) {g_gene[i]="down"}
      if (fc[i]>=0) {g_gene[i]="up"}
    }
    group=c(rep("GO", length(GOa)), g_gene)
    value=c(rep(85,length(GOa)),(abs(fc))*10)
    col=c()
    for (i in 1:length(group)) {
      if (group[i]=="GO") {col[i]="bisque"}
      if (group[i]=="down") {col[i]="dodgerblue"}
      if (group[i]=="up") {col[i]="red"}
    }
    nodes=data.frame(id = c(GOa,gene), group = group,label=c(GOa,gene),title=c(GOa,gene),
                     value = value,color=col,font.size = 25)
    from=c()
    for (i in 1:length(GOa)) {
      from=append(from,rep(GOa[i],GOb[GOb$Description==GOa[i],"Count"]))
    }
    edges=data.frame(from=from,to=to,color="#8DA0CB")
    visNetwork(nodes,edges,main="GO Cellular Component") %>%
      visIgraphLayout(physics = F,smooth = F,type = "full") %>% 
      visOptions(highlightNearest = TRUE, nodesIdSelection = TRUE)
    
  })
  
  output$network2 <- renderVisNetwork ({
    n_cat=input$n_cat
    GOb=GO[GO$GO_domain=="molecular_function",]
    GOa=as.character(GOb$Description[1:n_cat])
    gene=c()
    for (i in 1:length(GOa)) {
      gene=append(gene,as.character(GO_gene[GO_gene$GO==GOa[i],"Gene"]))
    }
    to=gene
    gene=unique(gene)
    g_gene=c()
    fc=c()
    for (i in 1:length(gene)) {
      fc[i]=GO_gene[GO_gene==gene[i],"logFC"]
      if (fc[i]<0) {g_gene[i]="down"}
      if (fc[i]>=0) {g_gene[i]="up"}
    }
    group=c(rep("GO", length(GOa)), g_gene)
    value=c(rep(85,length(GOa)),(abs(fc))*10)
    col=c()
    for (i in 1:length(group)) {
      if (group[i]=="GO") {col[i]="bisque"}
      if (group[i]=="down") {col[i]="dodgerblue"}
      if (group[i]=="up") {col[i]="red"}
    }
    nodes=data.frame(id = c(GOa,gene), group = group,label=c(GOa,gene),title=c(GOa,gene),
                     value = value,color=col,font.size = 25)
    from=c()
    for (i in 1:length(GOa)) {
      from=append(from,rep(GOa[i],GOb[GOb$Description==GOa[i],"Count"]))
    }
    edges=data.frame(from=from,to=to,color="#8DA0CB")
    visNetwork(nodes,edges,main="GO Molecular Function") %>%
      visIgraphLayout(physics = F,smooth = F,type = "full") %>% 
      visOptions(highlightNearest = TRUE, nodesIdSelection = TRUE)
    
  })
  
  output$tree <- renderPlot({
    plot(tree)
  })
  
  output$dot1 <- renderPlot({
    plot(dot_go[1])
  })
  
  output$dot2 <- renderPlot({
    plot(dot_go[2])
  })
  output$dot3 <- renderPlot({
    plot(dot_go[3])
  })
  
  ## Pathway analysis
  output$path <- renderDataTable({
    path
  },
  filter = 'top',
  rownames = FALSE,
  options = list(pageLength = 5, autoWidth = T)
  )
  
  output$network_path <- renderVisNetwork ({
    n_cat=input$n_cat1
    patha=as.character(path$Description[1:n_cat])
    gene=c()
    for (i in 1:length(patha)) {
      gene=append(gene,unlist(strsplit(as.character(path[path$Description==patha[i],"geneID"]),"/")))
    }
    to=gene
    gene=unique(gene)
    g_gene=c()
    fc=c()
    for (i in 1:length(gene)) {
      fc[i]=data_test[data_test$Gene==gene[i],"logFC"]
      if (fc[i]<0) {g_gene[i]="down"}
      if (fc[i]>=0) {g_gene[i]="up"}
    }
    group=c(rep("pathway", length(patha)), g_gene)
    value=c(rep(85,length(patha)),(abs(fc))*10)
    col=c()
    for (i in 1:length(group)) {
      if (group[i]=="pathway") {col[i]="bisque"}
      if (group[i]=="down") {col[i]="dodgerblue"}
      if (group[i]=="up") {col[i]="red"}
    }
    nodes=data.frame(id = c(patha,gene), group = group,label=c(patha,gene),title=c(patha,gene),
                     value = value,color=col,font.size = 25)
    from=c()
    for (i in 1:length(patha)) {
      from=append(from,rep(patha[i],path[path$Description==patha[i],"Count"]))
    }
    edges=data.frame(from=from,to=to,color="#8DA0CB")
    visNetwork(nodes,edges,main="Pathway") %>%
      visIgraphLayout(physics = F,smooth = F,type = "full") %>% 
      visOptions(highlightNearest = TRUE, nodesIdSelection = TRUE)
    
  })
  
  output$dot <- renderPlot({
    plot(dot)
  })
  
  # Report
  observe({
    if (input$start_proc > 0) {
      fakeDataProcessing(0)
      session$sendCustomMessage("download_ready", list(fileSize=floor(runif(1) * 10000)))
    }
  })
  
  Report <- eventReactive(input$download,{
    disable("download") 
    tempReport <- file.path(tempdir(), "report.Rmd")
    file.copy("report.Rmd", tempReport, overwrite = TRUE)
    rmarkdown::render(tempReport,
                      output_file = paste0(out_dir,"/reports/my-report.",switch(
                        input$format, PDF = 'pdf', HTML = 'html', Word = 'docx'
                      )),
                      params = list(out_dir=out_dir),
                      envir = new.env(parent = globalenv()),
                      output_format = switch(input$format,
                                             PDF = "pdf_document",
                                             HTML = "html_document",
                                             Word = "word_document"
                      ))
    enable("download")
  })
  
  observe({
    if (input$download > 0) {
      Report()
    }
  })
  
  output$text <- renderText({
    if (input$download > 0) {
      paste0("Report is available in ",out_dir,"/reports/my-report.",
             switch(
               input$format, PDF = 'pdf', HTML = 'html', Word = 'docx'
             ))
    }
  })
  
  
})
