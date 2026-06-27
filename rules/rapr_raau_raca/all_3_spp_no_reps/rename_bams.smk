# Remove extra .1s from ustacks output files and move to stacks_denovo

rule rename_bams:
    input:
        bams="results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/{sample}.matches.bam"	
    output:
        original_bams="results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/original_bams/{sample}.matches.original.bam"
    resources:
        cpus=1,
        mem_mb=3740,
        time="00:30:00"
    log:
        "results/rapr_raau_raca/all_3_spp_no_reps/logs/stacks_denovo/rename_bams/{sample}.log"
    benchmark:
        "results/rapr_raau_raca/all_3_spp_no_reps/benchmarks/stacks_denovo/rename_bams/{sample}.bmk"
    shell:
        """
        mv {input.bams} {output.original_bams}
        """
