# Transpose the data so it is stored by locus, instead of by sample. We will include
# paired-end reads using tsv2bam.

rule tsv2bam:
    input:
        "results/rapr_raau_raca/process_radtags_rerun/all_3_spp_no_reps/{sample}.2.fq.gz",
        "results/rapr_raau_raca/rapr_no_reps_rerun/stacks_denovo/{sample}.matches.tsv.gz",
        "results/rapr_raau_raca/rapr_no_reps_rerun/stacks_denovo/catalog.tags.tsv.gz",
        "results/rapr_raau_raca/rapr_no_reps_rerun/stacks_denovo/catalog.snps.tsv.gz",
        "results/rapr_raau_raca/rapr_no_reps_rerun/stacks_denovo/catalog.alleles.tsv.gz",
        "results/rapr_raau_raca/rapr_no_reps_rerun/stacks_denovo/catalog.sample_list.tsv.gz"
    output:
        "results/rapr_raau_raca/rapr_no_reps_rerun/stacks_denovo/{sample}.matches.original.bam"
    conda:
        "stacks2.68-3"
    threads: 8
    resources:
        mem_mb=29920,
        time="1:00:00"
    log:
        "results/rapr_raau_raca/rapr_no_reps_rerun/logs/stacks_denovo/tsv2bam/{sample}.log"
    benchmark:
        "results/rapr_raau_raca/rapr_no_reps_rerun/benchmarks/stacks_denovo/tsv2bam/{sample}.bmk"
    shell:
        r"""
        tsv2bam \
            -P results/rapr_raau_raca/rapr_no_reps_rerun/stacks_denovo/ \
            -R results/rapr_raau_raca/process_radtags_rerun/all_3_spp_no_reps/ \
            -M rapr-ddrad-smk-alpine/data/popmap_rapr_no_reps_by_sample/popmap_rapr_no_reps_{wildcards.sample}.tsv \
            -t {threads} \
            2> {log}

        mv \
            results/rapr_raau_raca/rapr_no_reps_rerun/stacks_denovo/{wildcards.sample}.matches.bam \
            {output}
        """
