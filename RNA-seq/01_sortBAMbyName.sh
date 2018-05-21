#!/bin/sh
#PBS -N sortn
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -q middleq
#PBS -l mem=20gb,walltime=800:00:00,nodes=1:ppn=8
#HSCHED -s hschedd
#HSCHED -s T2D+samtools+human

/software/biosoft/software/samtools1.5/bin/samtools sort\
 -@ 8 -n -o\
 /p200/zengchq_group/guanxn/mzp/RNAseq/293FTbyName.bam\
 /p200/zengchq_group/guanxn/T2D_CRISPR/1.hisat/293FT.bam

/software/biosoft/software/samtools1.5/bin/samtools sort\
 -@ 8 -n -o\
 /p200/zengchq_group/guanxn/mzp/RNAseq/B4byName.bam\
 /p200/zengchq_group/guanxn/T2D_CRISPR/1.hisat/B4.bam

/software/biosoft/software/samtools1.5/bin/samtools sort\
 -@ 8 -n -o\
 /p200/zengchq_group/guanxn/mzp/RNAseq/C9byName.bam\
 /p200/zengchq_group/guanxn/T2D_CRISPR/1.hisat/C9_5.bam
