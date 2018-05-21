library(dplyr)

fragLib = read.table(file = "/p200/zengchq_group/guanxn/mzp/4C/fragends_hg19_gatc_aagctt_101bp.csv",
                     header = T,
                     stringsAsFactors = F)

fragLibNew = dplyr::filter(fragLib, chromosomeName %in% seq(1:22))

write.table(fragLibNew,
            file = "/p200/zengchq_group/guanxn/mzp/4C/fragends_hg19_gatc_aagctt_101bp_chr1-22.txt",
            row.names = F,
            quote = F,
            sep = "\t")