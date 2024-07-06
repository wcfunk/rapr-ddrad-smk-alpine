# Build a paired-end contig from the metapopulation data, align reads per sample
# call variant sites in the population, genotypes in each individual.

rule gstacks:
    input:
        expand("results/lib2/stacks_denovo/{s}.tags.tsv.gz", s=SAMPLES),    
        expand("results/lib2/stacks_denovo/{s}.snps.tsv.gz", s=SAMPLES),
        expand("results/lib2/stacks_denovo/{s}.alleles.tsv.gz", s=SAMPLES),
        "results/lib2/stacks_denovo/catalog.tags.tsv.gz",
        "results/lib2/stacks_denovo/catalog.snps.tsv.gz",
        "results/lib2/stacks_denovo/catalog.alleles.tsv.gz",
        "results/lib2/stacks_denovo/catalog.sample_list.tsv.gz",
        expand("results/lib2/stacks_denovo/{s}.matches.tsv.gz", s=SAMPLES),
        expand("results/lib2/stacks_denovo/{s}.matches.bam", s=SAMPLES)
    output:
        "results/lib2/stacks_denovo/catalog.fa.gz",
        "results/lib2/stacks_denovo/catalog.calls"
    params:
        popmap=config["popmap"]
    conda:
        "stacks-2.65"
    resources:
        cpus=24,
        mem_mb=89760,
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
        " -M {params.popmap} -t 24)		"
        " 2> {log}				"
