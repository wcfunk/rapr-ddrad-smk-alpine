# Build the catalog of loci available in the metapopulation from the samples contained
# in the population map.

rule cstacks:
    input:
        expand("results/lib7/stacks_denovo/ustacks/{s}.1.tags.tsv.gz", s=SAMPLES),	
        expand("results/lib7/stacks_denovo/ustacks/{s}.1.snps.tsv.gz", s=SAMPLES),
        expand("results/lib7/stacks_denovo/ustacks/{s}.1.alleles.tsv.gz", s=SAMPLES)
    output:
        "results/lib7/stacks_denovo/cstacks/catalog.tags.tsv.gz",
        "results/lib7/stacks_denovo/cstacks/catalog.snps.tsv.gz",
        "results/lib7/stacks_denovo/cstacks/catalog.alleles.tsv.gz",
        "results/lib7/stacks_denovo/cstacks/catalog.sample_list.tsv.gz"
    params:
        popmap=config["popmap"],
    conda:
        "stacks-2.65"
    resources:
        cpus=24,
        mem_mb=89760,
        qos="long",
        time="7-00:00:00"
    log:
        "results/lib7/logs/stacks_denovo/cstacks/cstacks.log"
    benchmark:
        "results/lib7/benchmarks/stacks_denovo/cstacks/cstacks.bmk"
    shell:
        " (cstacks				"
        " -P results/lib7/stacks_denovo/ustacks/	"
        " -M {params.popmap}			"
        " -n 3 -p 24) 2> {log}			"
