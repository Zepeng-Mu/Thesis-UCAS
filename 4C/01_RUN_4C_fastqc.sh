#!/bin/sh
#PBS -N 4Cfactqc
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -q middleq
#PBS -l mem=20gb,walltime=1000:00:00,nodes=1:ppn=8
#HSCHED -s hschedd
#HSCHED -s T2D+fastqc+human

cd $PBS_O_WORKDIR

/software/biosoft/bin/fastqc \
/share_bio/unisvx4/zengchq_group/huqt/4C/4C_HighSeq_HQT0124_1.fastq \
/share_bio/unisvx4/zengchq_group/huqt/4C/4C_HighSeq_HQT0124_2.fastq \
--outdir /p200/zengchq_group/guanxn/mzp/4C/fastqc_180105
