# Move cstacks output from rename_ustacks to cstacks directory

rule mv_cstacks:
    input:
        tags_rename="results/lib4/stacks_denovo/rename_ustacks/catalog.tags.tsv.gz",
        snps_rename="results/lib4/stacks_denovo/rename_ustacks/catalog.snps.tsv.gz",
        alleles_rename="results/lib4/stacks_denovo/rename_ustacks/catalog.alleles.tsv.gz",
        list_rename="results/lib4/stacks_denovo/rename_ustacks/catalog.sample_list.tsv.gz"
    output:
        tags_cstacks="results/lib4/stacks_denovo/cstacks/catalog.tags.tsv.gz",
        snps_cstacks="results/lib4/stacks_denovo/cstacks/catalog.snps.tsv.gz",
        alleles_cstacks="results/lib4/stacks_denovo/cstacks/catalog.alleles.tsv.gz",
        list_cstacks="results/lib4/stacks_denovo/cstacks/catalog.sample_list.tsv.gz"
    resources:
        cpus=1,
        mem_mb=3740,
        time="00:30:00"
    log:
        "results/lib4/logs/mv_cstacks/mv_cstacks.log"
    benchmark:
        "results/lib4/benchmarks/mv_cstacks/mv_cstacks.bmk"
    shell:
        """
        mv {input.tags_rename} {output.tags_cstacks} &&
        mv {input.snps_rename} {output.snps_cstacks} &&
        mv {input.alleles_rename} {output.alleles_cstacks} &&
        mv {input.list_rename} {output.list_cstacks}
        """
