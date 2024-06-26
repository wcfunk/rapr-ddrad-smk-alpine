# Build the catalog of loci available in the metapopulation from the samples contained
# in the population map.

rule cstacks:
    input:
        expand("results/lib5/stacks_denovo/rename_ustacks/{s}.tags.tsv.gz", s=SAMPLES),	
        expand("results/lib5/stacks_denovo/rename_ustacks/{s}.snps.tsv.gz", s=SAMPLES),
        expand("results/lib5/stacks_denovo/rename_ustacks/{s}.alleles.tsv.gz", s=SAMPLES)
    output:
        "results/lib5/stacks_denovo/rename_ustacks/catalog.tags.tsv.gz",
        "results/lib5/stacks_denovo/rename_ustacks/catalog.snps.tsv.gz",
        "results/lib5/stacks_denovo/rename_ustacks/catalog.alleles.tsv.gz",
        "results/lib5/stacks_denovo/rename_ustacks/catalog.sample_list.tsv.gz"
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
        "results/lib5/logs/stacks_denovo/cstacks/cstacks.log"
    benchmark:
        "results/lib5/benchmarks/stacks_denovo/cstacks/cstacks.bmk"
    shell:
        " (cstacks				"
        " -P results/lib5/stacks_denovo/rename_ustacks/	"
        " -M {params.popmap}			"
        " -n 3 -p 24) 2> {log}			"
