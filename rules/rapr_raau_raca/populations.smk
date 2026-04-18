# Run populations. Calculate Hardy-Weinberg deviation, population statistics, f-statistics
# export several output files.

rule populations:
    input:
        "results/rapr_raau_raca/stacks_denovo/catalog.fa.gz",
        "results/rapr_raau_raca/stacks_denovo/catalog.calls"
    output:
        "results/rapr_raau_raca/populations/populations.snps.vcf"
    params:
        popmap=config["popmap"],
    resources:
        cpus=24,         
        mem_mb=89760,
        time="24:00:00"
    conda:
        "stacks2.68-3"
    log:
        "results/rapr_raau_raca/logs/populations/populations.log"
    shell:
        " (populations				"
        " -P results/rapr_raau_raca/stacks_denovo/ 	"
        " -O results/rapr_raau_raca/populations/ 		"
        " -M {params.popmap}			" 
        " -p 2 -r 0.5 --min-maf 0.1		"
        " --write-random-snp 			"
        " --fstats --hwe --genepop --vcf	"
        " -t 24)				"
        " 2> {log}				"
