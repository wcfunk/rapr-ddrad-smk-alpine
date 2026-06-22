# Run populations. Calculate total number of loci, number of polymorphic loci, and 
# number of variants when -r=0.80 (treating all individuals as a single population)

rule populations:
    input:
        "results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/catalog.fa.gz",
        "results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/catalog.calls"
    output:
        "results/rapr_raau_raca/all_3_spp_no_reps/populations/populations.snps.vcf"
    threads: 12
    resources:
        mem_mb=44880,
        time="12:00:00"
    conda:
        "stacks2.68-3"
    log:
        "results/rapr_raau_raca/all_3_spp_no_reps/logs/populations/populations.log"
    benchmark:
        "results/rapr_raau_raca/all_3_spp_no_reps/benchmarks/populations/populations.bmk"
    shell:
        " (populations				"
        " -P results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/ 	"
        " -O results/rapr_raau_raca/all_3_spp_no_reps/populations/ 		"
        " -M rapr-ddrad-smk-alpine/data/popmap_all_3_spp_no_reps.tsv.tsv			" 
        " --vcf			"
        " -p 1		"
        " -R 0.3		"
        " --min-mac 2			"
        " --fstats			"
        " -t {threads})				"
        " 2> {log}			"
