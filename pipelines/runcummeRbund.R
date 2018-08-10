#!/usr/bin/env Rscript
args <- commandArgs(trailingOnly=TRUE)

cuffdiff <- args[1]
input <- args[2]
output_dir <- args[3]

setwd(output_dir)

library(cummeRbund)
cuff_data <- readCufflinks(cuffdiff,rebuild = T)

# PCA
library(ggfortify)
input_table <- read.csv(input,sep=",")
DataGroups <- input_table$Type
fpkm <- repFpkmMatrix(genes(cuff_data))
pca <- rbind(fpkm,type=as.character(DataGroups))
png("cummeRbund-pca.png", w=1000, h=1000, pointsize=30)
autoplot(prcomp(log2((t(fpkm))+1)),data=t(pca), colour="type", main="PCA",size=10)+ 
  theme(plot.title = element_text(face="bold",hjust=0.5,size=50),legend.text=element_text(size=30),
        legend.title=element_blank(),axis.text = element_text(size=30),
        axis.title=element_text(size=30))
dev.off()

# #Retrive significant gene IDs (XLOC) with a pre-specified alpha
diffGeneIDs <- diffData(genes(cuff_data))
#Use returned identifiers to create a CuffGeneSet object with all relevant info for given genes
diffGenes <- cummeRbund::getGenes(cuff_data,diffGeneIDs$gene_id)

#gene_short_name values (and corresponding XLOC_* values) can be retrieved from the CuffGeneSet by using:
names <- featureNames(diffGenes)
row.names(names) <- names$tracking_id
diffGenesNames <- as.matrix(names)
diffGenesNames <- diffGenesNames[,-1]

# get the data for the significant genes
diffGenesData <- diffData(diffGenes)
row.names(diffGenesData) <- diffGenesData$gene_id
diffGenesData <- diffGenesData[,-1]

# merge the two matrices by row names
diffGenesOutput <- merge(diffGenesNames,diffGenesData,by="row.names")
rownames(diffGenesOutput) <- diffGenesOutput$Row.names
diffGenesOutput <- diffGenesOutput[,-1]
colnames(diffGenesOutput)[1] <- "Gene"
diffGenesOutput1 <- merge(diffGenesOutput,fpkm,by="row.names")
write.csv(diffGenesOutput1, file="cummeRbund-diffexpr-results.csv")

# volcano plot
volcanoplot <- function (res, lfcthresh=2, sigthresh=0.05, main="Volcano Plot", legendpos="bottomright", labelsig=TRUE, textcx=1, ...) {
  with(res, plot(log2FoldChange, -log10(padj), pch=20, main=main, ...))
  with(subset(res, padj<sigthresh ), points(log2FoldChange, -log10(padj), pch=20, col="red", ...))
  with(subset(res, abs(log2FoldChange)>lfcthresh), points(log2FoldChange, -log10(padj), pch=20, col="orange", ...))
  with(subset(res, padj<sigthresh & abs(log2FoldChange)>lfcthresh), points(log2FoldChange, -log10(padj), pch=20, col="green", ...))
  if (labelsig) {
    require(calibrate)
    with(subset(res, padj<sigthresh & abs(log2FoldChange)>lfcthresh), textxy(log2FoldChange, -log10(padj), labs=Gene, cex=textcx, ...))
  }
  legend(legendpos, xjust=1, yjust=1, legend=c(paste("FDR<",sigthresh,sep=""), paste("|LogFC|>",lfcthresh,sep=""), "both"), col=c("red","orange","green"),fill = c("red","orange","green"),bty = "o", xpd = T,cex=0.7,bg="white")
}
colnames(diffGenesOutput1)[c(8,10)]=c("log2FoldChange","padj")
png("cummeRbund-volcanoplot.png", 1200, 1000, pointsize=20)
volcanoplot(diffGenesOutput1, textcx=.6)
dev.off()

# heatmap topgenes
library(genefilter)
library(RColorBrewer)
library(gplots)
fpkm <- as.matrix(fpkm)
topVarGenes <- head( order( rowVars( fpkm ), decreasing=TRUE ), 35 )
rownames(diffGenesOutput1)=diffGenesOutput1$Row.names
lab <- as.character(diffGenesOutput1[rownames(fpkm[ topVarGenes, ]),"Gene"])
png("cummeRbund-heatmap-topVarGenes.png", w=1000, h=1000, pointsize=20)
heatmap.2( fpkm[ topVarGenes, ], cexCol=0.75, cexRow=0.7, offsetRow=-0.4, offsetCol=-0.4, scale="row", trace="none", dendrogram="column", col = colorRampPalette( rev(brewer.pal(9, "RdBu")) )(255),labRow = lab)
dev.off()

# Sample distance heatmap
mycols <- brewer.pal(8, "Dark2")[1:length(unique(DataGroups))]
sampleDists <- as.matrix(dist(t(fpkm)))
png("cummeRbund-heatmap-samples.png", w=1000, h=1000, pointsize=20)
heatmap.2(as.matrix(sampleDists), key=F, trace="none",
          col=colorpanel(100, "black", "white"),
          ColSideColors=mycols[DataGroups], RowSideColors=mycols[DataGroups],
          margin=c(10, 10), main="Sample Distance Matrix")
dev.off()
