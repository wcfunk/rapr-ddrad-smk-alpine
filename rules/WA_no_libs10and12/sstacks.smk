# Run sstacks. Match all samples supplied in the population map against the catalog.

rule sstacks:
    input:
        "results/WA_no_libs10and12/stacks_denovo/{sample}.tags.tsv.gz",
        "results/WA_no_libs10and12/stacks_denovo/{sample}.snps.tsv.gz",
        "results/WA_no_libs10and12/stacks_denovo/{sample}.alleles.tsv.gz",
        "results/WA_no_libs10and12/stacks_denovo/catalog.tags.tsv.gz",
        "results/WA_no_libs10and12/stacks_denovo/catalog.snps.tsv.gz",
        "results/WA_no_libs10and12/stacks_denovo/catalog.alleles.tsv.gz",
        "results/WA_no_libs10and12/stacks_denovo/catalog.sample_list.tsv.gz"
    output:
        "results/WA_no_libs10and12/stacks_denovo/{sample}.matches.tsv.gz"
    params:
        popmap=config["popmap"],
    conda:
        "stacks-2.65"
    resources:
        cpus=24,
        mem_mb=89760,
        time="24:00:00"
    log:
        "results/WA_no_libs10and12/logs/stacks_denovo/sstacks/{sample}.log"
    benchmark:
        "results/WA_no_libs10and12/benchmarks/stacks_denovo/sstacks/{sample}.bmk"
    shell:
        " (sstacks				"
        " -P results/WA_no_libs10and12/stacks_denovo/	"
        " -M rapr-ddrad-smk-alpine/data/popmap_WA_no_libs10and12_by_sample/popmap_WA_no_libs10and12_{wildcards.sample}.tsv -p 24)		"
        " 2> {log}				"
