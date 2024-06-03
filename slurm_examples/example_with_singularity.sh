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





datadir="./proj/applied_bioinformatics/users/x_daanw/MedBioinfo/data/merged_pairs/merged_pairs/"
accnum_file="../x_daanw_run_accessions.txt"
output_dir="/proj/applied_bioinformatics/users/x_daanw/MedBioinfo/analyses/kraken2"

echo START: `date`


accnum=$(sed -n "$SLURM_ARRAY_TASK_ID"p ${accnum_file})

FASTQ_R1="${datadir}/${accnum}.notCombined_1.fastq.gz"
FASTQ_R2="${datadir}/${accnum}.notCombined_2.fastq.gz"
OUTPUT_PATH_KRACKEN_OUTPUT="${output_dir}/${accnum}_kracken_output.txt"
OUTPUT_PATH_KRACKEN_REPORT="${output_dir}/${accnum}_kracken_report.txt"
OUTPUT_PATH_BRACKEN_REPORT="${output_dir}/${accnum}_bracken_report.txt"


KRAKEN_DB_PATH="/proj/applied_bioinformatics/common_data/kraken_database/"

ERROR_FILE="${output_dir}/${accnum}_kracken_output.err"

OUT_FILE="${output_dir}/${accnum}_kracken_output.out"

ERROR_FILE_BRACKEN="${output_dir}/${accnum}_bracken_output.err"

OUT_FILE_BRACKEN="${output_dir}/${accnum}_bracken_output.out"

JOB_NAME_KRAKEN="kraken_${accnum}"
JOB_NAME_BRACKEN="bracken_${accnum}"



srun --job-name=${JOB_NAME_KRAKEN} singularity exec --bind /proj:/proj /proj/applied_bioinformatics/common_data/kraken2.sif kraken2 --db /proj/applied_bioinformatics/com>
srun --job-name=${JOB_NAME_BRACKEN} singularity exec --bind /proj:/proj /proj/applied_bioinformatics/common_data/kraken2.sif bracken -d ${KRAKEN_DB_PATH} -i ${OUTPUT_PAT>


echo END: `date`
 
