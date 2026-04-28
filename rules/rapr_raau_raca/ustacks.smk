# Build loci de novo in each sample

rule ustacks:
    input:
        R1="results/rapr_raau_raca/process_radtags/{sample}.1.fq.gz",
    output:
        tags1="results/rapr_raau_raca/ustacks/{sample}.1.tags.tsv.gz",	
        snps1="results/rapr_raau_raca/ustacks/{sample}.1.snps.tsv.gz",
        alleles1="results/rapr_raau_raca/ustacks/{sample}.1.alleles.tsv.gz"
    conda:
        "stacks2.68-3"
    resources:
        cpus=48,
        mem_mb=179520,
        qos="long",
        time="72:00:00"
    log:
        "results/rapr_raau_raca/logs/stacks_denovo/ustacks/{sample}.log"
    benchmark:
        "results/rapr_raau_raca/benchmarks/stacks_denovo/ustacks/{sample}.bmk"
    shell:
        " (ustacks -f {input.R1}			"
        " -o results/rapr_raau_raca/ustacks/		"
        " -m 3 -M 2 --deleverage -i gzfastq -t 48			"
        " --model_type bounded --bound_high 0.05)	"
        "  2> {log}					"
