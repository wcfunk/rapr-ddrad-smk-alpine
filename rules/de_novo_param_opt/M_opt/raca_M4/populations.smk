# Run populations. Calculate total number of loci, number of polymorphic loci, and 
# number of variants when -r=0.80 (treating all individuals as a single population)

rule populations:
    input:
        "results/de_novo_param_opt/M_opt/raca_M4/stacks_denovo/catalog.fa.gz",
        "results/de_novo_param_opt/M_opt/raca_M4/stacks_denovo/catalog.calls"
    output:
        "results/de_novo_param_opt/M_opt/raca_M4/populations/populations.snps.vcf"
    threads: 12
    resources:
        mem_mb=44880,
        time="12:00:00"
    conda:
        "stacks2.68-3"
    log:
        "results/de_novo_param_opt/M_opt/raca_M4/logs/populations/populations.log"
    benchmark:
        "results/de_novo_param_opt/M_opt/raca_M4/benchmarks/populations/populations.bmk"
    shell:
        " (populations				"
        " -P results/de_novo_param_opt/M_opt/raca_M4/stacks_denovo/ 	"
        " -O results/de_novo_param_opt/M_opt/raca_M4/populations/ 		"
        " -M rapr-ddrad-smk-alpine/data/popmap_dnpo_raca.tsv			" 
        " --vcf			"
        " -r 0.8		"
        " -t {threads})				"
        " 2> {log}			"
