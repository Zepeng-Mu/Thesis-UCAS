library(r3Cseq)
library(BSgenome)
library(BSgenome.Hsapiens.UCSC.hg19.masked)
library(tidyverse)

#### VP1 ####
expFile = "~/Documents/study/biology/labs/ZengLab/thesis/data/T2D_v1_F_36bp_chr1-22_fullName.bam"
my_obj = new("r3Cseq",
             organismName = 'hg19',
             alignedReadsBamExpFile = expFile,
             viewpoint_chromosome = 'chr9',
             viewpoint_primer_forward = 'AAGCTGTTACTGGCTGGGGAACTAAAAAAGCTT',
             viewpoint_primer_reverse = 'CTACTCTCTCATTAAGAAACTGTTGCCTTGGCCGGGCGCGGTGGCTCACGCCTGTTATCCCAGCACTTTGGGAGGCCAAGGCGGGCGGATC',
             expLabel = "VP1",
             restrictionEnzyme = 'HindIII')

getRawReads(my_obj) 
getReadCountPerRestrictionFragment(my_obj)
calculateRPM(my_obj)
getInteractions(my_obj, fdr = 0.05)

expResults = expInteractionRegions(my_obj)


detected_genes = getExpInteractionsInRefseq(my_obj, cutoff.qvalue = 1)
write.table(detected_genes,
            "~/Documents/study/biology/labs/ZengLab/thesis/data/T2D_v1_detectedGenes.txt",
            row.names = F,
            quote = F,
            sep = "\t")
out = select(detected_genes, gene_name, total_RPMs)

viewpoint = getViewpoint(my_obj)
write.table(out,
            "~/Documents/study/biology/labs/ZengLab/thesis/data/VP1_detectedGenes.rnk",
            row.names = F,
            col.names = F,
            quote = F,
            sep = "\t")

setwd("~/Documents/study/biology/labs/ZengLab/thesis/结果/r3Cseq/VP1")
generate3CseqReport(my_obj)
export3CseqRawReads2bedGraph(my_obj)
export3Cseq2bedGraph(my_obj)
exportInteractions2text(my_obj)

#### VP2 ####
expFile = "~/Documents/study/biology/labs/ZengLab/thesis/data/T2D_v2_F_36bp_chr1-22_fullName.bam"
my_obj = new("r3Cseq",
             organismName = 'hg19',
             alignedReadsBamExpFile = expFile,
             viewpoint_chromosome = 'chr9',
             viewpoint_primer_forward = 'AATGTACTAGGCATAGTGGCTTGCACCTGCAATCCCAGCTGCTTGGGAGGTTGAGGCCAGAGGATC',
             viewpoint_primer_reverse = 'CCTTCCTGTCACAGTTTTAGTTGCTAATCACATAACATTAAGAAACCCCAAAGACTTTCTAGATATAACTCTGGAAGCTT',
             expLabel = "VP2",
             restrictionEnzyme = 'HindIII')

getRawReads(my_obj) 
getReadCountPerRestrictionFragment(my_obj)
calculateRPM(my_obj)
getInteractions(my_obj, fdr = 0.05)

expResults = expInteractionRegions(my_obj)

detected_genes = getExpInteractionsInRefseq(my_obj)
write.table(detected_genes,
            "~/Documents/study/biology/labs/ZengLab/thesis/data/T2D_v2_detectedGenes.txt",
            row.names = F,
            quote = F,
            sep = "\t")


viewpoint = getViewpoint(my_obj)

setwd("~/Documents/study/biology/labs/ZengLab/thesis/结果/r3Cseq/VP2")
generate3CseqReport(my_obj)
export3CseqRawReads2bedGraph(my_obj)
export3Cseq2bedGraph(my_obj)
exportInteractions2text(my_obj)



