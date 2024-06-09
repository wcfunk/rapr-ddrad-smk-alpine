# Run populations. Calculate Hardy-Weinberg deviation, population statistics, f-statistics
# export several output files.

rule populations:
    input:
        "results/lib5/stacks_denovo/gstacks/catalog.fa.gz",
        "results/lib5/stacks_denovo/gstacks/catalog.calls"
    output:
        "results/lib5/populations/populations.snps.vcf"
    params:
        popmap=config["popmap"],
    resources:
        cpus=24,         
        mem_mb=89760,
        time="7-00:00:00"
    conda:
        "stacks-2.65"
    log:
        "results/lib5/logs/populations/populations.log"
    shell:
        " (populations				"
        " -P results/lib5/stacks_denovo/gstacks/ 	"
        " -O results/lib5/populations/ 		"
        " -M {params.popmap}			" 
        " -p 2 -r 0.5 --min-maf 0.1		"
        " --write-random-snp 			"
        " --fstats --hwe --genepop --vcf	"
        " -t 24)				"
        " 2> {log}				"
