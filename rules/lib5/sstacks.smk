# Run sstacks. Match all samples supplied in the population map against the catalog.

rule sstacks:
    input:
        "results/lib5/stacks_denovo/cstacks/catalog.tags.tsv.gz",
        "results/lib5/stacks_denovo/cstacks/catalog.snps.tsv.gz",
        "results/lib5/stacks_denovo/cstacks/catalog.alleles.tsv.gz",
        "results/lib5/stacks_denovo/cstacks/catalog.sample_list.tsv.gz"
    output:
        "results/lib5/stacks_denovo/sstacks/{sample}.matches.tsv.gz"
    params:
        popmap=config["popmap"],
    conda:
        "stacks-2.65"
    resources:
        cpus=10,
        mem_mb=37400,
        qos="long",
        time="72:00:00"
    log:
        "results/lib5/logs/stacks_denovo/sstacks/{sample}.log"
    benchmark:
        "results/lib5/benchmarks/stacks_denovo/sstacks/{sample}.bmk"
    shell:
        " (sstacks				"
        " -P results/lib5/stacks_denovo/cstacks/	"
        " -o results/lib5/stacks_denovo/sstacks/     "
        " -M {params.popmap} -p 10)		"
        " 2> {log}				"
