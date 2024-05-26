# Clean reads (already demultiplexed by sequencing facility)

rule process_radtags:
    input:
        in1="results/lib4/clone_filter/{sample}_1.1.fq.gz",
        in2="results/lib4/clone_filter/{sample}_2.2.fq.gz",
    output:
        R1extraones="results/lib4/process_radtags/{sample}_1.1.1.fq.gz",
        R1rem="results/lib4/process_radtags/{sample}_1.1.rem.1.fq.gz",
        R2extratwos="results/lib4/process_radtags/{sample}_2.2.2.fq.gz",
        R2rem="results/lib4/process_radtags/{sample}_2.2.rem.2.fq.gz"
    conda:
        "stacks-2.65"
    params:
        enz1= config["process_radtags"]["enzyme1"],
        enz2= config["process_radtags"]["enzyme2"],
    resources:
        cpus=10,
        mem_mb=37400,
        time="12:00:00"
    log:
        "results/lib4/logs/process_radtags/{sample}.log"
    benchmark:
        "results/lib4/benchmarks/process_radtags/{sample}.bmk"
    shell:
        " (process_radtags -i gzfastq --threads 10  "
        " -1 {input.in1} -2 {input.in2}  "
        " -o results/lib4/process_radtags/  "
        " --renz-1 {params.enz1} --renz-2 {params.enz2}  "
        " -c -q -r) 2> {log}  "
