# Build the catalog of loci available in the metapopulation from the samples contained
# in the population map.

rule cstacks:
    input:
        expand("results/rapr_raau_raca/stacks_denovo/{s}.tags.tsv.gz", s=SAMPLES),	
        expand("results/rapr_raau_raca/stacks_denovo/{s}.snps.tsv.gz", s=SAMPLES),
        expand("results/rapr_raau_raca/stacks_denovo/{s}.alleles.tsv.gz", s=SAMPLES)
    output:
        "results/rapr_raau_raca/stacks_denovo/catalog.tags.tsv.gz",
        "results/rapr_raau_raca/stacks_denovo/catalog.snps.tsv.gz",
        "results/rapr_raau_raca/stacks_denovo/catalog.alleles.tsv.gz",
        "results/rapr_raau_raca/stacks_denovo/catalog.sample_list.tsv.gz"
    params:
        popmap=config["popmap"],
    conda:
        "stacks2.68-3"
    resources:
        cpus=24,
        mem_mb=89760,
        qos="long",
        time="7-00:00:00"
    log:
        "results/rapr_raau_raca/logs/stacks_denovo/cstacks/cstacks.log"
    benchmark:
        "results/rapr_raau_raca/benchmarks/stacks_denovo/cstacks/cstacks.bmk"
    shell:
        " (cstacks				"
        " -P results/rapr_raau_raca/stacks_denovo/	"
        " -M rapr-ddrad-smk-alpine/data/popmap_rapr_raau_raca_cstacks.tsv			"
        " -n 3 -p 24) 2> {log}			"
