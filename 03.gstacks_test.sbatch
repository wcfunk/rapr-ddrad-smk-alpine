#!/bin/bash
#
#IMPORTANT: THIS SBATCH JOB MUST BE RUN FROM PARENT DIRECTORY OF RAPR-DDRAD-SMK-ALPINE
#IMPORTANT: FASTQS MUST BE IN PARENT DIRECTORY OF RAPR-DDRAD-SMK-ALPINE TOO
#
#all commands that start with SBATCH contain commands that are just used by SLURM for scheduling
#################
#set a job name
#SBATCH --job-name=snakemake_gstacks_test
#################
#a file for job output, you can check job progress
#SBATCH --output=snake_gstacks_test.%j.out
#################
# a file for errors from the job
#SBATCH --error=snake_gstacks_test.%j.err
#################
#time you think you need; default is one hour
#in minutes in this case
#SBATCH -t 23:59:59
#################
#quality of service; think of it as job priority
#SBATCH --qos=normal
#SBATCH -p amilan
#SBATCH --account=csu89_alpine1
#################
#number of nodes
#SBATCH --nodes=5
#SBATCH --ntasks-per-node 1
#################
#SBATCH --mem=3G
#################
#get emailed about job BEGIN, END, and FAIL
#SBATCH --mail-type=END
#################
#who to send email to; please change to your email
#SBATCH --mail-user=Chris.Funk@colostate.edu
#################
#now run normal batch commands
##################
#echo commands to stdout

set -x

source ~/.bashrc
conda activate snakemake8.26.0

snakemake -p -s rapr-ddrad-smk-alpine/snakefile/Snakefile_gstacks_test --profile rapr-ddrad-smk-alpine/slurm_config/gstacks_test/ results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/gstacks_test/catalog.fa.gz
