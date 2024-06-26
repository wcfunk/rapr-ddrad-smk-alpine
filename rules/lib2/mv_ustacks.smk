# Move ustacks output from rename_ustacks to cstacks directory

rule mv_ustacks:
    input:
        tags_rename="results/lib2/stacks_denovo/rename_ustacks/{sample}.tags.tsv.gz",
        snps_rename="results/lib2/stacks_denovo/rename_ustacks/{sample}.snps.tsv.gz",
        alleles_rename="results/lib2/stacks_denovo/rename_ustacks/{sample}.alleles.tsv.gz"
    output:
        tags_cstacks="results/lib2/stacks_denovo/{sample}.tags.tsv.gz",
        snps_cstacks="results/lib2/stacks_denovo/{sample}.snps.tsv.gz",
        alleles_cstacks="results/lib2/stacks_denovo/{sample}.alleles.tsv.gz"
    resources:
        cpus=1,
        mem_mb=3740,
        time="00:30:00"
    log:
        "results/lib2/logs/mv_ustacks/{sample}.log"
    benchmark:
        "results/lib2/benchmarks/mv_ustacks/{sample}.bmk"
    shell:
        """
        mv {input.tags_rename} {output.tags_cstacks} &&
        mv {input.snps_rename} {output.snps_cstacks} &&
        mv {input.alleles_rename} {output.alleles_cstacks}
        """
