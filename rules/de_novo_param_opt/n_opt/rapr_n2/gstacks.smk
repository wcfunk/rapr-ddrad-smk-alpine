# Build a paired-end contig from the metapopulation data, align reads per sample
# call variant sites in the population, genotypes in each individual.

rule gstacks:
    input:
        expand("results/de_novo_param_opt/n_opt/rapr_n2/stacks_denovo/{s}.tags.tsv.gz", s=SAMPLES),    
        expand("results/de_novo_param_opt/n_opt/rapr_n2/stacks_denovo/{s}.snps.tsv.gz", s=SAMPLES),
        expand("results/de_novo_param_opt/n_opt/rapr_n2/stacks_denovo/{s}.alleles.tsv.gz", s=SAMPLES),
        "results/de_novo_param_opt/n_opt/rapr_n2/stacks_denovo/catalog.tags.tsv.gz",
        "results/de_novo_param_opt/n_opt/rapr_n2/stacks_denovo/catalog.snps.tsv.gz",
        "results/de_novo_param_opt/n_opt/rapr_n2/stacks_denovo/catalog.alleles.tsv.gz",
        "results/de_novo_param_opt/n_opt/rapr_n2/stacks_denovo/catalog.sample_list.tsv.gz",
        expand("results/de_novo_param_opt/n_opt/rapr_n2/stacks_denovo/{s}.matches.tsv.gz", s=SAMPLES),
        expand("results/de_novo_param_opt/n_opt/rapr_n2/stacks_denovo/{s}.matches.bam", s=SAMPLES)
    output:
        "results/de_novo_param_opt/n_opt/rapr_n2/stacks_denovo/catalog.fa.gz",
        "results/de_novo_param_opt/n_opt/rapr_n2/stacks_denovo/catalog.calls"
    conda:
        "stacks2.68-3"
    threads: 12
    resources:
        mem_mb=44880,
        time="12:00:00"
    log:
        "results/de_novo_param_opt/n_opt/rapr_n2/logs/stacks_denovo/gstacks/gstacks.log"
    benchmark:
        "results/de_novo_param_opt/n_opt/rapr_n2/benchmarks/stacks_denovo/gstacks/gstacks.bmk"
    shell:
        " (gstacks				"
        " -P results/de_novo_param_opt/n_opt/rapr_n2/stacks_denovo/	"
        " -O results/de_novo_param_opt/n_opt/rapr_n2/stacks_denovo/	"
        " -M rapr-ddrad-smk-alpine/data/popmap_dnpo_rapr.tsv -t {threads})		"
        " 2> {log}				"
