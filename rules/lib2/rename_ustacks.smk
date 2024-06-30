# Remove extra .1s from ustacks output files and move to stacks_denovo

rule rename_ustacks:
    input:
        tags1="results/lib2/ustacks/{sample}.1.tags.tsv.gz",	
        snps1="results/lib2/ustacks/{sample}.1.snps.tsv.gz",
        alleles1="results/lib2/ustacks/{sample}.1.alleles.tsv.gz"
    output:
        tags="results/lib2/stacks_denovo/{sample}.tags.tsv.gz",
        snps="results/lib2/stacks_denovo/{sample}.snps.tsv.gz",
        alleles="results/lib2/stacks_denovo/{sample}.alleles.tsv.gz"
    resources:
        cpus=1,
        mem_mb=3740,
        time="00:30:00"
    log:
        "results/lib2/logs/stacks_denovo/rename_ustacks/{sample}.log"
    benchmark:
        "results/lib2/benchmarks/stacks_denovo/rename_ustacks/{sample}.bmk"
    shell:
        """
        cp {input.tags1} {output.tags} &&
        cp {input.snps1} {output.snps} &&
        cp {input.alleles1} {output.alleles}
        """
