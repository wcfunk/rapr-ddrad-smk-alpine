# Build a paired-end contig from the metapopulation data, align reads per sample
# call variant sites in the population, genotypes in each individual.

rule gstacks:
    input:
        expand("results/WA_no_libs10and12/stacks_denovo/{s}.tags.tsv.gz", s=SAMPLES),    
        expand("results/WA_no_libs10and12/stacks_denovo/{s}.snps.tsv.gz", s=SAMPLES),
        expand("results/WA_no_libs10and12/stacks_denovo/{s}.alleles.tsv.gz", s=SAMPLES),
        "results/WA_no_libs10and12/stacks_denovo/catalog.tags.tsv.gz",
        "results/WA_no_libs10and12/stacks_denovo/catalog.snps.tsv.gz",
        "results/WA_no_libs10and12/stacks_denovo/catalog.alleles.tsv.gz",
        "results/WA_no_libs10and12/stacks_denovo/catalog.sample_list.tsv.gz",
        expand("results/WA_no_libs10and12/stacks_denovo/{s}.matches.tsv.gz", s=SAMPLES),
        expand("results/WA_no_libs10and12/stacks_denovo/{s}.matches.bam", s=SAMPLES)
    output:
        "results/WA_no_libs10and12/stacks_denovo/catalog.fa.gz",
        "results/WA_no_libs10and12/stacks_denovo/catalog.calls"
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
        "results/WA_no_libs10and12/logs/stacks_denovo/gstacks/gstacks.log"
    benchmark:
        "results/WA_no_libs10and12/benchmarks/stacks_denovo/gstacks/gstacks.bmk"
    shell:
        " (gstacks				"
        " -P results/WA_no_libs10and12/stacks_denovo/	"
        " -O results/WA_no_libs10and12/stacks_denovo/	"
        " -M {params.popmap} -t 24)		"
        " 2> {log}				"
