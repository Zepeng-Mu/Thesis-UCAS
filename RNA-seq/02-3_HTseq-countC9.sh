#!/bin/sh
#PBS -N HTseqC9
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -q middleq
#PBS -l mem=20gb,walltime=800:00:00,nodes=1:ppn=8
#HSCHED -s hschedd
#HSCHED -s T2D+HTseq+human

/software/biosoft/software/centos6/limixinstall/bin/htseq-count\
 --format=bam\
 /p200/zengchq_group/guanxn/mzp/RNAseq/C9byName.bam\
 /share_bio/unisvx4/zengchq_group/guanxn/reference/Homo_sapiens.GRCh37.75/Homo_sapiens.GRCh37.75.gtf

