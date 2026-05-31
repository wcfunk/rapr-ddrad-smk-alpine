# Build the catalog of loci available in the metapopulation from the samples contained
# in the population map.

SAMPLES = [
    "OSF_ERAAU_1",
    "OSF_ERAAU_2",
    "OSF_ERAAU_3",
    "OSF_ERAAU_4",
    "OSF_ERAAU_5"
]

rule cstacks:
    input:
        expand("results/de_novo_param_opt/M_opt/raau_M5/stacks_denovo/{s}.tags.tsv.gz", s=SAMPLES),	
        expand("results/de_novo_param_opt/M_opt/raau_M5/stacks_denovo/{s}.snps.tsv.gz", s=SAMPLES),
        expand("results/de_novo_param_opt/M_opt/raau_M5/stacks_denovo/{s}.alleles.tsv.gz", s=SAMPLES)
    output:
        "results/de_novo_param_opt/M_opt/raau_M5/stacks_denovo/catalog.tags.tsv.gz",
        "results/de_novo_param_opt/M_opt/raau_M5/stacks_denovo/catalog.snps.tsv.gz",
        "results/de_novo_param_opt/M_opt/raau_M5/stacks_denovo/catalog.alleles.tsv.gz",
        "results/de_novo_param_opt/M_opt/raau_M5/stacks_denovo/catalog.sample_list.tsv.gz"
    conda:
        "stacks2.68-3"
    threads: 12
    resources:
        mem_mb=44880,
        qos="normal",
        time="4:00:00"
    log:
        "results/de_novo_param_opt/M_opt/raau_M5/logs/stacks_denovo/cstacks/cstacks.log"
    benchmark:
        "results/de_novo_param_opt/M_opt/raau_M5/benchmarks/stacks_denovo/cstacks/cstacks.bmk"
    shell:
        " (cstacks				"
        " -P results/de_novo_param_opt/M_opt/raau_M5/stacks_denovo/	"
        " -M rapr-ddrad-smk-alpine/data/popmap_dnpo_raau.tsv			"
        " -n 5 -p {threads}) 2> {log}			"
