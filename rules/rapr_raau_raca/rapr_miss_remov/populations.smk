# Run populations. Calculate total number of loci, number of polymorphic loci, and 
# number of variants when -R=0.30 (treating all individuals as a single population)

rule populations:
    input:
        "results/rapr_raau_raca/rapr_no_reps_rerun/stacks_denovo/catalog.fa.gz",
        "results/rapr_raau_raca/rapr_no_reps_rerun/stacks_denovo/catalog.calls"
    output:
        "results/rapr_raau_raca/rapr_miss_remov/populations/populations.snps.vcf"
    threads: 24
    resources:
        mem_mb=89760,
        time="4:00:00"
    conda:
        "stacks2.68-3"
    log:
        "results/rapr_raau_raca/rapr_miss_remov/logs/populations/populations.log"
    benchmark:
        "results/rapr_raau_raca/rapr_miss_remov/benchmarks/populations/populations.bmk"
    shell:
        " (populations				"
        " -P results/rapr_raau_raca/rapr_no_reps_rerun/stacks_denovo/ 	"
        " -O results/rapr_raau_raca/rapr_miss_remov/populations/ 		"
        " -M rapr-ddrad-smk-alpine/data/popmap_rapr_miss_remov.tsv			" 
        " --vcf			"
        " -p 55		"
        " -r 0.5		"
        " --min-mac 2			"
        " --write-single-snp			"
        " -t {threads})				"
        " 2> {log}			"
