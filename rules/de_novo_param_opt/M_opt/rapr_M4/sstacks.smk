# Run sstacks. Match all samples supplied in the population map against the catalog.

rule sstacks:
    input:
        "results/de_novo_param_opt/M_opt/rapr_M4/stacks_denovo/{sample}.tags.tsv.gz",
        "results/de_novo_param_opt/M_opt/rapr_M4/stacks_denovo/{sample}.snps.tsv.gz",
        "results/de_novo_param_opt/M_opt/rapr_M4/stacks_denovo/{sample}.alleles.tsv.gz",
        "results/de_novo_param_opt/M_opt/rapr_M4/stacks_denovo/catalog.tags.tsv.gz",
        "results/de_novo_param_opt/M_opt/rapr_M4/stacks_denovo/catalog.snps.tsv.gz",
        "results/de_novo_param_opt/M_opt/rapr_M4/stacks_denovo/catalog.alleles.tsv.gz",
        "results/de_novo_param_opt/M_opt/rapr_M4/stacks_denovo/catalog.sample_list.tsv.gz"
    output:
        "results/de_novo_param_opt/M_opt/rapr_M4/stacks_denovo/{sample}.matches.tsv.gz"
    conda:
        "stacks2.68-3"
    threads: 24
    resources:
        mem_mb=89760,
        time="4:00:00"
    log:
        "results/de_novo_param_opt/M_opt/rapr_M4/logs/stacks_denovo/sstacks/{sample}.log"
    benchmark:
        "results/de_novo_param_opt/M_opt/rapr_M4/benchmarks/stacks_denovo/sstacks/{sample}.bmk"
    shell:
        " (sstacks				"
        " -P results/de_novo_param_opt/M_opt/rapr_M4/stacks_denovo/	"
        " -M rapr-ddrad-smk-alpine/data/popmap_dnpo_rapr_by_sample/popmap_dnpo_rapr_{wildcards.sample}.tsv -p {threads})		"
        " 2> {log}				"
