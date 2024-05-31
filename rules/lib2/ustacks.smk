# Build loci de novo in each sample

rule ustacks:
    input:
        R1="results/lib2/process_radtags/{sample}.1.fq.gz",
    output:
        tags="results/lib2/stacks_denovo/ustacks/{sample}.1.tags.tsv.gz",	
        snps="results/lib2/stacks_denovo/ustacks/{sample}.1.snps.tsv.gz",
        alleles="results/lib2/stacks_denovo/ustacks/{sample}.1.alleles.tsv.gz"
    conda:
        "stacks-2.65"
    resources:
        cpus=24,
        mem_mb=89760,
        qos="long",
        time="72:00:00"
    log:
        "results/lib2/logs/stacks_denovo/ustacks/{sample}.log"
    benchmark:
        "results/lib2/benchmarks/stacks_denovo/ustacks/{sample}.bmk"
    shell:
        " (ustacks -f {input.R1}			"
        " -o results/lib2/stacks_denovo/ustacks/		"
        " -m 3 -M 2 -d -t gzfastq -p 10			"
        " --model_type bounded --bound_high 0.05)	"
        "  2> {log}					"
