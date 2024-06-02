# Remove extra .1s from ustacks output files

rule rename_ustacks:
    input:
        tags1="results/lib4/stacks_denovo/ustacks/{sample}.1.tags.tsv.gz",	
        snps1="results/lib4/stacks_denovo/ustacks/{sample}.1.snps.tsv.gz",
        alleles1="results/lib4/stacks_denovo/ustacks/{sample}.1.alleles.tsv.gz"
    output:
        tags="results/lib4/stacks_denovo/rename_ustacks/{sample}.tags.tsv.gz",
        snps="results/lib4/stacks_denovo/rename_ustacks/{sample}.snps.tsv.gz",
        alleles="results/lib4/stacks_denovo/rename_ustacks/{sample}.alleles.tsv.gz"
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
        cp {input.tags1} {output.tags} &&
        cp {input.snps1} {output.snps} &&
        cp {input.alleles1} {output.alleles}
        """
