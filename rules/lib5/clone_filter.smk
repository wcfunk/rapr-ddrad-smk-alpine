# Remove PCR and optical duplicates and trim degenerate barcode

rule clone_filter:
    input:
        unpack(get_fastqs)
    output:
        "results/lib5/clone_filter/{sample}_1.1.fq.gz",
        "results/lib5/clone_filter/{sample}_2.2.fq.gz"
    resources:
        cpus=8,
        mem_mb=29920,
        time="12:00:00"
    conda:
        "stacks-2.65"
    log:
        "results/lib5/logs/clone_filter/{sample}.log"
    benchmark:
        "results/lib5/benchmarks/clone_filter/{sample}.bmk"
    shell:
        " (clone_filter -i gzfastq  "
        "       -1 {input.fq1} -2 {input.fq2}     "
        "       --inline-null --oligo-len-1 10    "
        "       -o results/lib5/clone_filter/) 2> {log} "
