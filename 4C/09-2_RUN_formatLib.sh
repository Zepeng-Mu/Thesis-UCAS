#!/bin/sh
#PBS -N 4Canalysis
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -q middleq
#PBS -l mem=10gb,walltime=500:00:00,nodes=1:ppn=8
#HSCHED -s hschedd
#HSCHED -s T2D+R+human

cd $PBS_O_WORKDIR

/software/biosoft/software/sugonR/R3.4.2/bin/R CMD BATCH 09-1_formatLib.R