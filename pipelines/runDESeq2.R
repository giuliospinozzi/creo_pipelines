#!/usr/bin/env Rscript
args <- commandArgs(trailingOnly=TRUE)

featCounts <- args[1]
input <- args[2]
output_dir <- args[3]

setwd(output_dir)

# Import data from featureCounts
countdata1 <- read.table(featCounts, header=TRUE, row.names=1,sep = "\t")
lenth_genes <- countdata1[ ,5,drop=F]
countdata <- countdata1[ ,6:ncol(countdata1)]
input_table <- read.csv(input,sep=",")
for (i in 1:nrow(input_table)) {
  colnames(countdata)[grep(input_table$sample_name[i],colnames(countdata))] <- as.character(input_table$sample_name[i])
}

# Convert to matrix
countdata <- as.matrix(countdata)

# experimental design
type <- c()
for (k in 1:ncol(countdata)) {
  type <- c(type,as.character(input_table$Type[grep(colnames(countdata)[k],input_table$sample_name)]))
}
DataGroups <- factor(type)
DataGroups <- relevel(DataGroups,ref="cntrl")

library(DESeq2)

# Create a coldata frame and instantiate the DESeqDataSet
coldata <- data.frame(row.names=colnames(countdata), DataGroups)
dds <- DESeqDataSetFromMatrix(countData=countdata, colData=coldata, design=~DataGroups)

# PCA
library(ggfortify)
mcols(dds)$basepairs <- as.matrix(lenth_genes)
fpkm <- fpkm(dds)
pca_des <- rbind(fpkm,type=as.character(DataGroups))
png("deseq2-pca.png", w=1000, h=1000, pointsize=20)
autoplot(prcomp(log2((t(fpkm))+1)),data=t(pca_des), colour="type", main="PCA",size=4)+ 
  theme(plot.title = element_text(face="bold",hjust=0.5,size=20),legend.text=element_text(size=12),
        legend.title=element_blank(),axis.text = element_text(size=12))
dev.off()

# Run the DESeq pipeline
dds <- DESeq(dds)

# Regularized log transformation for clustering/heatmaps, etc
rld <- rlogTransformation(dds)

# Get differential expression results
res <- results(dds)
res <- res[order(res$padj), ]
## Merge with normalized count data
resdata <- merge(as.data.frame(res), as.data.frame(fpkm), by="row.names", sort=FALSE)
names(resdata)[1] <- "Gene"
## Write results
write.csv(resdata, file="deseq2-diffexpr-results.csv")

## Volcano plot
volcanoplot <- function (res, lfcthresh=2, sigthresh=0.05, main="Volcano Plot", legendpos="bottomright", labelsig=TRUE, textcx=1, ...) {
  with(res, plot(log2FoldChange, -log10(pvalue), pch=20, main=main, ...))
  with(subset(res, padj<sigthresh ), points(log2FoldChange, -log10(pvalue), pch=20, col="red", ...))
  with(subset(res, abs(log2FoldChange)>lfcthresh), points(log2FoldChange, -log10(pvalue), pch=20, col="orange", ...))
  with(subset(res, padj<sigthresh & abs(log2FoldChange)>lfcthresh), points(log2FoldChange, -log10(pvalue), pch=20, col="green", ...))
  if (labelsig) {
    require(calibrate)
    with(subset(res, padj<sigthresh & abs(log2FoldChange)>lfcthresh), textxy(log2FoldChange, -log10(pvalue), labs=Gene, cex=textcx, ...))
  }
  legend(legendpos, xjust=1, yjust=1, legend=c(paste("FDR<",sigthresh,sep=""), paste("|LogFC|>",lfcthresh,sep=""), "both"), pch=20, col=c("red","orange","green"))
}
png("deseq2-volcanoplot.png", 1200, 1000, pointsize=20)
volcanoplot(resdata, textcx=.6)
dev.off()

# heatmap topgenes
library(genefilter)
library(RColorBrewer)
library(gplots)
topVarGenes <- head( order( rowVars( fpkm ), decreasing=TRUE ), 35 )
png("deseq2-heatmap-topVarGenes.png", w=1000, h=1000, pointsize=20)
heatmap.2( fpkm[ topVarGenes, ], cexCol=0.75, cexRow=0.7, offsetRow=-0.4, offsetCol=-0.4, scale="row", trace="none", dendrogram="column", col = colorRampPalette( rev(brewer.pal(9, "RdBu")) )(255))
dev.off()

# Sample distance heatmap
mycols <- brewer.pal(8, "Dark2")[1:length(unique(DataGroups))]
sampleDists <- as.matrix(dist(t(assay(rld))))
png("deseq2-heatmap-samples.png", w=1000, h=1000, pointsize=20)
heatmap.2(as.matrix(sampleDists), key=F, trace="none",
          col=colorpanel(100, "black", "white"),
          ColSideColors=mycols[DataGroups], RowSideColors=mycols[DataGroups],
          margin=c(10, 10), main="Sample Distance Matrix")
dev.off()
