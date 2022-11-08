#! /bin/bash
#PBS -N beetle-genomics
#PBS -o out.log
#PBS -e err.log
#PBS -l mem=16gb,ncpus=1
#PBS -q cpu

module load compiler/anaconda3

conda init

source ~/.bashrc

conda activate beetle-genomics

raw_data='/storage/bic/data/imroze-lab/rnaseq/Tribolium_castenium'

cd $raw_data

for i in *1_001.fastq.gz; do
    base=${i%%1_001.fastq.gz}
    cutadapt \
    -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA \
    -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT \
    -o ${base}1_001_trimmed.fastq.gz -p ${base}2_001_trimmed.fastq.gz \
    ${base}1_001.fastq.gz ${base}2_001.fastq.gz
done

mv *trimmed* ../trim-data/