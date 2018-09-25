library(shiny)
library(shinyjs)
library(drc)
library(ggplot2)
library(grid)
library(gridExtra)
library(rlist)

shinyServer(function(input, output) {
  
  output$fileUploaded <- reactive({
    return(is.null(input$file1))
  })
  outputOptions(output, 'fileUploaded',suspendWhenHidden=FALSE)
  
  filedata1 <- reactive({
    infile <- input$file1
    if (is.null(infile)) {return(NULL)}
    read.csv(infile$datapath,sep=input$sep1,row.names = 1,dec=".") 
  })
  
  filedata2 <- reactive({
    infile <- input$file2
    if (is.null(infile)) {return(NULL)}
    read.csv(infile$datapath,sep=input$sep1,row.names = 1,dec=".") 
  })
  
  filedata3 <- reactive({
    infile <- input$file3
    if (is.null(infile)) {return(NULL)}
    read.csv(infile$datapath,sep=input$sep1,row.names = 1,dec=".") 
  })
  
  filedata4 <- reactive({
    infile <- input$file4
    if (is.null(infile)) {return(NULL)}
    read.csv(infile$datapath,sep=input$sep1,row.names = 1,dec=".") 
  })
  
  output$tab <- renderUI({
    if (is.null(input$file1)) {return(NULL)}
    conc=c(rep(input$conc1,3),rep(input$conc2,3),rep(input$conc3,3),rep(input$conc4,3))
    df1 <-filedata1()
    drug=rownames(df1)
    selectInput("Drug", "Choose a drug:", choices = drug)
  })
  
  output$table <- renderTable({
    conc=c(rep(input$conc1,3),rep(input$conc2,3),rep(input$conc3,3),rep(input$conc4,3))
    if (is.null(input$file1)) {return(NULL)}
    df1 <-filedata1()
    colnames(df1)=conc
    drug=rownames(df1)
    if (input$cell_num>=2) {
      if (is.null(input$file2)) {return(NULL)}
      df2 <-filedata2()
      colnames(df2)=conc
    }
    if (input$cell_num>=3) {
      if (is.null(input$file3)) {return(NULL)}
      df3 <-filedata3()
      colnames(df3)=conc
    }
    if (input$cell_num==4) {
      if (is.null(input$file4)) {return(NULL)}
      df4 <-filedata4()
      colnames(df4)=conc
    }
    if (input$cell_num==1) {
      for (i in 1:length(drug)) {
        if (input$Drug==drug[i]) {
          a=df1[i,,drop=F]
          rownames(a)=paste(input$name1,drug[i])
          return(a)
        }
      }
    }
    if (input$cell_num==2) {
      for (i in 1:length(drug)) {
        if (input$Drug==drug[i]) {
          a=rbind(df1[i,],df2[i,])
          rownames(a)=c(paste(input$name1,drug[i]),paste(input$name2,drug[i]))
          return(a)
        }
      }
    }
    if (input$cell_num==3) {
      for (i in 1:length(drug)) {
        if (input$Drug==drug[i]) {
          a=rbind(df1[i,],df2[i,])
          a=rbind(a,df3[i,])
          rownames(a)=c(paste(input$name1,drug[i]),paste(input$name2,drug[i]),
                        paste(input$name3,drug[i]))
          return(a)
        }
      }
    }
    if (input$cell_num==4) {
      for (i in 1:length(drug)) {
        if (input$Drug==drug[i]) {
          a=rbind(df1[i,],df2[i,])
          a=rbind(a,df3[i,])
          a=rbind(a,df4[i,])
          rownames(a)=c(paste(input$name1,drug[i]),paste(input$name2,drug[i]),
                        paste(input$name3,drug[i]),paste(input$name4,drug[i]))
          return(a)
        }
      }
    }
    
  },rownames = T)
  
  
  output$plot <- renderPlot({
    if (is.null(input$file1)) {
      return(NULL)
    }
    df1 <-filedata1()
    conc=c(rep(input$conc1,3),rep(input$conc2,3),rep(input$conc3,3),rep(input$conc4,3))
    colnames(df1)=conc
    drug=rownames(df1)
    table1=t(df1)
    pl=list()
    
    withProgress(message = 'Generating plot', detail = "part 0", value = 0, {
      for (i in 1:(ncol(table1))) {
        df=data.frame(viability=table1[,i],dose=conc)
        fit <- drm(viability ~ dose, data=df, fct = LL.4(names=c("slope","low","high","IC50")), 
                   type = "continuous")
        pred.df <- expand.grid(dose=exp(seq(log(max(df$dose)),log(min(df$dose)),length=100))) 
        pred <- predict(fit,newdata=pred.df,interval="confidence") 
        pred.df$viability <- pmax(pred[,1],0)
        pred.df$viability <- pmin(pred.df$viability,100)
        pred.df$viability.low <- pmax(pred[,2],0)
        pred.df$viability.low <- pmin(pred.df$viability.low,100)
        pred.df$viability.high <- pmax(pred[,3],0)
        pred.df$viability.high <- pmin(pred.df$viability.high,100)
        colnames(pred.df)=c("conc", "p", "pmin", "pmax")
        
        p <- ggplot(df,aes(x=dose,y=viability)) +
          geom_point(aes(colour=input$name1),size=2.5) +
          labs(y="viability") +
          coord_trans(x="log")+theme_bw() +
          scale_x_continuous(name=paste0("dose (",input$unit,")"),breaks=sort(unique(df$dose))) +
          ggtitle(paste0("Drug ",colnames(table1)[i])) + 
          theme(plot.title=element_text(hjust=0.5,face="bold",size=24),
                axis.text=element_text(size=16),
                axis.title=element_text(size=18),
                legend.text=element_text(size=14),
                legend.title=element_text(size=16)) +
          theme(axis.text.x = element_text(angle = 35, hjust = 1)) +
          geom_line(data=pred.df,aes(x=conc,y=p,colour=input$name1),size=0.8) +
          geom_vline(xintercept=summary(fit)$coefficient[4,1],c,size=0.5,linetype="dashed", 
                     color=input$col1)
        
        if (input$cell_num==1) {
          cols=c(input$col1)
          names(cols)=input$name1
          p <- p + scale_colour_manual("Cell lines", breaks = input$name1,values = cols) +
            annotate("text",x=c(signif(summary(fit)$coefficient[4,1],4)), y=c(max(df$viability)),
                     label=c(signif(summary(fit)$coefficient[4,1],4)), color=c(input$col1),size=5)
        }
        
        if (input$cell_num>1) {
          if (is.null(input$file2)) {return(NULL)}
          d.f2 <-filedata2()
          colnames(d.f2)=conc
          table2=t(d.f2)
          df2=data.frame(viability=table2[,i],dose=conc)
          fit2 <- drm(viability ~ dose, data=df2, fct = LL.4(names=c("slope","low","high","IC50")), 
                      type = "continuous")
          pred.df2 <- expand.grid(dose=exp(seq(log(max(df2$dose)),log(min(df2$dose)),length=100))) 
          pred2 <- predict(fit2,newdata=pred.df2,interval="confidence") 
          pred.df2$viability <- pmax(pred2[,1],0)
          pred.df2$viability <- pmin(pred.df2$viability,100)
          pred.df2$viability.low <- pmax(pred2[,2],0)
          pred.df2$viability.low <- pmin(pred.df2$viability.low,100)
          pred.df2$viability.high <- pmax(pred2[,3],0)
          pred.df2$viability.high <- pmin(pred.df2$viability.high,100)
          colnames(pred.df2)=c("conc", "p", "pmin", "pmax")
          
          p <- p + geom_point(data=df2,aes(x=dose,y=viability,colour=input$name2),size=2.5) + 
            geom_line(data=pred.df2,aes(x=conc,y=p,colour=input$name2),size=0.8) +
            geom_vline(xintercept=summary(fit2)$coefficient[4,1],c,size=0.5,linetype="dashed", 
                       color=input$col2)
        }
        
        if (input$cell_num==2) {
          cols2=c(input$col1,input$col2)
          names(cols2)=c(input$name1,input$name2)
          p <- p + 
            scale_colour_manual("Cell lines", breaks = c(input$name1,input$name2), values = cols2) +
            annotate("text", x=c(signif(summary(fit)$coefficient[4,1],4),
                                 signif(summary(fit2)$coefficient[4,1],4)), 
                     y=c(max(df$viability),
                         max(df2$viability)),
                     label=c(signif(summary(fit)$coefficient[4,1],4),
                             signif(summary(fit2)$coefficient[4,1],4)), 
                     color=c(input$col1,input$col2),size=5)
        }
        
        if (input$cell_num>2) {
          if (is.null(input$file3)) {return(NULL)}
          d.f3 <-filedata3()
          colnames(d.f3)=conc
          table3=t(d.f3)
          df3=data.frame(viability=table3[,i],dose=conc)
          fit3 <- drm(viability ~ dose, data=df3, fct = LL.4(names=c("slope","low","high","IC50")), 
                      type = "continuous")
          pred.df3 <- expand.grid(dose=exp(seq(log(max(df3$dose)),log(min(df3$dose)),length=100))) 
          pred3 <- predict(fit3,newdata=pred.df3,interval="confidence") 
          pred.df3$viability <- pmax(pred3[,1],0)
          pred.df3$viability <- pmin(pred.df3$viability,100)
          pred.df3$viability.low <- pmax(pred3[,2],0)
          pred.df3$viability.low <- pmin(pred.df3$viability.low,100)
          pred.df3$viability.high <- pmax(pred3[,3],0)
          pred.df3$viability.high <- pmin(pred.df3$viability.high,100)
          colnames(pred.df3)=c("conc", "p", "pmin", "pmax")
          
          p <- p + geom_point(data=df3,aes(x=dose,y=viability,colour=input$name3),size=2.5) + 
            geom_line(data=pred.df3,aes(x=conc,y=p,colour=input$name3),size=0.8) +
            geom_vline(xintercept=summary(fit3)$coefficient[4,1],c,size=0.5,linetype="dashed", 
                       color=input$col3)
        }
        
        if (input$cell_num==3) {
          cols3=c(input$col1,input$col2,input$col3)
          names(cols3)=c(input$name1,input$name2,input$name3)
          p <- p + 
            scale_colour_manual("Cell lines", breaks = c(input$name1,input$name2,input$name3),
                                values = cols3) +
            annotate("text", x=c(signif(summary(fit)$coefficient[4,1],4),
                                 signif(summary(fit2)$coefficient[4,1],4),
                                 signif(summary(fit3)$coefficient[4,1],4)), 
                     y=c(max(df$viability),
                         max(df2$viability),
                         max(df3$viability)),
                     label=c(signif(summary(fit)$coefficient[4,1],4),
                             signif(summary(fit2)$coefficient[4,1],4),
                             signif(summary(fit3)$coefficient[4,1],4)), 
                     color=c(input$col1,input$col2,input$col3),size=5)
        }
        
        if (input$cell_num>3) {
          if (is.null(input$file4)) {return(NULL)}
          d.f4 <-filedata4()
          colnames(d.f4)=conc
          table4=t(d.f4)
          df4=data.frame(viability=table4[,i],dose=conc)
          fit4 <- drm(viability ~ dose, data=df4, fct = LL.4(names=c("slope","low","high","IC50")), 
                      type = "continuous")
          pred.df4 <- expand.grid(dose=exp(seq(log(max(df4$dose)),log(min(df4$dose)),length=100))) 
          pred4 <- predict(fit4,newdata=pred.df4,interval="confidence") 
          pred.df4$viability <- pmax(pred4[,1],0)
          pred.df4$viability <- pmin(pred.df4$viability,100)
          pred.df4$viability.low <- pmax(pred4[,2],0)
          pred.df4$viability.low <- pmin(pred.df4$viability.low,100)
          pred.df4$viability.high <- pmax(pred4[,3],0)
          pred.df4$viability.high <- pmin(pred.df4$viability.high,100)
          colnames(pred.df4)=c("conc", "p", "pmin", "pmax")
          
          p <- p + geom_point(data=df4,aes(x=dose,y=viability,colour=input$name4),size=2.5) + 
            geom_line(data=pred.df4,aes(x=conc,y=p,colour=input$name4),size=0.8) +
            geom_vline(xintercept=summary(fit4)$coefficient[4,1],c,size=0.5,linetype="dashed", 
                       color=input$col4)
        }
        
        if (input$cell_num==4) {
          cols4=c(input$col1,input$col2,input$col3,input$col4)
          names(cols4)=c(input$name1,input$name2,input$name3,input$name4)
          p <- p + 
            scale_colour_manual("Cell lines", 
                                breaks = c(input$name1,input$name2,input$name3,input$name4),
                                values = cols4) +
            annotate("text", x=c(signif(summary(fit)$coefficient[4,1],4),
                                 signif(summary(fit2)$coefficient[4,1],4),
                                 signif(summary(fit3)$coefficient[4,1],4),
                                 signif(summary(fit4)$coefficient[4,1],4)), 
                     y=c(max(df$viability),
                         max(df2$viability),
                         max(df3$viability),
                         max(df4$viability)),
                     label=c(signif(summary(fit)$coefficient[4,1],4),
                             signif(summary(fit2)$coefficient[4,1],4),
                             signif(summary(fit3)$coefficient[4,1],4),
                             signif(summary(fit4)$coefficient[4,1],4)), 
                     color=c(input$col1,input$col2,input$col3,input$col4),size=5)
        }
        pl=list.append(pl,p)
        incProgress(1/32, detail = paste0("part ", i, "/", (ncol(table1))))
      }
    })
    for (i in 1:length(drug)) {
      if (input$Drug==drug[i]) {print(pl[[i]])}
    }
  })
  
  output$downloadData <- renderUI({
    req(input$file1, filedata1())
    downloadButton("download",label = "Download plot")
  })
  
  output$download <- downloadHandler(
    filename = function() {"plot.pdf"},
    content = function(file) {
      ggsave(file,width = 10, height = 7)
    }
  )
  
  Report <- eventReactive(input$report,{
    withProgress(message = 'Generating Report', value = 0, {  
      disable("report") 
      tempReport <- file.path(tempdir(), "report.Rmd")
      file.copy("report.Rmd", tempReport, overwrite = TRUE)
      incProgress(1/3)
      params <- list(conc1 = input$conc1, conc2 = input$conc2, conc3 = input$conc3, 
                     conc4 = input$conc4, unit = input$unit, cell_num = input$cell_num,
                     name1 = input$name1, file1 = input$file1$datapath, sep1 = input$sep1,
                     col1 = input$col1, name2 = NULL, file2 = NULL, sep2 = NULL, col2 = NULL,
                     name3 = NULL, file3 = NULL, sep3 = NULL, col3 = NULL, name4 = NULL, 
                     file4 = NULL, sep4 = NULL, col4 = NULL)
      if (input$cell_num>=2) {
        params$name2 = input$name2
        params$file2 = input$file2$datapath
        params$sep2 = input$sep2
        params$col2 = input$col2
      }
      if (input$cell_num>=3) {
        params$name3 = input$name3
        params$file3 = input$file3$datapath
        params$sep3 = input$sep3
        params$col3 = input$col3
      }
      if (input$cell_num>=4) {
        params$name4 = input$name4
        params$file4 = input$file4$datapath
        params$sep4 = input$sep4
        params$col4 = input$col4
      }
      incProgress(1/3)
      rmarkdown::render(tempReport, 
                        output_file = paste0("/storage/d2/results/DrugPlates/",input$out_dir,"/report.pdf"),
                        params = params,
                        envir = new.env(parent = globalenv())
      )
      incProgress(1/3)
      enable("report")
    })
  })
  
  observe({
    if (input$report > 0) {
      dir.create(paste0("/storage/d2/results/DrugPlates/",input$out_dir))
      Report()
    }
  })
  
  output$text <- renderUI({
    if (input$report > 0) {
      url=a("Report", href=paste0("http://141.250.134.204/results/DrugPlates/",input$out_dir))
      tagList("Report is available here:", url)
    }
  })
  
})
