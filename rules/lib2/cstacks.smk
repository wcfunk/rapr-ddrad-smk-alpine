# Build the catalog of loci available in the metapopulation from the samples contained
# in the population map.

rule cstacks:
    input:
        expand("results/lib2/stacks_denovo/{s}.tags.tsv.gz", s=SAMPLES),	
        expand("results/lib2/stacks_denovo/{s}.snps.tsv.gz", s=SAMPLES),
        expand("results/lib2/stacks_denovo/{s}.alleles.tsv.gz", s=SAMPLES)
    output:
        "results/lib2/stacks_denovo/catalog.tags.tsv.gz",
        "results/lib2/stacks_denovo/catalog.snps.tsv.gz",
        "results/lib2/stacks_denovo/catalog.alleles.tsv.gz",
        "results/lib2/stacks_denovo/catalog.sample_list.tsv.gz"
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
        "results/lib2/logs/stacks_denovo/cstacks/cstacks.log"
    benchmark:
        "results/lib2/benchmarks/stacks_denovo/cstacks/cstacks.bmk"
    shell:
        " (cstacks				"
        " -P results/lib2/stacks_denovo/	"
        " -M {params.popmap}			"
        " -n 3 -p 24) 2> {log}			"
