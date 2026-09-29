# Run populations. Calculate total number of loci, number of polymorphic loci, and 
# number of variants when -R=0.30 (treating all individuals as a single population)

rule populations:
    input:
        "results/rapr_raau_raca/rapr_no_reps_rerun/stacks_denovo/catalog.fa.gz",
        "results/rapr_raau_raca/rapr_no_reps_rerun/stacks_denovo/catalog.calls"
    output:
        "results/rapr_raau_raca/rapr_no_reps_rerun/populations/populations.snps.vcf"
    threads: 48
    resources:
        mem_mb=179520,
        time="12:00:00"
    conda:
        "stacks2.68-3"
    log:
        "results/rapr_raau_raca/rapr_no_reps_rerun/logs/populations/populations.log"
    benchmark:
        "results/rapr_raau_raca/rapr_no_reps_rerun/benchmarks/populations/populations.bmk"
    shell:
        " (populations				"
        " -P results/rapr_raau_raca/rapr_no_reps_rerun/stacks_denovo/ 	"
        " -O results/rapr_raau_raca/rapr_no_reps_rerun/populations/ 		"
        " -M rapr-ddrad-smk-alpine/data/popmap_rapr_miss_remov.tsv			" 
        " --vcf			"
        " -p 1		"
        " -r 0.5		"
        " --min-mac 2			"
        " --write-single-snp			"
        " -t {threads})				"
        " 2> {log}			"
