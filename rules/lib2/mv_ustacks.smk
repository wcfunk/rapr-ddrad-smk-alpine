# Move ustacks output files from rename_ustacks to stacks_denovo

rule mv_ustacks:
    input:
        tags_source="results/lib2/stacks_denovo/rename_ustacks/{sample}.tags.tsv.gz",
        snps_source="results/lib2/stacks_denovo/rename_ustacks/{sample}.snps.tsv.gz",
        alleles_source="results/lib2/stacks_denovo/rename_ustacks/{sample}.alleles.tsv.gz"
    output:
        tags_target="results/lib2/stacks_denovo/{sample}.tags.tsv.gz",
        snps_target="results/lib2/stacks_denovo/{sample}.snps.tsv.gz",
        alleles_target="results/lib2/stacks_denovo/{sample}.alleles.tsv.gz"
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
        mv {input.tags_source} {output.tags_target} &&
        mv {input.tags_source} {output.snps_target} &&
        mv {input.tags_source} {output.alleles_target}
        """
