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

data_path='/storage/bic/data/imroze-lab/rnaseq'
genome_build='/storage/bic/data/imroze-lab/rnaseq/annotations/Tribolium_castaneum'
cd $data_path/trim-data/

for i in *1_001_trimmed.fastq.gz; do
    base=${i%%R1_001_trimmed.fastq.gz}
    salmon quant -i $genome_build -l A \
        -1 ${base}R1_001_trimmed.fastq.gz \
        -2 ${base}R2_001_trimmed.fastq.gz \
        -p 10 --validateMappings -o $data_path/quants/${base}quant
done