# Remove extra .1s from ustacks output files

rule rename_fastqs:
    input:
        tags1="results/lib4/stacks_denovo/ustacks/{sample}.1.tags.tsv.gz",	
        snps1="results/lib4/stacks_denovo/ustacks/{sample}.1.snps.tsv.gz",
        alleles1="results/lib4/stacks_denovo/ustacks/{sample}.1.alleles.tsv.gz"
    output:
        tags="results/lib4/stacks_denovo/ustacks/{sample}.tags.tsv.gz",
        snps="results/lib4/stacks_denovo/ustacks/{sample}.snps.tsv.gz",
        alleles="results/lib4/stacks_denovo/ustacks/{sample}.alleles.tsv.gz"
    resources:
        cpus=1,
        mem_mb=3740,
        time="00:30:00"
    log:
        "results/lib4/logs/rename_ustacks/{sample}.log"
    benchmark:
        "results/lib4/benchmarks/rename_ustacks/{sample}.bmk"
    shell:
        """
        mv {input.tags1} {output.tags} &&
        mv {input.snps1} {output.snps}
        mv {input.alleles1} {output.alleles}
        """
