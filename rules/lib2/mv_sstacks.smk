# Move sstacks output from cstacks to sstacks directory

rule mv_sstacks:
    input:
        matches_cstacks="results/lib2/stacks_denovo/cstacks/{sample}.matches.tsv.gz"
    output:
        matches_sstacks="results/lib2/stacks_denovo/sstacks/{sample}.matches.tsv.gz"
    resources:
        cpus=1,
        mem_mb=3740,
        time="00:30:00"
    log:
        "results/lib2/logs/mv_sstacks/{sample}.log"
    benchmark:
        "results/lib2/benchmarks/mv_sstacks/{sample}.bmk"
    shell:
        """
        mv {input.matches_cstacks} {output.matches_sstacks}
        """
