#!/bin/bash
#
#IMPORTANT: THIS SBATCH JOB MUST BE RUN FROM PARENT DIRECTORY OF RAPR-DDRAD-SMK-ALPINE
#
#all commands that start with SBATCH contain commands that are just used by SLURM for scheduling
#################
#set a job name
#SBATCH --job-name=snakemake
#################
#a file for job output, you can check job progress
#SBATCH --output=snake.%j.out
#################
# a file for errors from the job
#SBATCH --error=snake.%j.err
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

snakemake -p -s rapr-ddrad-smk-alpine/snakefile/Snakefile_rapr_raau_raca --profile rapr-ddrad-smk-alpine/slurm_config/rapr_raau_raca/ results/rapr_raau_raca/populations/populations.snps.vcf
#snakemake -p -s rapr-ddrad-smk-alpine/snakefile/Snakefile_rapr_raau_raca --profile rapr-ddrad-smk-alpine/slurm_config/rapr_raau_raca/ results/rapr_raau_raca/populations/populations.snps.vcf
