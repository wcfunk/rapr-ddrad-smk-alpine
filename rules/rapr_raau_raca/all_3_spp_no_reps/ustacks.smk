# Build loci de novo in each sample

rule ustacks:
    input:
        R1="results/rapr_raau_raca/process_radtags/all_3_spp_no_dnpo_samples_or_reps/{sample}.1.fq.gz",
    output:
        tags1="results/rapr_raau_raca/all_3_spp_no_reps/ustacks/{sample}.1.tags.tsv.gz",	
        snps1="results/rapr_raau_raca/all_3_spp_no_reps/ustacks/{sample}.1.snps.tsv.gz",
        alleles1="results/rapr_raau_raca/all_3_spp_no_reps/ustacks/{sample}.1.alleles.tsv.gz"
    conda:
        "stacks2.68-3"
    threads: 48
    resources:
        mem_mb=179520,
        qos="normal",
        time="24:00:00"
    log:
        "results/rapr_raau_raca/all_3_spp_no_reps/logs/stacks_denovo/ustacks/{sample}.log"
    benchmark:
        "results/rapr_raau_raca/all_3_spp_no_reps/benchmarks/stacks_denovo/ustacks/{sample}.bmk"
    shell:
        " (ustacks -f {input.R1}			"
        " -o results/rapr_raau_raca/all_3_spp_no_reps/ustacks/		"
        " -m 3 -M 2 --deleverage -t gzfastq -p {threads}			"
        " --model_type bounded --bound_high 0.05)	"
        "  2> {log}					"
