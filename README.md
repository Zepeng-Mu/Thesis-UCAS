# Thesis-UCAS
Repo for scripts used in my thesis project at University of Chinese Academy of Sciences.

## 4C
Scripts used in 4C experiment data analysis.

### 01_RUN_4C_fastqc.sh
Quality control for original sequencing reads.

### 02_RUN_cutadapt.sh
Retrive reads from a given viewpoint by the PCR primer of that viewpoint.

### 03_trimFastq.py
Trim all reads in FASTQ file from 5' end to 36 bp.

### 04_RUN_Bowtie.sh
Map reads to hg19. Parameters set according to *Brouwer, R. W. W., Hout, M. C. G. N. Van Den, Ijcken, W. F. J. Van, Soler, E., & Stadhouders, R. (2017). Unbiased Interrogation of 3D Genome Topology Using Chromosome Conformation Capture Coupled to High- Throughput Sequencing (4C-Seq), 1507. https://doi.org/10.1007/978-1-4939-6518-2*

### 05_formatSAM.py
Retrive reads mapped to Chromosome 1-22 from SAM files.

### 06_formatSAMName.py
Add prefix "chr" to coromosome numbers for input of r3Cseq package.

### 07_RUNsam2bam.sh
Convert SAM files to BAM files using samtools.

### 08-1_creatVirtualFragmentLibrary.R
Creat fragends library using restriction enzyme used for digest.

### 08-2_RUN_creatVirtualFragmentLibrary.sh
Submit *08-1_creatVirtualFragmentLibrary.R* to cluster.

### 09-1_formatLib.R
Retrive fragends that come from chromosome 1-22.

### 09-2_RUN_formatLib.sh
Submit *09-1_formatLib.R* to cluster.

### 10-1_4CAnalysis.R
Run 4C data analysis using R/Bioconductor package Basic4Cseq.

### 10-2_RUN_4CAnalysis.sh
Submit *10-1_4CAnalysis.R* to cluster.

### 11_Basic4Cseq_visualization.R
Visualize results from Basic4Cseq.

### 12_r3Cseq.R
Run 4C experiment analysis by r3Cseq.

### 13_RCircosChr9.R
Draw Circos plot for *cis* interactions from r3Cseq.

### 14_RCircos.R
Draw Circos plot for whole-genome interactions from r3Cseq.

## RNA-seq
Scripts used in analysing RNA-seq data.

### 01_sortBAMbyName.sh
To use HTseq-count, BAM files needs to be sorted according to read name, instead of mapped coordination.

### 02_HTseq-countCtrl/B4/C9.sh
These 3 files run HTseq-count to get gene-level read counts for Ctrl, KO.1 and KO.2 respectively.

### 03_limma.R
Main script used to run DGE analysis by limma, generate ".rnk" file for GSEA, and to generate figures.

### 04_visualizeGSEA.R
Visualize enrichment analysis results from GSEA.
