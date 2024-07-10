# Transpose the data so it is stored by locus, instead of by sample. We will include
# paired-end reads using tsv2bam.

rule tsv2bam:
    input:
        "results/WA_no_libs10and12/process_radtags/{sample}.2.fq.gz",
        "results/WA_no_libs10and12/stacks_denovo/{sample}.matches.tsv.gz",
        "results/WA_no_libs10and12/stacks_denovo/catalog.tags.tsv.gz",
        "results/WA_no_libs10and12/stacks_denovo/catalog.snps.tsv.gz",
        "results/WA_no_libs10and12/stacks_denovo/catalog.alleles.tsv.gz",
        "results/WA_no_libs10and12/stacks_denovo/catalog.sample_list.tsv.gz"
    output:
        "results/WA_no_libs10and12/stacks_denovo/{sample}.matches.bam"
    params:
        popmap=config["popmap"],
    conda:
        "stacks-2.65"
    resources:
        cpus=24,
        mem_mb=89760,
        time="3:00:00"
    log:
        "results/WA_no_libs10and12/logs/stacks_denovo/tsv2bam/{sample}.log"
    benchmark:
        "results/WA_no_libs10and12/benchmarks/stacks_denovo/tsv2bam/{sample}.bmk"
    shell:
        " (tsv2bam				"
        " -P results/WA_no_libs10and12/stacks_denovo/	"
        " -R results/WA_no_libs10and12/process_radtags/   	"
        " -M rapr-ddrad-smk-alpine/data/popmap_WA_no_libs10and12_by_sample/popmap_WA_no_libs10and12_{wildcards.sample}.tsv -t 24) 		"
        " 2> {log}				"
