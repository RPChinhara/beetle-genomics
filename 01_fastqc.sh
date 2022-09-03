#! /bin/bash
#PBS -N beetle-genomics
#PBS -o out.log
#PBS -e err.log
#PBS -l mem=16gb,ncpus=10
#PBS -q cpu

module load compiler/anaconda3

conda init

source ~/.bashrc

conda activate beetle-genomics

data_path='/storage/bic/data/imroze-lab/rnaseq/Tribolium_castenium/'
reference_path='/storage/bic/data/imroze-lab/rnaseq/annotations/'

cd $data_path

fastqc -t 10 *.fastq.gz

mv *fastqc* ../reports/fastqc/

cd ../reports/fastqc/

multiqc .
