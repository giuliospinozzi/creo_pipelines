#!/usr/bin/env Rscript
args <- commandArgs(trailingOnly=TRUE)

table_path <- args[1]
dea <- args[2]
output_dir <- args[3]
max_c <- args[4]
script <- args[5]

setwd(output_dir)
max_c = as.numeric(max_c)

#####################################################
######## Gene Ontology enrichment analysis ##########
#####################################################

if (dea == "edgeR"|dea == "DESeq2") {
  table=read.csv(table_path,row.names = 1)
  table1=table[,c(1,3,7)]
}

if (dea == "cummeRbund") {
  table=read.csv(table_path,row.names = 1)
  table1=table[,c(2,8,10)]
}

colnames(table1)=c("Gene","logFC","FDR")
table1=table1[table1$logFC!=Inf&table1$logFC!=-Inf,]

library(clusterProfiler)
library(dplyr)
library(org.Hs.eg.db)
library(igraph)
library(scales)
source(paste0(script,"/CNETPLOT_FUNCTION.R"))

# GO tables
table1$entrez = mapIds(org.Hs.eg.db, keys=as.character(table1$Gene), column="ENTREZID",
                       keytype="SYMBOL", multiVals="first")
GO_BP=enrichGO(table1[abs(table1$logFC)>1.5 & table1$FDR<0.05,"entrez"], ont="BP", pvalueCutoff= 0.05, 
               pAdjustMethod = "fdr", universe = table1$entrez, OrgDb = org.Hs.eg.db, readable = T)
GO_CC=enrichGO(table1[abs(table1$logFC)>1.5 & table1$FDR<0.05,"entrez"], ont="CC", pvalueCutoff= 0.05, 
               pAdjustMethod = "fdr", universe = table1$entrez, OrgDb = org.Hs.eg.db, readable = T)
GO_MF=enrichGO(table1[abs(table1$logFC)>1.5 & table1$FDR<0.05,"entrez"], ont="MF", pvalueCutoff= 0.05, 
               pAdjustMethod = "fdr", universe = table1$entrez, OrgDb = org.Hs.eg.db, readable = T)
GO_BP@result$GO_domain="biological_process"
GO_CC@result$GO_domain="cellular_component"
GO_MF@result$GO_domain="molecular_function"
GO=rbind(GO_BP@result,GO_CC@result,GO_MF@result)
write.csv(GO,paste0(output_dir,"/Gene_ontology/GO_fc1.5_pv0.05.csv"),row.names = F)

# treemap
library(treemap)
tree_BP=GO_BP@result[,c(2,9)]
tree_BP$namespace_1003="biological_process"
tree_CC=GO_CC@result[,c(2,9)]
tree_CC$namespace_1003="cellular_component"
tree_MF=GO_MF@result[,c(2,9)]
tree_MF$namespace_1003="molecular_function"
all=merge(tree_BP,tree_CC,all.x=T,all.y=T)
all=merge(tree_MF,all,all.x=T,all.y=T)
pdf(paste0(output_dir,"/Gene_ontology/treemap_GO_fc1.5_pv0.05.pdf"),12,10)
treemap(all,index=c("namespace_1003","Description"),vSize="Count",type="categorical",
        inflate.labels = TRUE,vColor = "namespace_1003",fontsize.labels = c(0,0.9),
        title="GO |Fold-Change|> 1.5 and pvalue<.05",title.legend = "Legend",
        palette=c("lightpink","skyblue","lightgreen"))
dev.off()
png(paste0(output_dir,"/Gene_ontology/treemap_GO_fc1.5_pv0.05.png"),1200, 1000, pointsize=20)
treemap(all,index=c("namespace_1003","Description"),vSize="Count",type="categorical",
        inflate.labels = TRUE,vColor = "namespace_1003",fontsize.labels = c(0,0.9),
        title="GO |Fold-Change|> 1.5 and pvalue<.05",title.legend = "Legend",
        palette=c("lightpink","skyblue","lightgreen"))
dev.off()

# GO tables for genes
#BP
gene=c()
go=c()
a=GO_BP@result$geneID
for (i in 1:length(a)) {
  b=unlist(strsplit(a[i], split="/"))
  gene=c(gene,b)
  go=c(go,rep(GO_BP@result$Description[i],length(b)))
}
tab_BP=data.frame(Gene=gene,GO=go)
y=table1[,c(1,2)]
tab_BP1=merge(tab_BP,y,all.x=T,all.y=F)
tab_BP1=tab_BP1[order(tab_BP1$GO),]
tab_BP1$GO_domain="biological_process"
#CC
gene=c()
go=c()
a=GO_CC@result$geneID
for (i in 1:length(a)) {
  b=unlist(strsplit(a[i], split="/"))
  gene=c(gene,b)
  go=c(go,rep(GO_CC@result$Description[i],length(b)))
}
tab_CC=data.frame(Gene=gene,GO=go)
tab_CC1=merge(tab_CC,y,all.x=T,all.y=F)
tab_CC1=tab_CC1[order(tab_CC1$GO),]
tab_CC1$GO_domain="cellular_component"
#MF
gene=c()
go=c()
a=GO_MF@result$geneID
for (i in 1:length(a)) {
  b=unlist(strsplit(a[i], split="/"))
  gene=c(gene,b)
  go=c(go,rep(GO_MF@result$Description[i],length(b)))
}
tab_MF=data.frame(Gene=gene,GO=go)
tab_MF1=merge(tab_MF,y,all.x=T,all.y=F)
tab_MF1=tab_MF1[order(tab_MF1$GO),]
tab_MF1$GO_domain="molecular_function"
# all
tab=rbind(tab_BP1,tab_CC1,tab_MF1)
write.csv(tab,paste0(output_dir,"/Gene_ontology/tab_GO_genes.csv"),row.names = F)

# dotplot
pdf(paste0(output_dir,"/Gene_ontology/dotplot_GO.pdf"),10,8)
dotplot(GO_BP, showCategory=max_c, title = "Enriched GO for Biological Process")
dotplot(GO_CC, showCategory=max_c, title = "Enriched GO for Cellular Component")
dotplot(GO_MF, showCategory=max_c, title = "Enriched GO for Molecular Function")
dev.off()
png(paste0(output_dir,"/Gene_ontology/dotplot_GO_BP.png"),1000, 800, pointsize=20)
dotplot(GO_BP, showCategory=max_c, title = "Enriched GO for Biological Process")
dev.off()
png(paste0(output_dir,"/Gene_ontology/dotplot_GO_CC.png"),1000, 800, pointsize=20)
dotplot(GO_CC, showCategory=max_c, title = "Enriched GO for Cellular Component")
dev.off()
png(paste0(output_dir,"/Gene_ontology/dotplot_GO_MF.png"),1000, 800, pointsize=20)
dotplot(GO_MF, showCategory=max_c, title = "Enriched GO for Molecular Function")
dev.off()

#cnetplot
prov=y[order(y$logFC,decreasing = T),]
prov=prov[!duplicated(prov$Gene), ]
prov=prov[!is.na(prov$Gene), ]
rownames(prov)=prov$Gene

geneList1=prov[unique(tab_BP1$Gene),]
geneList=geneList1$logFC
names(geneList)=geneList1$Gene
pdf(paste0(output_dir,"/Gene_ontology/cnetplot_GO.pdf"),10,8)
par(cex.main=1)
min=-(round(((max(abs(geneList))+1)-1),1))
max=round(((max(abs(geneList))+1)+1),1)
cnetplot.enrichResult(GO_BP,categorySize="pvalue", foldChange=geneList, showCategory = max_c,
                      col.bin=seq(min, max, by = 1), main="GO Biological Process FC>1.5 pV<.05")
cnetplot.enrichResult(GO_CC,categorySize="pvalue", foldChange=geneList, showCategory = max_c,
                      col.bin=seq(min, max, by = 1), main="GO Cellular Component FC>1.5 pV<.05")
cnetplot.enrichResult(GO_MF,categorySize="pvalue", foldChange=geneList, showCategory = max_c,
                      col.bin=seq(min, max, by = 1), main="GO Molecular Function FC>1.5 pV<.05")
dev.off()
png(paste0(output_dir,"/Gene_ontology/cnetplot_GO_BP.png"),1000, 800, pointsize=20)
cnetplot.enrichResult(GO_BP,categorySize="pvalue", foldChange=geneList, showCategory = max_c,
                      col.bin=seq(min, max, by = 1), main="GO Biological Process FC>1.5 pV<.05")
dev.off()
png(paste0(output_dir,"/Gene_ontology/cnetplot_GO_CC.png"),1000, 800, pointsize=20)
cnetplot.enrichResult(GO_CC,categorySize="pvalue", foldChange=geneList, showCategory = max_c,
                      col.bin=seq(min, max, by = 1), main="GO Cellular Component FC>1.5 pV<.05")
dev.off()
png(paste0(output_dir,"/Gene_ontology/cnetplot_GO_MF.png"),1000, 800, pointsize=20)
cnetplot.enrichResult(GO_MF,categorySize="pvalue", foldChange=geneList, showCategory = max_c,
                      col.bin=seq(min, max, by = 1), main="GO Molecular Function FC>1.5 pV<.05")
dev.off()

##############################################
######## Pathway enrichment analysis #########
##############################################

gene=table1[abs(table1$logFC)>1.5 & table1$FDR<0.05,"entrez"]
tmp=table1[order(table1$logFC,decreasing = T),]
genelist=tmp$logFC
names(genelist)=tmp$Gene

kk=enrichKEGG(gene=gene, organism='hsa', pvalueCutoff = 0.05, pAdjustMethod = "fdr", 
              universe=table1$entrez)
kk <- setReadable(kk, OrgDb = org.Hs.eg.db,keytype = "ENTREZID")
write.csv(kk@result,paste0(output_dir,"/Pathway_analysis/pathway_FC1.5_pv0.05.csv"),row.names = F)

#dotplot
pdf(paste0(output_dir,"/Pathway_analysis/dotplot_pathways.pdf"),10,8)
dotplot(kk,showCategory=max_c, title = "Enriched pathways")
dev.off()
png(paste0(output_dir,"/Pathway_analysis/dotplot_pathways.png"),1000, 800, pointsize=20)
dotplot(kk,showCategory=max_c, title = "Enriched pathways")
dev.off()

#cnetplot
pdf(paste0(output_dir,"/Pathway_analysis/cnetplot_pathways.pdf"),10,8)
par(cex.main=1)
cnetplot.enrichResult(kk, categorySize="pvalue", foldChange=genelist, showCategory = max_c,
                      main="Enriched pathways FC>1.5 & pV<.05", col.bin=seq(min, max, by = 1))
dev.off()
png(paste0(output_dir,"/Pathway_analysis/cnetplot_pathways.png"),1000, 800, pointsize=20)
cnetplot.enrichResult(kk, categorySize="pvalue", foldChange=genelist, showCategory = max_c,
                      main="Enriched pathways FC>1.5 & pV<.05", col.bin=seq(min, max, by = 1))
dev.off()

#pathview
library(pathview)
data=table1[,c("logFC","entrez")]
data=data[!duplicated(data$entrez), ]
data=data[!is.na(data$entrez), ]
rownames(data)=data$entrez
data=data[,-2,drop=F]
setwd(paste0(output_dir,"/Pathway_analysis/pathview"))
tmp = sapply(kk@result$ID, function(pid) pathview(gene.data=data, pathway.id=pid, species="hsa",
                                                low="dodgerblue",high="firebrick1",mid="gray88"))
