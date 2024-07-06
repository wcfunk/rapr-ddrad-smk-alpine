# Build a paired-end contig from the metapopulation data, align reads per sample
# call variant sites in the population, genotypes in each individual.

rule gstacks:
    input:
        expand("results/lib2/stacks_denovo/{s}.matches.bam", s=SAMPLES)
    output:
        "results/lib2/stacks_denovo/catalog.fa.gz",
        "results/lib2/stacks_denovo/catalog.calls"
    params:
        popmap=config["popmap"],
    conda:
        "stacks-2.65"
    resources:
        cpus=48,
        mem=179520,
        qos="long",
        time="7-00:00:00"
    log:
        "results/lib2/logs/stacks_denovo/gstacks/gstacks.log"
    benchmark:
        "results/lib2/benchmarks/stacks_denovo/gstacks/gstacks.bmk"
    shell:
        " (gstacks				"
        " -P results/lib2/stacks_denovo/	"
        " -O results/lib2/stacks_denovo/	"
        " -M {params.popmap} -t 48)		"
        " 2> {log}				"
