# Transpose the data so it is stored by locus, instead of by sample. We will include
# paired-end reads using tsv2bam.

rule tsv2bam:
    input:
        "results/rapr_raau_raca/process_radtags/raau/{sample}.2.fq.gz",
        "results/de_novo_param_opt/M_opt/raau_M5/stacks_denovo/{sample}.matches.tsv.gz",
        "results/de_novo_param_opt/M_opt/raau_M5/stacks_denovo/catalog.tags.tsv.gz",
        "results/de_novo_param_opt/M_opt/raau_M5/stacks_denovo/catalog.snps.tsv.gz",
        "results/de_novo_param_opt/M_opt/raau_M5/stacks_denovo/catalog.alleles.tsv.gz",
        "results/de_novo_param_opt/M_opt/raau_M5/stacks_denovo/catalog.sample_list.tsv.gz"
    output:
        "results/de_novo_param_opt/M_opt/raau_M5/stacks_denovo/{sample}.matches.bam"
    conda:
        "stacks2.68-3"
    threads: 8
    resources:
        mem_mb=29920,
        time="1:00:00"
    log:
        "results/de_novo_param_opt/M_opt/raau_M5/logs/stacks_denovo/tsv2bam/{sample}.log"
    benchmark:
        "results/de_novo_param_opt/M_opt/raau_M5/benchmarks/stacks_denovo/tsv2bam/{sample}.bmk"
    shell:
        " (tsv2bam				"
        " -P results/de_novo_param_opt/M_opt/raau_M5/stacks_denovo/	"
        " -R results/rapr_raau_raca/process_radtags/raau/   	"
        " -M rapr-ddrad-smk-alpine/data/popmap_dnpo_raau_by_sample/popmap_dnpo_raau_{wildcards.sample}.tsv -t {threads}) 		"
        " 2> {log}				"
