# Run populations. Calculate Hardy-Weinberg deviation, population statistics, f-statistics
# export several output files.

rule populations:
    input:
        "results/lib7/stacks_denovo/gstacks/catalog.fa.gz",
        "results/lib7/stacks_denovo/gstacks/catalog.calls"
    output:
        "results/lib7/populations/populations.snps.vcf"
    params:
        popmap=config["popmap"],
    resources:
        cpus=24,         
        mem_mb=89760,
        time="7-00:00:00"
    conda:
        "stacks-2.65"
    log:
        "results/lib7/logs/populations/populations.log"
    shell:
        " (populations				"
        " -P results/lib7/stacks_denovo/gstacks/ 	"
        " -O results/lib7/populations/ 		"
        " -M {params.popmap}			" 
        " -p 2 -r 0.5 --min-maf 0.1		"
        " --write-random-snp 			"
        " --fstats --hwe --genepop --vcf	"
        " -t 24)				"
        " 2> {log}				"
