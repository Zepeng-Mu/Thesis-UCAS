library(Basic4Cseq)
library(BSgenome.Hsapiens.UCSC.hg19)

#### creat Hg19 instance####
hg19 = BSgenome.Hsapiens.UCSC.hg19

#### generate fragends library####
frag = createVirtualFragmentLibrary(chosenGenome = hg19,
                                    firstCutter = "aagctt", secondCutter = "gatc",
                                    readLength = 101,
                                    useAllData = T,
                                    useOnlyIndex = F,
                                    libraryName = "")

write.table(frag, file = "/p200/zengchq_group/guanxn/mzp/4C/fragends_hg19_aagctt_gatc_101_TF.csv",
            row.names = F,
            quote = F)

