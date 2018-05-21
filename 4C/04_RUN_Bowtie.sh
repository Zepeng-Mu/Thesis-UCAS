#!/bin/sh
#PBS -N 4Cbowtie
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -q middleq
#PBS -l mem=20gb,walltime=1000:00:00,nodes=1:ppn=8
#HSCHED -s hschedd
#HSCHED -s T2D+bowtie+human

cd $PBS_O_WORKDIR

bowtie /share_bio/unisvx4/zengchq_group/guanxn/reference/Homo_sapiens.GRCh37.75/Homo_sapiens.GRCh37.75.dna.chromosome \
/p200/zengchq_group/guanxn/mzp/4C/cut_and_split_180316/T2D_v1_F_Q20.fastq \
--sam /p200/zengchq_group/guanxn/mzp/4C/cut_and_split_180316/T2D_v1_F_Q20_1.sam


