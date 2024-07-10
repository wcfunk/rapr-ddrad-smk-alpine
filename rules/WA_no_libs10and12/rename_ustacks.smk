# Remove extra .1s from ustacks output files and move to stacks_denovo

rule rename_ustacks:
    input:
        tags1="results/WA_no_libs10and12/ustacks/{sample}.1.tags.tsv.gz",	
        snps1="results/WA_no_libs10and12/ustacks/{sample}.1.snps.tsv.gz",
        alleles1="results/WA_no_libs10and12/ustacks/{sample}.1.alleles.tsv.gz"
    output:
        tags="results/WA_no_libs10and12/stacks_denovo/{sample}.tags.tsv.gz",
        snps="results/WA_no_libs10and12/stacks_denovo/{sample}.snps.tsv.gz",
        alleles="results/WA_no_libs10and12/stacks_denovo/{sample}.alleles.tsv.gz"
    resources:
        cpus=1,
        mem_mb=3740,
        time="00:30:00"
    log:
        "results/WA_no_libs10and12/logs/stacks_denovo/rename_ustacks/{sample}.log"
    benchmark:
        "results/WA_no_libs10and12/benchmarks/stacks_denovo/rename_ustacks/{sample}.bmk"
    shell:
        """
        cp {input.tags1} {output.tags} &&
        cp {input.snps1} {output.snps} &&
        cp {input.alleles1} {output.alleles}
        """
