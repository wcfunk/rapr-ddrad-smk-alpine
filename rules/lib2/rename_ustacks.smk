# Remove extra .1s from ustacks output files

rule rename_ustacks:
    input:
        tags1="results/lib2/stacks_denovo/{sample}.1.tags.tsv.gz",	
        snps1="results/lib2/stacks_denovo/{sample}.1.snps.tsv.gz",
        alleles1="results/lib2/stacks_denovo/{sample}.1.alleles.tsv.gz"
    output:
        tags_rename="results/lib2/stacks_denovo/rename_ustacks/{sample}.tags.tsv.gz",
        snps_rename="results/lib2/stacks_denovo/rename_ustacks/{sample}.snps.tsv.gz",
        alleles_rename="results/lib2/stacks_denovo/rename_ustacks/{sample}.alleles.tsv.gz"
    resources:
        cpus=1,
        mem_mb=3740,
        time="00:30:00"
    log:
        "results/lib2/logs/rename_ustacks/{sample}.log"
    benchmark:
        "results/lib2/benchmarks/rename_ustacks/{sample}.bmk"
    shell:
        """
        cp {input.tags1} {output.tags_rename} &&
        cp {input.snps1} {output.snps_rename} &&
        cp {input.alleles1} {output.alleles_rename}
        """
