#!/bin/bash
#SBATCH --account=naiss2024-22-540
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --ntasks=1
#SBATCH --array=1-14
#SBATCH --mem=90G 
#SBATCH -o slurm_1.out  
#SBATCH -e slurm_2.err 
#SBATCH --time=0-02:00 



output_dir="/proj/applied_bioinformatics/users/x_daanw/MedBioinfo/analyses/blastn"
accnum_file="../x_daanw_run_accessions.txt"
datadir="/proj/applied_bioinformatics/users/x_daanw/MedBioinfo/data/merged_pairs"
Singularity_path=/"proj/applied_bioinformatics/common_data/meta.sif"

echo START: `date`

# this extracts the item number $SLURM_ARRAY_TASK_ID from the file of accnums
accnum=$(sed -n "$SLURM_ARRAY_TASK_ID"p ${accnum_file})
input_file="${datadir}/${accnum}.extendedFrags.fastq.gz"
output_file_fasta="${datadir}/${accnum}.extendedFrags.fasta"

srun --cpus-per-task=1 --time=02:30:00 --job-name=$accnum singularity exec --bind /proj:/proj $Singularity_path seqkit fq2fa $input_file -o $output_file_fasta

# because there are mutliple jobs running in // each output file needs to be made unique by post-fixing with $SLURM_ARRAY_TASK_ID and/or $accnum
input_file="${datadir}/${accnum}.extendedFrags.fasta"
output_file="${output_dir}/${SLURM_ARRAY_TASK_ID}.${accnum}.alignment"
DB_PATH="/proj/applied_bioinformatics/users/x_daanw/MedBioinfo/data/blast_db/refseq_viral_genomic"
BLASTN_PATH="/proj/applied_bioinformatics/tools/ncbi-blast-2.15.0+-src/blastn"


#################################################################
# Start work

srun --cpus-per-task=1 --mem-per-cpu=90G --time=01:00:00 --job-name=$accnum $BLASTN_PATH  -query $input_file -db $DB_PATH -out $output_file -num_threads 12 -evalue 1e-1 >
head -n 5 $output_file > "${output_file}.tmp"

# Overwrite the original output file with the temporary file
mv "${output_file}.tmp" $output_file

# Compress output file
gzip $output_filegzip  $output_file_fasta

echo END: `date`

