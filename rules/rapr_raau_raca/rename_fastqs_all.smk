# Target rule that runs rename_fastqs.smk for all samples

# Put array of sample names in SAMPLES
import glob
import os

SAMPLES = sorted(set([
    os.path.basename(f).replace("_1.fq.gz", "")
    for f in glob.glob("fastqs/*/*_1.fq.gz")
]))

# Define target rule rename_fastqs_all
rule rename_fastqs_all:
    input:
        expand(
            "results/rapr_raau_raca/process_radtags/{sample}.1.fq.gz",
            sample=SAMPLES
        )
