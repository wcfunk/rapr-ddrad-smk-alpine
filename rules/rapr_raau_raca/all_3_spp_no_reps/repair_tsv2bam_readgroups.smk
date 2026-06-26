###############################################################################
# Repair duplicate read-group IDs produced by tsv2bam when run one sample at
# a time.
#
# IMPORTANT:
# tsv2bam assigns duplicate numeric read-group IDs when run with one-sample
# population maps. gstacks requires globally unique read-group IDs, so this
# rule replaces the RG IDs with the sample name.
#
# Replaces:
#   @RG ID:<old>   -> ID:<sample>
#   @RG id:<old>   -> id:<sample>
#   RG:Z:<old>     -> RG:Z:<sample>
#
# Everything else is left unchanged.
###############################################################################

rule repair_tsv2bam_readgroups:
    input:
        bam="results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/{sample}.matches.original.bam"

    output:
        bam="results/rapr_raau_raca/all_3_spp_no_reps/stacks_denovo/{sample}.matches.bam"

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

        sample="{wildcards.sample}"
        tmp="{output.bam}.tmp"

        samtools view -h {input.bam} \
        | awk -v sample="$sample" '
            BEGIN {{ OFS="\t" }}

            ####################################################################
            # Replace read-group ID(s) in header
            ####################################################################
            /^@RG/ {{
                for (i=1; i<=NF; i++) {{
                    if ($i ~ /^ID:/)
                        $i = "ID:" sample
                    else if ($i ~ /^id:/)
                        $i = "id:" sample
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
                        $i = "RG:Z:" sample
                }}
                print
            }}
        ' \
        | samtools view -b -o "$tmp" -

        ########################################################################
        # Validate repaired BAM
        ########################################################################

        samtools quickcheck "$tmp"

        ########################################################################
        # Install repaired BAM
        ########################################################################

        mv "$tmp" {output.bam}

        echo "Successfully repaired read groups for $sample." >> {log}
        """
