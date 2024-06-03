#!/bin/bash
#SBATCH --account=naiss2024-22-540
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --ntasks=1
#SBATCH --array=1
#SBATCH --mem=90G 
#SBATCH -o slurm_1.out  
#SBATCH -e slurm_2.err 
#SBATCH --time=0-02:00 



output_dir="/proj/applied_bioinformatics/users/x_daanw/MedBioinfo/analyses/blastn"
accnum_file="../x_daanw_run_accessions.txt"
datadir="/proj/applied_bioinformatics/users/x_daanw/MedBioinfo/data/merged_pairs"

echo START: `date`



# this extracts the item number $SLURM_ARRAY_TASK_ID from the file of accnums
accnum="ERR6913103"
input_file="${datadir}/${accnum}.extendedFrags_1_10000.fasta"
echo ${input_file}
# alternatively, just extract the input file as the item number $SLURM_ARRAY_TASK_ID in the data dir listing
# this alternative is less handy since we don't get hold of the isolated "accnum", which is very handy to name the srun step below :)
# input_file=$(ls "${datadir}/*.fastq.gz" | sed -n ${SLURM_ARRAY_TASK_ID}p)

# if the command below can't cope with compressed input

last_part="${input_file##*/}"
alignement_file_name="${last_part:0:-6}"

# because there are mutliple jobs running in // each output file needs to be made unique by post-fixing with $SLURM_ARRAY_TASK_ID and/or $accnum
output_file="${output_dir}/${SLURM_ARRAY_TASK_ID}.${alignement_file_name}.alignment"
DB_PATH="/proj/applied_bioinformatics/users/x_daanw/MedBioinfo/data/blast_db/refseq_viral_genomic"


#################################################################
# Start work

srun --cpus-per-task=1 --mem-per-cpu=90G --time=01:00:00 --job-name=$accnum /proj/applied_bioinformatics/tools/ncbi-blast-2.15.0+-src/blastn -query $input_file -db $DB_P>
echo END: `date`

