# Run sstacks. Match all samples supplied in the population map against the catalog.

rule sstacks:
    input:
        "results/lib2/stacks_denovo/cstacks/{sample}.tags.tsv.gz",
        "results/lib2/stacks_denovo/cstacks/{sample}.snps.tsv.gz",
        "results/lib2/stacks_denovo/cstacks/{sample}.alleles.tsv.gz",
        "results/lib2/stacks_denovo/cstacks/catalog.tags.tsv.gz",
        "results/lib2/stacks_denovo/cstacks/catalog.snps.tsv.gz",
        "results/lib2/stacks_denovo/cstacks/catalog.alleles.tsv.gz",
        "results/lib2/stacks_denovo/cstacks/catalog.sample_list.tsv.gz"
    output:
        "results/lib2/stacks_denovo/cstacks/{sample}.matches.tsv.gz"
    params:
        popmap=config["popmap"],
    conda:
        "stacks-2.65"
    resources:
        cpus=24,
        mem_mb=89760,
        qos="long",
        time="72:00:00"
    log:
        "results/lib2/logs/stacks_denovo/sstacks/{sample}.log"
    benchmark:
        "results/lib2/benchmarks/stacks_denovo/sstacks/{sample}.bmk"
    shell:
        " (sstacks				"
        " -P results/lib2/stacks_denovo/cstacks/	"
        " -M rapr-ddrad-smk-alpine/data/popmap_lib2_by_sample/popmap_lib2_{sample}.tsv -p 24)		"
        " 2> {log}				"
