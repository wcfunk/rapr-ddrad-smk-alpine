###############################################################################
# Repair duplicate read-group IDs produced by tsv2bam when run one sample at
# a time.
#
# Each sample is assigned a unique integer read-group ID using
# data/readgroup_ids.tsv.
###############################################################################

rule repair_tsv2bam_readgroups:
    input:
        bam="results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/{sample}.matches.original.bam"

    output:
        bam="results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/{sample}.matches.bam"

    params:
        rgid=lambda wc: RG_IDS[wc.sample]

    conda:
        "stacks2.68-3"

    threads: 1

    resources:
        mem_mb=3740,
        time="00:30:00"

    log:
        "results/rapr_raau_raca/all_3_spp_no_reps/logs/stacks_denovo/repair_readgroups/{sample}.log"

    benchmark:
        "results/rapr_raau_raca/all_3_spp_no_reps/benchmarks/stacks_denovo/repair_readgroups/{sample}.bmk"

    shell:
        r"""
        set -euo pipefail

        rgid="{params.rgid}"
        tmp="{output.bam}.tmp"

        samtools view -h {input.bam} \
        | awk -v rgid="$rgid" '
            BEGIN {{ OFS="\t" }}

            ####################################################################
            # Replace read-group IDs in header
            ####################################################################
            /^@RG/ {{
                for (i=1; i<=NF; i++) {{
                    if ($i ~ /^ID:/)
                        $i = "ID:" rgid
                    else if ($i ~ /^id:/)
                        $i = "id:" rgid
                }}
                print
                next
            }}

            ####################################################################
            # Replace RG tag on each alignment
            ####################################################################
            {{
                for (i=12; i<=NF; i++) {{
                    if ($i ~ /^RG:Z:/)
                        $i = "RG:Z:" rgid
                }}
                print
            }}
        ' \
        | samtools view -b -o "$tmp" -

        samtools quickcheck "$tmp"

        mv "$tmp" {output.bam}

        echo "Successfully repaired read groups using RG ID $rgid." >> {log}
        """
