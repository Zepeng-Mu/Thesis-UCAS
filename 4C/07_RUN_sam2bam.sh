#!/bin/sh
#PBS -N sam2bam
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -q middleq
#PBS -l mem=10gb,walltime=500:00:00,nodes=1:ppn=8
#HSCHED -s hschedd
#HSCHED -s T2D+samtools+human

cd $PBS_O_WORKDIR

samtools view -S -b /p200/zengchq_group/guanxn/mzp/4C/cut_and_split_180316/T2D_v1_F_Q20_1.sam -o /p200/zengchq_group/guanxn/mzp/4C/cut_and_split_180316/T2D_v1_F_Q20_1.bam


