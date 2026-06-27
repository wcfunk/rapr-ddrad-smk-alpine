# Build a paired-end contig from the metapopulation data, align reads per sample
# call variant sites in the population, genotypes in each individual.

rule gstacks:
    input:
        expand("results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/gstacks_test/{s}.tags.tsv.gz", s=SAMPLES),    
        expand("results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/gstacks_test/{s}.snps.tsv.gz", s=SAMPLES),
        expand("results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/gstacks_test/{s}.alleles.tsv.gz", s=SAMPLES),
        "results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/gstacks_test/catalog.tags.tsv.gz",
        "results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/gstacks_test/catalog.snps.tsv.gz",
        "results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/gstacks_test/catalog.alleles.tsv.gz",
        "results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/gstacks_test/catalog.sample_list.tsv.gz",
        expand("results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/gstacks_test/{s}.matches.tsv.gz", s=SAMPLES),
        expand("results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/gstacks_test/{s}.matches.bam", s=SAMPLES)
    output:
        "results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/gstacks_test/catalog.fa.gz",
        "results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/gstacks_test/catalog.calls"
    conda:
        "stacks2.68-3"
    threads: 12
    resources:
        mem_mb=44880,
        time="4:00:00"
    log:
        "results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/gstacks_test/gstacks.log"
    benchmark:
        "results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/gstacks_test/gstacks.bmk"
    shell:
        " (gstacks				"
        " -P results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/gstacks_test/	"
        " -O results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/gstacks_test/	"
        " -M rapr-ddrad-smk-alpine/data/popmap_gstacks_test.tsv -t {threads})		"
        " 2> {log}				"
