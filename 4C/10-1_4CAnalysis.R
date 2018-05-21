# This file reads both a prepared virtual fragment library and the raw read data

library(Basic4Cseq)
library(GenomicAlignments)
library(caTools)
# library(RCircos)

#### define files ####
fragends = "/p200/zengchq_group/guanxn/mzp/4C/fragends_hg19_aagctt_gatc_101bp_chr1-22.txt"
bam = "/p200/zengchq_group/guanxn/mzp/4C/cut_and_split_180316/T2D_v1_F_36bp_chr1-22.bam"

xInterval = 30000

#### define point of interests ####
poiDf = read.csv("/p200/zengchq_group/guanxn/mzp/4C/4C_poi_df.csv", header = T, stringsAsFactors = F)

#### align reads####
reads = readGAlignments(bam)

#### creat Data4Cseq object####
viewpoint1 = Data4Cseq(viewpointChromosome = "9",
                       viewpointInterval = c(22131733, 22131995),
                       readLength = 101,
                       pointsOfInterest = poiDf,
                       rawReads = reads)

#### map reads ####
rawFragments(viewpoint1) = readsToFragments(viewpoint1, fragends)

#### pick near-cis fragments####
nearCisFragments(viewpoint1) = chooseNearCisFragments(viewpoint1,
                                                      regionCoordinates = c(21850000, 22300000))

#### RPM normalization ####
nearCisFragments(viewpoint1) = normalizeFragmentData(viewpoint1)

#### quality control ####
getReadDistribution(viewpoint1, useFragEnds = T,
                    outputName = "/p200/zengchq_group/guanxn/mzp/4C/cut_and_split_180316/viewpoint1_stats_2.txt")

#### save data object ####
save(viewpoint1, file = "/p200/zengchq_group/guanxn/mzp/4C/Basic4Cseq/vp1_180327_2")
