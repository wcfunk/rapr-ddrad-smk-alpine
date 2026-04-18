# Transpose the data so it is stored by locus, instead of by sample. We will include
# paired-end reads using tsv2bam.

rule tsv2bam:
    input:
        "results/rapr_raau_raca/process_radtags/{sample}.2.fq.gz",
        "results/rapr_raau_raca/stacks_denovo/{sample}.matches.tsv.gz",
        "results/rapr_raau_raca/stacks_denovo/catalog.tags.tsv.gz",
        "results/rapr_raau_raca/stacks_denovo/catalog.snps.tsv.gz",
        "results/rapr_raau_raca/stacks_denovo/catalog.alleles.tsv.gz",
        "results/rapr_raau_raca/stacks_denovo/catalog.sample_list.tsv.gz"
    output:
        "results/rapr_raau_raca/stacks_denovo/{sample}.matches.bam"
    params:
        popmap=config["popmap"],
    conda:
        "stacks2.68-3"
    resources:
        cpus=24,
        mem_mb=89760,
        time="3:00:00"
    log:
        "results/rapr_raau_raca/logs/stacks_denovo/tsv2bam/{sample}.log"
    benchmark:
        "results/rapr_raau_raca/benchmarks/stacks_denovo/tsv2bam/{sample}.bmk"
    shell:
        " (tsv2bam				"
        " -P results/rapr_raau_raca/stacks_denovo/	"
        " -R results/rapr_raau_raca/process_radtags/   	"
        " -M rapr-ddrad-smk-alpine/data/popmap_rapr_raau_raca_by_sample/popmap_rapr_raau_raca_{wildcards.sample}.tsv -t 24) 		"
        " 2> {log}				"
