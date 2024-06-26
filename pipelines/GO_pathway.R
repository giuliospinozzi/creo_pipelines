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

print("######### Gene Ontology #########")

if (dea == "edgeR"|dea == "DESeq2") {
  table=read.csv(table_path,row.names = 1)
  table1=table[,c(1,2,4)]
}

if (dea == "cummeRbund") {
  table=read.csv(table_path,row.names = 1)
  table1=table[,c(1,2,3)]
}

colnames(table1)=c("Gene","logFC","FDR")
table1=table1[table1$logFC!=Inf&table1$logFC!=-Inf,]

library(rlist)
library(clusterProfiler)
library(org.Hs.eg.db)
library(igraph)
library(scales)
source(paste0(script,"/CNETPLOT_FUNCTION.R"))
library(dplyr)
library(ggplot2)

# GO tables
table1$entrez = mapIds(org.Hs.eg.db, keys=as.character(table1$Gene), column="ENTREZID",
                       keytype="SYMBOL", multiVals="first")
GO_BP=enrichGO(table1[abs(table1$logFC)>1.5 & table1$FDR<0.05,"entrez"], ont="BP", pvalueCutoff= 0.05, 
               pAdjustMethod = "fdr", universe = table1$entrez, OrgDb = org.Hs.eg.db, readable = T)
GO_CC=enrichGO(table1[abs(table1$logFC)>1.5 & table1$FDR<0.05,"entrez"], ont="CC", pvalueCutoff= 0.05, 
               pAdjustMethod = "fdr", universe = table1$entrez, OrgDb = org.Hs.eg.db, readable = T)
GO_MF=enrichGO(table1[abs(table1$logFC)>1.5 & table1$FDR<0.05,"entrez"], ont="MF", pvalueCutoff= 0.05, 
               pAdjustMethod = "fdr", universe = table1$entrez, OrgDb = org.Hs.eg.db, readable = T)
GO_BP = GO_BP[GO_BP@result$p.adjust < 0.05, asis=T]
GO_CC = GO_CC[GO_CC@result$p.adjust < 0.05, asis=T]
GO_MF = GO_MF[GO_MF@result$p.adjust < 0.05, asis=T]
res_all=list()
if (nrow(GO_BP@result)!=0) {
  GO_BP@result$GO_domain="biological_process"
  res_all=list.append(res_all,GO_BP@result)
}
if (nrow(GO_CC@result)!=0) {
  GO_CC@result$GO_domain="cellular_component"
  res_all=list.append(res_all,GO_CC@result)
}
if (nrow(GO_MF@result)!=0) {
  GO_MF@result$GO_domain="molecular_function"
  res_all=list.append(res_all,GO_MF@result)
}
GO=rbind(GO_BP@result,GO_CC@result,GO_MF@result)
write.csv(GO,paste0(output_dir,"/Gene_ontology/GO_fc1.5_pv0.05.csv"),row.names = F)

# treemap
print("#### Treemap ####")
library(treemap)
tree_all=list()
for (i in 1:length(res_all)) {
  tree=res_all[[i]][,c(2,9)]
  tree$namespace_1003=res_all[[i]][1,10]
  tree_all=list.append(tree_all,tree)
}
all=data.frame(matrix(ncol = ncol(tree_all[[1]]), nrow = 0))
colnames(all) <- colnames(tree_all[[1]])
for (i in 1:length(tree_all)) {all=merge(all,tree_all[[i]],all.x=T,all.y=T)}
pdf(paste0(output_dir,"/Gene_ontology/treemap_GO_fc1.5_pv0.05.pdf"),12,10)
treemap(all,index=c("namespace_1003","Description"),vSize="Count",type="categorical",
        inflate.labels = TRUE,vColor = "namespace_1003",fontsize.labels = c(0,10),
        title="GO |Fold-Change|> 1.5 and pvalue<.05",title.legend = "Legend",
        lowerbound.cex.labels =0,
        palette=c("lightpink","skyblue","lightgreen"))
dev.off()
png(paste0(output_dir,"/Gene_ontology/treemap_GO_fc1.5_pv0.05.png"),1200, 1000, pointsize=20,res=120)
treemap(all,index=c("namespace_1003","Description"),vSize="Count",type="categorical",
        inflate.labels = TRUE,vColor = "namespace_1003",fontsize.labels = c(0,10),
        title="GO |Fold-Change|> 1.5 and pvalue<.05",title.legend = "Legend",
        lowerbound.cex.labels =0,
        palette=c("lightpink","skyblue","lightgreen"))
dev.off()
svg(paste0(output_dir,"/Gene_ontology/treemap_GO_fc1.5_pv0.05.svg"),12, 10)
treemap(all,index=c("namespace_1003","Description"),vSize="Count",type="categorical",
        inflate.labels = TRUE,vColor = "namespace_1003",fontsize.labels = c(0,10),
        title="GO |Fold-Change|> 1.5 and pvalue<.05",title.legend = "Legend",
        lowerbound.cex.labels =0,
        palette=c("lightpink","skyblue","lightgreen"))
dev.off()

# GO tables for genes
print("#### GO tables for genes ####")
GO_gene=list()
for (j in 1:length(res_all)) {
  gene=c()
  go=c()
  a=res_all[[j]]$geneID
  for (i in 1:length(a)) {
    b=unlist(strsplit(a[i], split="/"))
    gene=c(gene,b)
    go=c(go,rep(res_all[[j]]$Description[i],length(b)))
  }
  tab=data.frame(Gene=gene,GO=go)
  y=table1[,c(1,2,3)]
  tab1=merge(tab,y,all.x=T,all.y=F)
  tab1=tab1[order(tab1$GO),]
  tab1$GO_domain=res_all[[j]][1,10]
  GO_gene=list.append(GO_gene,tab1)
}
tab_all=do.call("rbind", GO_gene)
write.csv(tab_all,paste0(output_dir,"/Gene_ontology/tab_GO_genes.csv"),row.names = F)

# dotplot
print("#### Dotplot ####")
if (nrow(GO_BP@result)!=0) {
  pdf(paste0(output_dir,"/Gene_ontology/dotplot_GO_BP.pdf"),10,8)
  print(dotplot(GO_BP, showCategory=max_c, title = "Enriched GO for Biological Process"))
  dev.off()
  png(paste0(output_dir,"/Gene_ontology/dotplot_GO_BP.png"),1000, 800, pointsize=20,res=120)
  print(dotplot(GO_BP, showCategory=max_c, title = "Enriched GO for Biological Process"))
  dev.off()
  svg(paste0(output_dir,"/Gene_ontology/dotplot_GO_BP.svg"),10, 8)
  print(dotplot(GO_BP, showCategory=max_c, title = "Enriched GO for Biological Process"))
  dev.off()
}

if (nrow(GO_CC@result)!=0) {
  pdf(paste0(output_dir,"/Gene_ontology/dotplot_GO_CC.pdf"),10,8)
  print(dotplot(GO_CC, showCategory=max_c, title = "Enriched GO for Cellular Component"))
  dev.off()
  png(paste0(output_dir,"/Gene_ontology/dotplot_GO_CC.png"),1000, 800, pointsize=20,res=120)
  print(dotplot(GO_CC, showCategory=max_c, title = "Enriched GO for Cellular Component"))
  dev.off()
  svg(paste0(output_dir,"/Gene_ontology/dotplot_GO_CC.svg"),10, 8)
  print(dotplot(GO_CC, showCategory=max_c, title = "Enriched GO for Cellular Component"))
  dev.off()
}

if (nrow(GO_MF@result)!=0) {
  pdf(paste0(output_dir,"/Gene_ontology/dotplot_GO_MF.pdf"),10,8)
  print(dotplot(GO_MF, showCategory=max_c, title = "Enriched GO for Molecular Function"))
  dev.off()
  png(paste0(output_dir,"/Gene_ontology/dotplot_GO_MF.png"),1000, 800, pointsize=20,res=120)
  print(dotplot(GO_MF, showCategory=max_c, title = "Enriched GO for Molecular Function"))
  dev.off()
  svg(paste0(output_dir,"/Gene_ontology/dotplot_GO_MF.svg"),10, 8)
  print(dotplot(GO_MF, showCategory=max_c, title = "Enriched GO for Molecular Function"))
  dev.off()
}

#cnetplot
print("#### Cnetplot ####")
prov=y[order(y$logFC,decreasing = T),]
prov=prov[!duplicated(prov$Gene), ]
prov=prov[!is.na(prov$Gene), ]
rownames(prov)=prov$Gene

geneList=prov$logFC
names(geneList)=prov$Gene

min=-(round(((max(abs(geneList))+1)-1),1))
max=round(((max(abs(geneList))+1)+1),1)

if (nrow(GO_BP@result)!=0) {
  pdf(paste0(output_dir,"/Gene_ontology/cnetplot_GO_BP.pdf"),10,8)
  print(cnetplot(GO_BP,foldChange = geneList,showCategory = max_c,categorySize="pvalue"))
  dev.off()
  png(paste0(output_dir,"/Gene_ontology/cnetplot_GO_BP.png"),1000, 800, pointsize=20,res=100)
  print(cnetplot(GO_BP,foldChange = geneList,showCategory = max_c,categorySize="pvalue"))
  dev.off()
  svg(paste0(output_dir,"/Gene_ontology/cnetplot_GO_BP.svg"),10, 8)
  print(cnetplot(GO_BP,foldChange = geneList,showCategory = max_c,categorySize="pvalue"))
  dev.off()
}

if (nrow(GO_CC@result)!=0) {
  pdf(paste0(output_dir,"/Gene_ontology/cnetplot_GO_CC.pdf"),10,8)
  print(cnetplot(GO_CC,foldChange = geneList,showCategory = max_c,categorySize="pvalue"))
  dev.off()
  png(paste0(output_dir,"/Gene_ontology/cnetplot_GO_CC.png"),1000, 800, pointsize=20,res=100)
  print(cnetplot(GO_CC,foldChange = geneList,showCategory = max_c,categorySize="pvalue"))
  dev.off()
  svg(paste0(output_dir,"/Gene_ontology/cnetplot_GO_CC.svg"),10, 8)
  print(cnetplot(GO_CC,foldChange = geneList,showCategory = max_c,categorySize="pvalue"))
  dev.off()
}

if (nrow(GO_MF@result)!=0) {
  pdf(paste0(output_dir,"/Gene_ontology/cnetplot_GO_MF.pdf"),10,8)
  print(cnetplot(GO_MF,foldChange = geneList,showCategory = max_c,categorySize="pvalue"))
  dev.off()
  png(paste0(output_dir,"/Gene_ontology/cnetplot_GO_MF.png"),1000, 800, pointsize=20,res=100)
  print(cnetplot(GO_MF,foldChange = geneList,showCategory = max_c,categorySize="pvalue"))
  dev.off()
  svg(paste0(output_dir,"/Gene_ontology/cnetplot_GO_MF.svg"),10, 8)
  print(cnetplot(GO_MF,foldChange = geneList,showCategory = max_c,categorySize="pvalue"))
  dev.off()
}


##############################################
######## Pathway enrichment analysis #########
##############################################

print("########### Pathway enrichment analysis  ###########")

gene=table1[abs(table1$logFC)>1.5 & table1$FDR<0.05,"entrez"]
tmp=table1[order(table1$logFC,decreasing = T),]
genelist=tmp$logFC
names(genelist)=tmp$Gene


#################################### REACTOME ####################################
library(ReactomePA)
ep <- enrichPathway(
  gene,
  organism = "human",
  pvalueCutoff = 0.05,
  pAdjustMethod = "BH",
  qvalueCutoff = 0.2,
  minGSSize = 10,
  maxGSSize = 500,
  readable = TRUE
)

ep <- setReadable(ep, OrgDb = org.Hs.eg.db,keyType = "ENTREZID")
ep = ep[ep@result$p.adjust < 0.05, asis=T]
write.csv(ep@result,paste0(output_dir,"/Pathway_analysis/reactome/pathway_FC1.5_pv0.05.csv"),row.names = T)


if (nrow(ep@result)>1) {
tmp2<-tmp[!duplicated(tmp[,"entrez"]),]
genelist=tmp2$logFC
names(genelist)=tmp2$entrez
rm(tmp2)

if (nrow(ep@result)>=10) {
for (i in 1:10) {
  pdf(paste(output_dir,"/Pathway_analysis/reactome/",ep@result$ID[i], ".pdf", sep=""),10,8)
  print(viewPathway(ep@result$Description[i], readable = TRUE, foldChange = genelist))
  dev.off()
}
} else {
for (i in nrow(ep@result)) {
  pdf(paste(output_dir,"/Pathway_analysis/reactome/",ep@result$ID[i], ".pdf", sep=""),10,8)
  print(viewPathway(ep@result$Description[i], readable = TRUE, foldChange = genelist))
  dev.off()
}
}


#dotplot
print("#### Dotplot ####")
pdf(paste0(output_dir,"/Pathway_analysis/reactome/dotplot_pathways.pdf"),10,8)
print(dotplot(ep,showCategory=max_c, title = "Enriched pathways"))
dev.off()
png(paste0(output_dir,"/Pathway_analysis/reactome/dotplot_pathways.png"),1000, 800, pointsize=20,res=120)
print(dotplot(ep,showCategory=max_c, title = "Enriched pathways"))
dev.off()
svg(paste0(output_dir,"/Pathway_analysis/reactome/dotplot_pathways.svg"),10, 8)
print(dotplot(ep,showCategory=max_c, title = "Enriched pathways"))
dev.off()

#cnetplot
print("#### Cnetplot ####")
pdf(paste0(output_dir,"/Pathway_analysis/reactome/cnetplot_pathways.pdf"),10,8)
print(cnetplot(ep,foldChange = geneList,showCategory = max_c,categorySize="pvalue"))
dev.off()
png(paste0(output_dir,"/Pathway_analysis/reactome/cnetplot_pathways.png"),1000, 800, pointsize=20,res=100)
print(cnetplot(ep,foldChange = geneList,showCategory = max_c,categorySize="pvalue"))
dev.off()
svg(paste0(output_dir,"/Pathway_analysis/reactome/cnetplot_pathways.svg"),10, 8)
print(cnetplot(ep,foldChange = geneList,showCategory = max_c,categorySize="pvalue"))
dev.off()

# #pathview
# print("#### Pathview ####")
# library(pathview)
# new_data=table1[,c("logFC","entrez")]
# new_data=new_data[!duplicated(new_data$entrez), ]
# new_data=new_data[!is.na(new_data$entrez), ]
# rownames(new_data)=new_data$entrez
# new_data=new_data[,-2,drop=F]
# setwd(paste0(output_dir,"/Pathway_analysis/pathview"))
# tmp = sapply(kk@result$ID, function(pid) tryCatch(pathview(gene.data=new_data, pathway.id=pid, species="hsa",
#                                                            low="dodgerblue",high="firebrick1",mid="gray88"),error=function(e) NULL))



# histogram path
if (nrow(ep@result)>=30) {
  names=as.character(ep@result$Description[1:30])
} else {
  names=as.character(ep@result$Description[1:nrow(ep@result)])
}
p=list()
for (i in 1:length(names)) {
  p=list.append(p,table1[table1$Gene %in% 
                           strsplit(as.character(
                             ep@result$geneID[ep@result$Description==names[i]]),"/")[[1]],])
}
for (i in 1:length(p)) {p[[i]]$path=names[i]}
p1=data.frame()
for (i in 1:length(p)) {p1=rbind(p1,p[[i]])}
p_go=p1[p1$FDR<0.05 & abs(p1$logFC)>1.5,]
p_go$fc=ifelse(p_go$logFC>=0,"up-regulated","down-regulated")
p_go=p_go[!is.na(p_go$Gene),c("Gene","path","fc","logFC")]
plotting_df <-
  p_go %>% 
  group_by(path, fc) %>% 
  summarise(Freq = n()) %>% 
  mutate(Freq = if_else(fc == "down-regulated", -Freq, Freq))
the_order <- names
if (max(abs(plotting_df$Freq))>10) {by_step=5} else {by_step=2}
q <- 
  plotting_df %>% 
  ggplot(aes(x = path, y = Freq, fill= fc)) +
  geom_bar(stat = "identity", width = 0.75) +
  coord_flip() +
  scale_x_discrete(limits = rev(the_order)) +
  scale_y_continuous(breaks = seq(-300, 300, by_step), 
                     labels = abs(seq(-300, 300, by_step))) +
  labs(x = "Pathway", y = "Gene count", title = "\nPathways\n", fill="") +
  theme(legend.position = "bottom",
        plot.title = element_text(hjust = 0.5,face = "bold", size = 16),
        panel.background = element_rect(fill =  "grey90")) +
  scale_fill_manual(values = c("down-regulated"="dodgerblue1", "up-regulated"="firebrick2"))

pdf(paste0(output_dir,"/Pathway_analysis/reactome/hist_pathway.pdf"),10,6)
print(q)
dev.off()
png(paste0(output_dir,"/Pathway_analysis/reactome/hist_pathway.png"),width = 10, height = 6, 
    units = 'in', res = 300)
print(q)
dev.off()
svg(paste0(output_dir,"/Pathway_analysis/reactome/hist_pathway.svg"),10, 6)
print(q)
dev.off()
}


#################################### KEGG ####################################
kk=enrichMKEGG(gene=gene, organism='hsa', pvalueCutoff = 0.05, pAdjustMethod = "fdr", 
              universe=table1$entrez)
kk <- setReadable(kk, OrgDb = org.Hs.eg.db,keyType = "ENTREZID")
kk = kk[kk@result$p.adjust < 0.05, asis=T]
write.csv(kk@result,paste0(output_dir,"/Pathway_analysis/kegg/pathway_FC1.5_pv0.05.csv"),row.names = T)


if (nrow(kk@result)>1) {
#dotplot
print("#### Dotplot ####")
pdf(paste0(output_dir,"/Pathway_analysis/kegg/dotplot_pathways.pdf"),10,8)
print(dotplot(kk,showCategory=max_c, title = "Enriched pathways"))
dev.off()
png(paste0(output_dir,"/Pathway_analysis/kegg/dotplot_pathways.png"),1000, 800, pointsize=20,res=120)
print(dotplot(kk,showCategory=max_c, title = "Enriched pathways"))
dev.off()
svg(paste0(output_dir,"/Pathway_analysis/kegg/dotplot_pathways.svg"),10, 8)
print(dotplot(kk,showCategory=max_c, title = "Enriched pathways"))
dev.off()

#cnetplot
print("#### Cnetplot ####")
pdf(paste0(output_dir,"/Pathway_analysis/kegg/cnetplot_pathways.pdf"),10,8)
print(cnetplot(kk,foldChange = geneList,showCategory = max_c,categorySize="pvalue"))
dev.off()
png(paste0(output_dir,"/Pathway_analysis/kegg/cnetplot_pathways.png"),1000, 800, pointsize=20,res=100)
print(cnetplot(kk,foldChange = geneList,showCategory = max_c,categorySize="pvalue"))
dev.off()
svg(paste0(output_dir,"/Pathway_analysis/kegg/cnetplot_pathways.svg"),10, 8)
print(cnetplot(kk,foldChange = geneList,showCategory = max_c,categorySize="pvalue"))
dev.off()

# #pathview
# print("#### Pathview ####")
# library(pathview)
# new_data=table1[,c("logFC","entrez")]
# new_data=new_data[!duplicated(new_data$entrez), ]
# new_data=new_data[!is.na(new_data$entrez), ]
# rownames(new_data)=new_data$entrez
# new_data=new_data[,-2,drop=F]
# setwd(paste0(output_dir,"/Pathway_analysis/pathview"))
# tmp = sapply(kk@result$ID, function(pid) tryCatch(pathview(gene.data=new_data, pathway.id=pid, species="hsa",
#                                                            low="dodgerblue",high="firebrick1",mid="gray88"),error=function(e) NULL))


# histogram go
print("#### Histogram ####")

for (j in 1:length(unique(tab_all$GO_domain))) {
  if (nrow(GO[GO$GO_domain==unique(tab_all$GO_domain)[j],])>=30) {
    names=as.character(GO$Description[GO$GO_domain==unique(tab_all$GO_domain)[j]][1:30])
  } else {
    names=as.character(GO$Description[GO$GO_domain==unique(tab_all$GO_domain)[j]][1:nrow(GO[GO$GO_domain==unique(tab_all$GO_domain)[j],])])
  }
  p=tab_all[tab_all$GO %in% names,]
  p1=p[p$FDR<0.05 & abs(p$logFC)>1.5,]
  p1$fc=ifelse(p1$logFC>=0,"up-regulated","down-regulated")
  p1=p1[!is.na(p1$Gene),c("Gene","GO","fc","logFC")]
  
  plotting_df <-
    p1 %>% 
    group_by(GO, fc) %>% 
    summarise(Freq = n()) %>% 
    mutate(Freq = if_else(fc == "down-regulated", -Freq, Freq))
  the_order <- names
  if (max(abs(plotting_df$Freq))>10) {by_step=5} else {by_step=2}
  q <- 
    plotting_df %>% 
    ggplot(aes(x = GO, y = Freq, fill= fc)) +
    geom_bar(stat = "identity", width = 0.75) +
    coord_flip() +
    scale_x_discrete(limits = rev(the_order)) +
    scale_y_continuous(breaks = seq(-300, 300, by_step), 
                       labels = abs(seq(-300, 300, by_step))) +
    labs(x = "GO", y = "Gene count", title = "\nGene Ontology", fill="",
         subtitle = paste0(unique(tab_all$GO_domain)[j],"\n")) +
    theme(legend.position = "bottom",
          plot.title = element_text(hjust = 0.5,face = "bold", size = 16),
          plot.subtitle = element_text(hjust = 0.5,face = "bold", size = 12),
          panel.background = element_rect(fill =  "grey90")) +
    scale_fill_manual(values = c("down-regulated"="dodgerblue1", "up-regulated"="firebrick2"))
  
  pdf(paste0(output_dir,"/Gene_ontology/hist_",unique(tab_all$GO_domain)[j],".pdf"),10,6)
  print(q)
  dev.off()
  png(paste0(output_dir,"/Gene_ontology/hist_",unique(tab_all$GO_domain)[j],".png"),
      width = 10, height = 6, units = 'in', res = 300)
  print(q)
  dev.off()
  svg(paste0(output_dir,"/Gene_ontology/hist_",unique(tab_all$GO_domain)[j],".svg"),10,6)
  print(q)
  dev.off()
}

# histogram path
if (nrow(kk@result)>=30) {
  names=as.character(kk@result$Description[1:30])
} else {
  names=as.character(kk@result$Description[1:nrow(kk@result)])
}
p=list()
for (i in 1:length(names)) {
  p=list.append(p,table1[table1$Gene %in% 
                           strsplit(as.character(
                             kk@result$geneID[kk@result$Description==names[i]]),"/")[[1]],])
}
for (i in 1:length(p)) {p[[i]]$path=names[i]}
p1=data.frame()
for (i in 1:length(p)) {p1=rbind(p1,p[[i]])}
p_go=p1[p1$FDR<0.05 & abs(p1$logFC)>1.5,]
p_go$fc=ifelse(p_go$logFC>=0,"up-regulated","down-regulated")
p_go=p_go[!is.na(p_go$Gene),c("Gene","path","fc","logFC")]
plotting_df <-
  p_go %>% 
  group_by(path, fc) %>% 
  summarise(Freq = n()) %>% 
  mutate(Freq = if_else(fc == "down-regulated", -Freq, Freq))
the_order <- names
if (max(abs(plotting_df$Freq))>10) {by_step=5} else {by_step=2}
q <- 
  plotting_df %>% 
  ggplot(aes(x = path, y = Freq, fill= fc)) +
  geom_bar(stat = "identity", width = 0.75) +
  coord_flip() +
  scale_x_discrete(limits = rev(the_order)) +
  scale_y_continuous(breaks = seq(-300, 300, by_step), 
                     labels = abs(seq(-300, 300, by_step))) +
  labs(x = "Pathway", y = "Gene count", title = "\nPathways\n", fill="") +
  theme(legend.position = "bottom",
        plot.title = element_text(hjust = 0.5,face = "bold", size = 16),
        panel.background = element_rect(fill =  "grey90")) +
  scale_fill_manual(values = c("down-regulated"="dodgerblue1", "up-regulated"="firebrick2"))

pdf(paste0(output_dir,"/Pathway_analysis/kegg/hist_pathway.pdf"),10,6)
print(q)
dev.off()
png(paste0(output_dir,"/Pathway_analysis/kegg/hist_pathway.png"),width = 10, height = 6, 
    units = 'in', res = 300)
print(q)
dev.off()
svg(paste0(output_dir,"/Pathway_analysis/kegg/hist_pathway.svg"),10, 6)
print(q)
dev.off()
}
