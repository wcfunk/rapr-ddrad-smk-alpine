# Build a paired-end contig from the metapopulation data, align reads per sample
# call variant sites in the population, genotypes in each individual.

rule gstacks:
    input:
        expand("results/lib3/stacks_denovo/tsv2bam/{s}.matches.bam", s=SAMPLES)
    output:
        "results/lib3/stacks_denovo/gstacks/catalog.fa.gz",
        "results/lib3/stacks_denovo/gstacks/catalog.calls"
    params:
        popmap=config["popmap"],
    conda:
        "stacks-2.65"
    resources:
        cpus=24,
        mem=89760,
        time="7-00:00:00"
    log:
        "results/lib3/logs/stacks_denovo/gstacks/gstacks.log"
    benchmark:
        "results/lib3/benchmarks/stacks_denovo/gstacks/gstacks.bmk"
    shell:
        " (gstacks				"
        " -P results/lib3/stacks_denovo/tsv2bam/	"
        " -O results/lib3/stacks_denovo/gstacks/	"
        " -M {params.popmap} -t 24)		"
        " 2> {log}				"
