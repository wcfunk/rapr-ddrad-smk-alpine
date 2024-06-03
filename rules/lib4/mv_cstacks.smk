# Move cstacks output from rename_ustacks to cstacks directory

rule mv_cstacks:
    input:
        tags="results/lib4/stacks_denovo/rename_ustacks/catalog.tags.tsv.gz",
        snps="results/lib4/stacks_denovo/rename_ustacks/catalog.snps.tsv.gz",
        alleles="results/lib4/stacks_denovo/rename_ustacks/catalog.alleles.tsv.gz",
        list="results/lib4/stacks_denovo/rename_ustacks/catalog.sample_list.tsv.gz"
    output:
        tags="results/lib4/stacks_denovo/cstacks/catalog.tags.tsv.gz",
        snps="results/lib4/stacks_denovo/cstacks/catalog.snps.tsv.gz",
        alleles="results/lib4/stacks_denovo/cstacks/catalog.alleles.tsv.gz",
        list="results/lib4/stacks_denovo/cstacks/catalog.sample_list.tsv.gz"
    resources:
        cpus=1,
        mem_mb=3740,
        time="00:30:00"
    log:
        "results/lib4/logs/mv_cstacks/{sample}.log"
    benchmark:
        "results/lib4/benchmarks/mv_cstacks/{sample}.bmk"
    shell:
        """
        mv {input.tags} {output.tags} &&
        mv {input.snps} {output.snps} &&
        mv {input.alleles} {output.alleles} &&
        mv {input.list} {output.list}
        """
