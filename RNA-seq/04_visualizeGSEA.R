library(tidyverse)
"%&%" = function(a, b)paste(a, b, sep = " ")

report = read.table("~/Documents/study/biology/labs/ZengLab/thesis/data/gsea_c5bp.txt",
                   header = T,
                   stringsAsFactors = F,
                   sep = "\t")
report = report[1:20, ]
report = report[order(report$NOM.p.val, decreasing = T), ]

mypar = par(mar = c(5, 23, 4, 2))
barCol = rgb(0, 0.7, 1, alpha = (report$NES-min(report$NES))/(max(report$NES)-min(report$NES)))
barplot(-log(report$NOM.p.val), cex.names = 0.6,
        xlab = "-log2(P)",
        horiz = T, las = 1,
        names.arg = tolower(report$GS.br..follow.link.to.MSigDB),
        col = barCol)

metaUp = read.csv("~/Documents/study/biology/labs/ZengLab/thesis/结果/up/Enrichment_GO/_FINAL_GO.csv",
                  header = T,
                  stringsAsFactors = F)
metaUp = metaUp[order(metaUp$LogP, decreasing = T), ]
mypar = par(mar = c(5, 17, 4, 2))
barCol = rgb(0, 0.7, 1, alpha = (metaUp$Z.score-min(metaUp$Z.score))/(max(metaUp$Z.score)-min(metaUp$Z.score)))
barplot(-metaUp$LogP, cex.names = 0.55,
        xlab = "-log10(P)",
        horiz = T, las = 1,
        space = 0.8,
        names.arg = metaUp$GO%&%metaUp$Description,
        col = barCol)

ppiUp = read.csv("~/Documents/study/biology/labs/ZengLab/thesis/结果/up/Enrichment_PPI/GO_MCODE.csv",
                 header = T,
                 stringsAsFactors = F)
ppiUp = ppiUp[1:30, ]
ppiUp = ppiUp[order(ppiUp$LogP, decreasing = T), ]
mypar = par(mar = c(5, 19, 4, 2))
barCol = rgb(0, 0.7, 1, alpha = (ppiUp$Z.score-min(ppiUp$Z.score))/(max(ppiUp$Z.score)-min(ppiUp$Z.score)))
pdf(file = "~/Box/论文草稿/fig/metaUp_PPIbyP.pdf", height = 7, width = 14)
mypar = par(mar = c(5, 20, 4, 2))
barplot(-ppiUp$LogP[1:30], cex.names = 0.55,
        xlab = "-log10(P)",
        horiz = T, las = 1,
        space = 0.8,
        names.arg = ppiUp$GO[1:30]%&%ppiUp$Description[1:30],
        col = barCol)
dev.off()
