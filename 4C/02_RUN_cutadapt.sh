#!/bin/sh
#PBS -N cutadapt1
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -q middleq
#PBS -l mem=20gb,walltime=1000:00:00,nodes=1:ppn=1
#HSCHED -s hschedd
#HSCHED -s T2D+cutadapt+human

cd $PBS_O_WORKDIR

# Note that to use `--untrimmed_output` argument, multi-core is not supported
# Note that in this script, only reads from Forward primers are extracted, since those from R primers are useless, we just put them in the untrimmed file
# This script was modified on 180316 due to some previous errors
# first,cut adaptor for viewpoint2

/software/biosoft/software/centos6/python2.7.8/bin/cutadapt \
-g AATGTACTAGGCATAGTGGCTTGCACCTGCAATCCCAGCTGCTTGGGAGGTTGAGGCCAGAGGATC -g GATCCTCTGGCCTCAACCTCCCAAGCAGCTGGGATTGCAGGTGCAAGCCACTATGCCTAGTACATT \
-a GATCCTCTGGCCTCAACCTCCCAAGCAGCTGGGATTGCAGGTGCAAGCCACTATGCCTAGTACATT -a AATGTACTAGGCATAGTGGCTTGCACCTGCAATCCCAGCTGCTTGGGAGGTTGAGGCCAGAGGATC \
-e 0.2 --minimum-length 20 -o T2D_v2_F_1.fastq \
--untrimmed-output /p200/zengchq_group/guanxn/mzp/4C/cut_and_split_180424/T2D_v2_untrimmed_1.fastq \
--info-file /p200/zengchq_group/guanxn/mzp/4C/cut_and_split_180424/T2D_v2_F_1.info \
/share_bio/unisvx4/zengchq_group/huqt/4C/4C_HighSeq_HQT0124_1.fastq

/software/biosoft/software/centos6/python2.7.8/bin/cutadapt \
-g AATGTACTAGGCATAGTGGCTTGCACCTGCAATCCCAGCTGCTTGGGAGGTTGAGGCCAGAGGATC -g GATCCTCTGGCCTCAACCTCCCAAGCAGCTGGGATTGCAGGTGCAAGCCACTATGCCTAGTACATT \
-a GATCCTCTGGCCTCAACCTCCCAAGCAGCTGGGATTGCAGGTGCAAGCCACTATGCCTAGTACATT -a AATGTACTAGGCATAGTGGCTTGCACCTGCAATCCCAGCTGCTTGGGAGGTTGAGGCCAGAGGATC \
-e 0.2 --minimum-length 20 -o T2D_v2_F_2.fastq \
--untrimmed-output /p200/zengchq_group/guanxn/mzp/4C/cut_and_split_180424/T2D_v2_untrimmed_2.fastq \
--info-file /p200/zengchq_group/guanxn/mzp/4C/cut_and_split_180424/T2D_v2_F_2.info \
/share_bio/unisvx4/zengchq_group/huqt/4C/4C_HighSeq_HQT0124_2.fastq

