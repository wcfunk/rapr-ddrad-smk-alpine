# Remove extra 1s and 2s from end of fastq files

rule rename_fastqs_rerun:
    input:
        R1extraones="results/rapr_raau_raca/process_radtags_rerun/{sample}_1.1.1.fq.gz",
        R2extratwos="results/rapr_raau_raca/process_radtags_rerun/{sample}_2.2.2.fq.gz"
    output:
        R1="results/rapr_raau_raca/process_radtags_rerun/{sample}.1.fq.gz",
        R2="results/rapr_raau_raca/process_radtags_rerun/{sample}.2.fq.gz"
    resources:
        cpus=1,
        mem_mb=3740,
        time="00:30:00"
    log:
        "results/rapr_raau_raca/logs/rename_fastqs_rerun/{sample}.log"
    benchmark:
        "results/rapr_raau_raca/benchmarks/rename_fastqs_rerun/{sample}.bmk"
    shell:
        """
        mv {input.R1extraones} {output.R1} &&
        mv {input.R2extratwos} {output.R2}
        """
