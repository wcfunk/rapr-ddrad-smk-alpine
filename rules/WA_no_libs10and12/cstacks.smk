# Build the catalog of loci available in the metapopulation from the samples contained
# in the population map.

rule cstacks:
    input:
        expand("results/WA_no_libs10and12/stacks_denovo/{s}.tags.tsv.gz", s=SAMPLES),	
        expand("results/WA_no_libs10and12/stacks_denovo/{s}.snps.tsv.gz", s=SAMPLES),
        expand("results/WA_no_libs10and12/stacks_denovo/{s}.alleles.tsv.gz", s=SAMPLES)
    output:
        "results/WA_no_libs10and12/stacks_denovo/catalog.tags.tsv.gz",
        "results/WA_no_libs10and12/stacks_denovo/catalog.snps.tsv.gz",
        "results/WA_no_libs10and12/stacks_denovo/catalog.alleles.tsv.gz",
        "results/WA_no_libs10and12/stacks_denovo/catalog.sample_list.tsv.gz"
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
        "results/WA_no_libs10and12/logs/stacks_denovo/cstacks/cstacks.log"
    benchmark:
        "results/WA_no_libs10and12/benchmarks/stacks_denovo/cstacks/cstacks.bmk"
    shell:
        " (cstacks				"
        " -P results/WA_no_libs10and12/stacks_denovo/	"
        " -M rapr-ddrad-smk-alpine/data/popmap_WA_no_libs10and12_cstacks_vs2.tsv			"
        " -n 3 -p 24) 2> {log}			"
