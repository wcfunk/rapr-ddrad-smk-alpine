#!/bin/bash
#
#IMPORTANT: THIS SBATCH JOB MUST BE RUN FROM PARENT DIRECTORY OF RAPR-DDRAD-SMK-ALPINE
#IMPORTANT: FASTQS MUST BE IN PARENT DIRECTORY OF RAPR-DDRAD-SMK-ALPINE TOO
#
#all commands that start with SBATCH contain commands that are just used by SLURM for scheduling
#################
#set a job name
#SBATCH --job-name=snakemake_raau_M1
#################
#a file for job output, you can check job progress
#SBATCH --output=snake_raau_M1.%j.out
#################
# a file for errors from the job
#SBATCH --error=snake_raau_M1.%j.err
#################
#time you think you need; default is one hour
#in minutes in this case
#SBATCH -t 24:00:00
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

snakemake -p -s rapr-ddrad-smk-alpine/snakefile/de_novo_param_opt/M_opt/Snakefile_raau_M1 --profile rapr-ddrad-smk-alpine/slurm_config/de_novo_param_opt/M_opt/raau_M1/ results/de_novo_param_opt/M_opt/raau_M1/populations/populations.snps.vcf
