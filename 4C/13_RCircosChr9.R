library(RCircos)
library(dplyr)

FaireDf = read.table("~/Documents/study/biology/labs/ZengLab/thesis/data/FAIRE_HI_32_sites.bed",
                     header = F,
                     stringsAsFactors = F)
colnames(FaireDf) = c("Chromosome", "ChromStart", "ChromEnd", "peak", "Data")
FaireDf = select(FaireDf, "Chromosome", "ChromStart", "ChromEnd", "Data") %>%
  filter(Chromosome == "chr9")
FaireDf$Data = log10(FaireDf$Data)
FaireDf = RCircos.Sort.Genomic.Data(FaireDf)

#### Read files ####
myInteraction1 = read.table("~/Documents/study/biology/labs/ZengLab/thesis/结果/r3Cseq/VP1/VP1.interaction.chr9.txt",
                    header = T,
                    stringsAsFactors = F)
pCutoff = 0.05
myInteraction1 = filter(myInteraction1, p.value < pCutoff)
myInteraction1 = RCircos.Sort.Genomic.Data(myInteraction1)

#### Initialize RCircos core components ####
cyto = read.table("~/Documents/study/biology/labs/ZengLab/thesis/data/cytoBandIdeo23chr.txt",
                  header = F, stringsAsFactors = F, sep = "\t") # load human Cytoband data
exclude = c("chr1", "chr2", "chr3", "chr4", "chr5", "chr6", "chr7", "chr8", "chr14", "chr10", "chr11", "chr12", "chr13", "chr14", "chr15", "chr16", "chr17", "chr18", "chr19", "chr20", "chr21", "chr22", "chrX", "chrY", "chrM")
RCircos.Set.Core.Components(cyto.info = cyto,
                            tracks.inside = 4,
                            tracks.outside = 0,
                            chr.exclude = exclude)

#### Initialize a graph ####
pdf(file = "~/Documents/study/biology/labs/ZengLab/thesis/VP1.pdf", height = 10, width = 10, compress = T)
RCircos.Set.Plot.Area(margins = 0.05) # Initialize Graphic Device
RCircos.Chromosome.Ideogram.Plot() # Plot Chromosome Ideogram

#### Plot P value ####
myPar = RCircos.Get.Plot.Parameters()
myPar$hist.width = 2
myPar$track.height = 0.15
myPar$hist.color = "blue"
myPar$track.background = "lightblue"
RCircos.Reset.Plot.Parameters(myPar)

pValueDf = select(myInteraction1, Chromosome, ChromStart, chromEnd = end, Data = p.value)
pValueDf$Data = -log(pValueDf$Data)
pValueDf = RCircos.Sort.Genomic.Data(pValueDf)
RCircos.Histogram.Plot(pValueDf, track.num = 2, side = "in", max.value = max(pValueDf$Data))

#### Plot links ####
linkDf = select(myInteraction1, Chromosome, ChromStart, chromEnd = end)
linkDf = mutate(linkDf,
                Chromosome.1 = rep("chr9", nrow(linkDf)),
                chromStart.1 = rep(22131733, nrow(linkDf)),
                chromEnd.1 = rep(22131995, nrow(linkDf)))
linkDf = RCircos.Sort.Genomic.Data(linkDf)
RCircos.Link.Plot(linkDf, track.num = 3, by.chromosome = T)

#### Plot FAIRE ####
myPar = RCircos.Get.Plot.Parameters()
myPar$hist.color = "magenta"
myPar$track.background = "pink"
RCircos.Reset.Plot.Parameters(myPar)
RCircos.Histogram.Plot(FaireDf, track.num = 1, side = "in")

dev.off()

#### Read files ####
myInteraction2 = read.table("~/Documents/study/biology/labs/ZengLab/thesis/结果/r3Cseq/VP2/VP2.interaction.txt",
                           header = T,
                           stringsAsFactors = F) %>%
  filter(chromosome == "chr9")
pCutoff = 0.05
myInteraction2 = filter(myInteraction2, p.value < pCutoff)

#### Initialize RCircos core components ####
RCircos.Set.Core.Components(cyto.info = cyto,
                            tracks.inside = 3,
                            tracks.outside = 0,
                            chr.exclude = exclude)

#### Initialize a graph ####
pdf(file = "~/Documents/study/biology/labs/ZengLab/thesis/VP2.pdf", height = 10, width = 10, compress = T)
RCircos.Set.Plot.Area(margins = 0.05) # Initialize Graphic Device
RCircos.Chromosome.Ideogram.Plot() # Plot Chromosome Ideogram

#### Plot P value ####
myPar = RCircos.Get.Plot.Parameters()
myPar$hist.width = 2
myPar$track.height = 0.15
myPar$hist.color = "blue"
myPar$track.background = "lightblue"
RCircos.Reset.Plot.Parameters(myPar)

pValueDf = select(myInteraction2, Chromosome = chromosome, chromStart = start, chromEnd = end, Data = p.value)
pValueDf$Data = -log(pValueDf$Data)
RCircos.Histogram.Plot(pValueDf, track.num = 2, side = "in", max.value = max(pValueDf$Data))

#### Plot links ####
linkDf = select(myInteraction2, Chromosome = chromosome, chromStart = start, chromEnd = end)
linkDf = mutate(linkDf,
                Chromosome.1 = rep("chr9", nrow(linkDf)),
                chromStart.1 = rep(22131990, nrow(linkDf)),
                chromEnd.1 = rep(22132356, nrow(linkDf)))
RCircos.Link.Plot(linkDf, track.num = 3, by.chromosome = T)

#### Plot FAIRE ####
myPar = RCircos.Get.Plot.Parameters()
myPar$hist.color = "magenta"
myPar$track.background = "pink"
RCircos.Reset.Plot.Parameters(myPar)

RCircos.Histogram.Plot(FaireDf, track.num = 1, side = "in")

dev.off()
