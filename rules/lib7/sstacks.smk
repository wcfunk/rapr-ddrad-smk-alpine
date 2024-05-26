# Run sstacks. Match all samples supplied in the population map against the catalog.

rule sstacks:
    input:
        "results/lib7/stacks_denovo/cstacks/catalog.tags.tsv.gz",
        "results/lib7/stacks_denovo/cstacks/catalog.snps.tsv.gz",
        "results/lib7/stacks_denovo/cstacks/catalog.alleles.tsv.gz",
        "results/lib7/stacks_denovo/cstacks/catalog.sample_list.tsv.gz"
    output:
        "results/lib7/stacks_denovo/sstacks/{sample}.matches.tsv.gz"
    params:
        popmap=config["popmap"],
    conda:
        "stacks-2.65"
    resources:
        cpus=10,
        mem_mb=37400,
        time="24:00:00"
    log:
        "results/lib7/logs/stacks_denovo/sstacks/{sample}.log"
    benchmark:
        "results/lib7/benchmarks/stacks_denovo/sstacks/{sample}.bmk"
    shell:
        " (sstacks				"
        " -P results/lib7/stacks_denovo/cstacks/	"
        " -o results/lib7/stacks_denovo/sstacks/     "
        " -M {params.popmap} -p 10)		"
        " 2> {log}				"
