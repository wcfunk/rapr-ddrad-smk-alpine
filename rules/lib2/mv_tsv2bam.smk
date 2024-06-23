# Move tsv2bam output from sstacks to tsv2bam directory

rule mv_tsv2bam:
    input:
        matches_sstacks="results/lib2/stacks_denovo/sstacks/{sample}.matches.bam"
    output:
        matches_tsv2bam="results/lib2/stacks_denovo/tsv2bam/{sample}.matches.bam"
    resources:
        cpus=1,
        mem_mb=3740,
        time="00:30:00"
    log:
        "results/lib2/logs/mv_tsv2bam/{sample}.log"
    benchmark:
        "results/lib2/benchmarks/mv_tsv2bam/{sample}.bmk"
    shell:
        """
        mv {input.matches_sstacks} {output.matches_tsv2bam}
        """
