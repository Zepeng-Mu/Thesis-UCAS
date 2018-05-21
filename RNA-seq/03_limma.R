library(tidyverse)
library(limma)
library(gplots)

#### load data ####
ctrl = read.table("~/Documents/study/biology/labs/ZengLab/thesis/data/HTcountCtrl.txt",
                  header = F,
                  stringsAsFactors = F)
b4 = read.table("~/Documents/study/biology/labs/ZengLab/thesis/data/HTcountB4.txt",
                header = F,
                stringsAsFactors = F)
c9 = read.table("~/Documents/study/biology/labs/ZengLab/thesis/data/HTcountC9.txt",
           header = F,
           stringsAsFactors = F)

myCount = cbind(ctrl, b4$V2, c9$V2)
colnames(myCount) = c("gene_id", "Ctrl", "KO.1", "KO.2")
geneID = ctrl$V1
rm(ctrl, b4, c9)

ensembl2gene = read.csv("~/Documents/study/biology/labs/ZengLab/thesis/data/fullEnsembl2gene.csv",
                        header = T,
                        stringsAsFactors = F)
ensembl2gene = ensembl2gene[!duplicated(ensembl2gene$Gene.name), ]
myCount = left_join(myCount, select(ensembl2gene, Gene.stable.ID, Gene.name), by = c("gene_id" = "Gene.stable.ID"))

myCount = myCount[complete.cases(myCount), ]
rownames(myCount) = myCount$Gene.name
myCount = select(myCount, Ctrl, KO.1, KO.2)

#### Data pre-processing ####
cells = data.frame(status = c("Ctrl", "KO", "KO"))

dge = DGEList(myCount)
logCPM = cpm(dge, log = T)

table(rowSums(dge$counts == 0) == 3)
dim(logCPM)

## density before filtering
pdf(file = "~/Box/论文草稿/fig/beforeFilter.pdf", height = 5, width = 5)
myCol = c("red", "orange", "green")
for (i in 1:ncol(logCPM)) {
  if (i == 1) {
    plot(density(logCPM[, i]), col = myCol[i],
         main = "", xlab = "logCPM")
  }else{
    lines(density(logCPM[, i]), col = myCol[i])
  }
}
legend("topright", legend = c("Ctrl", "KO.1", "KO.2"), lty = 1, col = myCol)
dev.off()

keep = logCPM[, 1] > 0 | rowSums(logCPM[, 2:3] > 0) >= 1
dge = dge[keep,, keep.lib.sizes = F]
logCPM = cpm(dge, log = T)

dim(logCPM)

## density after filtering
pdf(file = "~/Box/论文草稿/fig/afterFilter.pdf", height = 5, width = 5)
myCol = c("red", "orange", "green")
for (i in 1:ncol(logCPM)) {
  if (i == 1) {
    plot(density(logCPM[, i]), col = myCol[i], ylim = c(0, 0.2),
         main = "", xlab = "logCPM")
  }else{
    lines(density(logCPM[, i]), col = myCol[i])
  }
}
legend("topright", legend = c("Ctrl", "KO.1", "KO.2"), lty = 1, col = myCol)
dev.off()

boxplot(logCPM, col = myCol, ylab = "logCPM")
dge = calcNormFactors(dge, method = "TMM")
logCPM = cpm(dge, log = T)
dim(logCPM)

## density after normalization
myCol = c("red", "orange", "green")
boxplot(logCPM, col = myCol, ylab = "logCPM")
for (i in 1:ncol(logCPM)) {
  if (i == 1) {
    plot(density(logCPM[, i]), col = myCol[i], ylim = c(0, 0.3))
  }else{
    lines(density(logCPM[, i]), col = myCol[i])
  }
}
toGSEA = select(as.data.frame(logCPM), Ctrl, KO.1, KO.2)
toGSEA = mutate(toGSEA, NAME = rownames(logCPM), DESCRIPTION = "na")
toGSEA = select(toGSEA, NAME, DESCRIPTION, Ctrl, KO.1, KO.2)
write.table(toGSEA, "~/Documents/study/biology/labs/ZengLab/thesis/data/eGeneGSEA.txt",
            row.names = F,
            quote = F,
            sep = "\t")

#### Fit ####
## trend
group = paste(cells$cell.line, cells$status, sep = ".")
group = factor(group)
designMtrx = model.matrix(~group)
colnames(designMtrx) = levels(group)

fit = lmFit(logCPM, designMtrx)
efit = eBayes(fit, robust = T)
eGenes = topTable(efit, n = Inf, sort.by = "p", coef = ncol(designMtrx))
eGenes$Gene.name = rownames(eGenes)
eGenes = left_join(eGenes, select(ensembl2gene, Chromosome.scaffold.name, Gene.name), by = "Gene.name")
eGenes$BH = (seq(1, nrow(eGenes)) / nrow(eGenes)) * 0.05
toGSEA = data.frame(NAME = eGenes$Gene.name, SCORE = -log10(eGenes$P.Value))
write.table(toGSEA, "~/Documents/study/biology/labs/ZengLab/thesis/data/newpreranked_eGenes.rnk",
            col.names = F,
            row.names = F,
            quote = F,
            sep = "\t")
ciseGenes = filter(eGenes, Chromosome.scaffold.name == 9)
sigCiseGenes = filter(ciseGenes, (logFC > FCcutoff | logFC < -FCcutoff) & P.Value < 0.05)

## Volcano plot
FCcutoff = 1
myCol = ifelse(eGenes$P.Value > 0.05,
               "blue",
               ifelse(eGenes$logFC > FCcutoff & eGenes$P.Value < 0.05, "red",
                      ifelse(eGenes$logFC < -FCcutoff & eGenes$P.Value < 0.05, "green", "orange")))
plot(eGenes$logFC, -log10(eGenes$P.Value),
     pch = 16,
     cex = 0.4,
     col = myCol,
     xlim = c(-6, 6),
     xlab = "log fold change",
     ylab = "-log10(P)")
abline(v = c(-FCcutoff, FCcutoff), lwd = 1.5, lty = 2)
abline(h = -log10(0.05), lwd = 1.5, lty = 2)

## Heatmap
par()
FCcutoff = 1
sigGene = filter(eGenes, (logFC > FCcutoff | logFC < -FCcutoff) & P.Value < 0.05)
logCPM = as.data.frame(logCPM)
logCPM$Gene.name = rownames(logCPM)
heatDf = filter(logCPM, rownames(logCPM) %in% sigGene$Gene.name)
rownames(heatDf) = heatDf$Gene.name
heatDf = heatDf[, 1:3]
col.pan = colorpanel(100, "blue", "white", "red")
pdf(file = "~/Box/论文草稿/fig/heatmapFinal.pdf", height = 5, width = 5)
heatmap.2(as.matrix(heatDf[1:100,]),
          col = col.pan,
          scale = "row",
          trace = "none",
          srtCol = 45,
          labRow = NA,
          keysize = 1,
          cexCol = 1,
          density.info = "none",
          lhei = c(1.5,4), lwid = c(2,4))
dev.off()
