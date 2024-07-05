# Transpose the data so it is stored by locus, instead of by sample. We will include
# paired-end reads using tsv2bam.

rule tsv2bam:
    input:
        "results/lib2/process_radtags/{sample}.2.fq.gz",
        "results/lib2/stacks_denovo/{sample}.matches.tsv.gz",
        "results/lib2/stacks_denovo/catalog.tags.tsv.gz",
        "results/lib2/stacks_denovo/catalog.snps.tsv.gz",
        "results/lib2/stacks_denovo/catalog.alleles.tsv.gz",
        "results/lib2/stacks_denovo/catalog.sample_list.tsv.gz"
    output:
        "results/lib2/stacks_denovo/{sample}.matches.bam"
    params:
        popmap=config["popmap"],
    conda:
        "stacks-2.65"
    resources:
        cpus=10,
        mem_mb=37400,
        time="24:00:00"
    log:
        "results/lib2/logs/stacks_denovo/tsv2bam/{sample}.log"
    benchmark:
        "results/lib2/benchmarks/stacks_denovo/tsv2bam/{sample}.bmk"
    shell:
        " (tsv2bam				"
        " -P results/lib2/stacks_denovo/	"
        " -R results/lib2/process_radtags/   	"
        " -M {params.popmap} -t 10) 		"
        " 2> {log}				"
