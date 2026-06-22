# Build a paired-end contig from the metapopulation data, align reads per sample
# call variant sites in the population, genotypes in each individual.

rule gstacks:
    input:
        expand("results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/{s}.tags.tsv.gz", s=SAMPLES),    
        expand("results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/{s}.snps.tsv.gz", s=SAMPLES),
        expand("results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/{s}.alleles.tsv.gz", s=SAMPLES),
        "results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/catalog.tags.tsv.gz",
        "results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/catalog.snps.tsv.gz",
        "results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/catalog.alleles.tsv.gz",
        "results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/catalog.sample_list.tsv.gz",
        expand("results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/{s}.matches.tsv.gz", s=SAMPLES),
        expand("results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/{s}.matches.bam", s=SAMPLES)
    output:
        "results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/catalog.fa.gz",
        "results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/catalog.calls"
    conda:
        "stacks2.68-3"
    threads: 12
    resources:
        mem_mb=44880,
        time="12:00:00"
    log:
        "results/rapr_raau_raca/all_3_spp_no_reps/logs/stacks_denovo/gstacks/gstacks.log"
    benchmark:
        "results/rapr_raau_raca/all_3_spp_no_reps/benchmarks/stacks_denovo/gstacks/gstacks.bmk"
    shell:
        " (gstacks				"
        " -P results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/	"
        " -O results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/	"
        " -M rapr-ddrad-smk-alpine/data/popmap_all_3_spp_no_reps.tsv -t {threads})		"
        " 2> {log}				"
