#!/usr/bin/env Rscript
args <- commandArgs(trailingOnly=TRUE)

featCounts <- args[1]
input <- args[2]
output_dir <- args[3]

setwd(output_dir)

library(edgeR)
# Import data from featureCounts
countdata1 <- read.table(featCounts, header=TRUE, row.names=1,sep = "\t")
lenth_genes <- countdata1[ ,5,drop=F]
countdata <- countdata1[ ,6:ncol(countdata1)]
input_table <- read.csv(input,sep=",")
for (i in 1:nrow(input_table)) {
  colnames(countdata)[grep(input_table$sample_name[i],colnames(countdata))] <- as.character(input_table$sample_name[i])
}

# experimental design
type <- c()
for (k in 1:ncol(countdata)) {
  type <- c(type,as.character(input_table$Type[grep(colnames(countdata)[k],input_table$sample_name)]))
}
DataGroups <- factor(type)
DataGroups <- relevel(DataGroups,ref="cntrl")

# create DGE object of edgeR
dgList <- DGEList(counts=countdata,group=factor(DataGroups),genes = lenth_genes)

# PCA
library(ggfortify)
fpkm <- rpkm(dgList)
pca <- rbind(fpkm,type=as.character(DataGroups))
png("edgeR-pca.png", w=1000, h=1000, pointsize=30)
autoplot(prcomp(log2((t(fpkm))+1)),data=t(pca), colour="type", main="PCA",size=10)+ 
  theme(plot.title = element_text(face="bold",hjust=0.5,size=50),legend.text=element_text(size=30),
        legend.title=element_blank(),axis.text = element_text(size=30),
        axis.title=element_text(size=30)) +geom_text(aes(label=colnames(fpkm)),size=10)
dev.off()

# filter data to retain genes that are represented at least 1 counts per million (cpm) in at least 2 samples
countsPerMillion <- cpm(dgList)
countCheck <- countsPerMillion > 1
keep <- which(rowSums(countCheck) >= 2)
dgList <- dgList[keep,]
dgList$samples$lib.size <- colSums(dgList$counts)

# normalization using TMM method
dgList <- calcNormFactors(dgList, method="TMM")

# Dispersion estimates
design.mat <- model.matrix(~ 0 + dgList$samples$group)
colnames(design.mat) <- levels(dgList$samples$group)
dgList <- estimateGLMCommonDisp(dgList,design.mat)
dgList <- estimateGLMTrendedDisp(dgList,design.mat, method="power")
dgList <- estimateGLMTagwiseDisp(dgList,design.mat)

# Differential expression analysis
fit <- glmFit(dgList, design.mat)
lrt <- glmLRT(fit, contrast=c(-1,1))
edgeR_results <- topTags(lrt, n=Inf)
resdata <- merge(as.data.frame(edgeR_results), as.data.frame(fpkm), by="row.names")
names(resdata)[1] <- "Gene"
resdata <- resdata[order(resdata$FDR), ]
resdata[resdata$PValue==0|resdata$FDR==0,c("PValue","FDR")]=0.1e-320
write.csv(resdata,"edgeR-diffexpr-results.csv")

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
colnames(resdata)[c(3,7)]=c("log2FoldChange","padj")
png("edgeR-volcanoplot.png", 1200, 1000, pointsize=20)
volcanoplot(resdata, textcx = .6)
dev.off()

# heatmap topgenes
library(gplots)
library(RColorBrewer)
library(genefilter)
topVarGenes <- head( order( rowVars( fpkm ), decreasing=TRUE ), 35 )
png("edgeR-heatmap-topVarGenes.png", w=1000, h=1000, pointsize=20)
heatmap.2( fpkm[ topVarGenes, ], cexCol=0.75, cexRow=0.7, offsetRow=-0.4, offsetCol=-0.4, 
           scale="row", trace="none", dendrogram="none", main="Top Variance Genes Heatmap",
           Colv=FALSE, col = colorRampPalette( rev(brewer.pal(9, "RdBu")) )(255))
dev.off()

# Sample distance heatmap
mycols <- brewer.pal(8, "Dark2")[1:length(unique(DataGroups))]
sampleDists <- as.matrix(dist(t(fpkm)))
png("edgeR-heatmap-samples.png", w=1000, h=1000, pointsize=20)
heatmap.2(as.matrix(sampleDists), key=F, trace="none",
          col=colorpanel(100, "black", "white"),
          ColSideColors=mycols[DataGroups], RowSideColors=mycols[DataGroups],
          margin=c(10, 10), main="Sample Distance Matrix")
dev.off()
