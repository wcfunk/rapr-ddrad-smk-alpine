# Run populations. Calculate Hardy-Weinberg deviation, population statistics, f-statistics
# export several output files.

rule populations:
    input:
        "results/WA_no_libs10and12/stacks_denovo/catalog.fa.gz",
        "results/WA_no_libs10and12/stacks_denovo/catalog.calls"
    output:
        "results/WA_no_libs10and12/populations/populations.snps.vcf"
    params:
        popmap=config["popmap"],
    resources:
        cpus=24,         
        mem_mb=89760,
        qos="long",
        time="7-00:00:00"
    conda:
        "stacks-2.65"
    log:
        "results/WA_no_libs10and12/logs/populations/populations.log"
    shell:
        " (populations				"
        " -P results/WA_no_libs10and12/stacks_denovo/ 	"
        " -O results/WA_no_libs10and12/populations/ 		"
        " -M {params.popmap}			" 
        " -p 2 -r 0.5 --min-maf 0.1		"
        " --write-random-snp 			"
        " --fstats --hwe --genepop --vcf	"
        " -t 24)				"
        " 2> {log}				"
