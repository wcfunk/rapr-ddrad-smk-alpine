# Copy ustacks output from rename_ustacks to cstacks directory

rule cp_ustacks:
    input:
        tags_rename="results/lib2/stacks_denovo/rename_ustacks/{sample}.tags.tsv.gz",
        snps_rename="results/lib2/stacks_denovo/rename_ustacks/{sample}.snps.tsv.gz",
        alleles_rename="results/lib2/stacks_denovo/rename_ustacks/{sample}.alleles.tsv.gz"
    output:
        tags_cstacks="results/lib2/stacks_denovo/cstacks/{sample}.tags.tsv.gz",
        snps_cstacks="results/lib2/stacks_denovo/cstacks/{sample}.snps.tsv.gz",
        alleles_cstacks="results/lib2/stacks_denovo/cstacks/{sample}.alleles.tsv.gz"
    resources:
        cpus=1,
        mem_mb=3740,
        time="00:30:00"
    log:
        "results/lib2/logs/cp_ustacks/{sample}.log"
    benchmark:
        "results/lib2/benchmarks/cp_ustacks/{sample}.bmk"
    shell:
        """
        cp {input.tags_rename} {output.tags_cstacks} &&
        cp {input.snps_rename} {output.snps_cstacks} &&
        cp {input.alleles_rename} {output.alleles_cstacks}
        """
