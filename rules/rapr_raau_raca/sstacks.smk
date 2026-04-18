# Run sstacks. Match all samples supplied in the population map against the catalog.

rule sstacks:
    input:
        "results/rapr_raau_raca/stacks_denovo/{sample}.tags.tsv.gz",
        "results/rapr_raau_raca/stacks_denovo/{sample}.snps.tsv.gz",
        "results/rapr_raau_raca/stacks_denovo/{sample}.alleles.tsv.gz",
        "results/rapr_raau_raca/stacks_denovo/catalog.tags.tsv.gz",
        "results/rapr_raau_raca/stacks_denovo/catalog.snps.tsv.gz",
        "results/rapr_raau_raca/stacks_denovo/catalog.alleles.tsv.gz",
        "results/rapr_raau_raca/stacks_denovo/catalog.sample_list.tsv.gz"
    output:
        "results/rapr_raau_raca/stacks_denovo/{sample}.matches.tsv.gz"
    params:
        popmap=config["popmap"],
    conda:
        "stacks2.68-3"
    resources:
        cpus=24,
        mem_mb=89760,
        time="24:00:00"
    log:
        "results/rapr_raau_raca/logs/stacks_denovo/sstacks/{sample}.log"
    benchmark:
        "results/rapr_raau_raca/benchmarks/stacks_denovo/sstacks/{sample}.bmk"
    shell:
        " (sstacks				"
        " -P results/rapr_raau_raca/stacks_denovo/	"
        " -M rapr-ddrad-smk-alpine/data/popmap_rapr_raau_raca_by_sample/popmap_rapr_raau_raca_{wildcards.sample}.tsv -p 24)		"
        " 2> {log}				"
