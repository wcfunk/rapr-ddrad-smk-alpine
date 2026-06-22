# Run sstacks. Match all samples supplied in the population map against the catalog.

rule sstacks:
    input:
        "results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/{sample}.tags.tsv.gz",
        "results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/{sample}.snps.tsv.gz",
        "results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/{sample}.alleles.tsv.gz",
        "results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/catalog.tags.tsv.gz",
        "results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/catalog.snps.tsv.gz",
        "results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/catalog.alleles.tsv.gz",
        "results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/catalog.sample_list.tsv.gz"
    output:
        "results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/{sample}.matches.tsv.gz"
    conda:
        "stacks2.68-3"
    threads: 24
    resources:
        mem_mb=89760,
        time="4:00:00"
    log:
        "results/rapr_raau_raca/all_3_spp_no_reps/logs/stacks_denovo/sstacks/{sample}.log"
    benchmark:
        "results/rapr_raau_raca/all_3_spp_no_reps/benchmarks/stacks_denovo/sstacks/{sample}.bmk"
    shell:
        " (sstacks				"
        " -P results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/	"
        " -M rapr-ddrad-smk-alpine/data/popmap_all_3_spp_no_reps_by_sample/popmap_all_3_spp_no_reps_{wildcards.sample}.tsv -p {threads})		"
        " 2> {log}				"
