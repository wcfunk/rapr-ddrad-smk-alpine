# Build a paired-end contig from the metapopulation data, align reads per sample
# call variant sites in the population, genotypes in each individual.

SAMPLES = [
    "16AUG22RAPR1BEAV",
    "211848",
    "212224",
    "212303",
    "212336",
    "220677",
    "220730",
    "CabinRAPR_5_17AUG22",
    "CAP_BUL_V02",
    "CAP_BUL_W01",
    "CAP_LOXW_CO1",
    "CAP_LOXW_CO1_R",
    "CAP_MEXC_B02",
    "CAP_NCP_N01",
    "CAP_NCP_R01",
    "CAP_P5N_A01",
    "CHOL_EM7_A1",
    "CHOL_EM7_A1R",
    "Crane3293A",
    "Crane_3293Ar",
    "KM_MC_7_EM3_A1",
    "OSF_E1",
    "OSF_E136",
    "OSF_E136_R",
    "OSF_E137",
    "OSF_E139",
    "OSF_E217",
    "OSF_E23",
    "OSF_E23R",
    "OSF_E26",
    "OSF_E303",
    "OSF_E303R",
    "OSF_E308",
    "OSF_E334",
    "OSF_E335",
    "OSF_E381",
    "OSF_E381R",
    "OSF_E389",
    "OSF_E389R",
    "OSF_E406",
    "OSF_E407",
    "OSF_E409",
    "OSF_E411",
    "OSF_E418",
    "OSF_E425",
    "OSF_E428",
    "OSF_E430",
    "OSF_E432",
    "OSF_E433",
    "OSF_E65",
    "OSF_E86",
    "ParsnipLkBeavPondSiteA2",
    "ParsnipLkBeavPondSiteB11",
    "WRBS_B01",
    "WRBS_B01_CAP_R"
]

rule gstacks:
    input:
        expand("results/de_novo_param_opt/n_opt/rapr_n2_rerun/stacks_denovo/{s}.tags.tsv.gz", s=SAMPLES),    
        expand("results/de_novo_param_opt/n_opt/rapr_n2_rerun/stacks_denovo/{s}.snps.tsv.gz", s=SAMPLES),
        expand("results/de_novo_param_opt/n_opt/rapr_n2_rerun/stacks_denovo/{s}.alleles.tsv.gz", s=SAMPLES),
        "results/de_novo_param_opt/n_opt/rapr_n2_rerun/stacks_denovo/catalog.tags.tsv.gz",
        "results/de_novo_param_opt/n_opt/rapr_n2_rerun/stacks_denovo/catalog.snps.tsv.gz",
        "results/de_novo_param_opt/n_opt/rapr_n2_rerun/stacks_denovo/catalog.alleles.tsv.gz",
        "results/de_novo_param_opt/n_opt/rapr_n2_rerun/stacks_denovo/catalog.sample_list.tsv.gz",
        expand("results/de_novo_param_opt/n_opt/rapr_n2_rerun/stacks_denovo/{s}.matches.tsv.gz", s=SAMPLES),
        expand("results/de_novo_param_opt/n_opt/rapr_n2_rerun/stacks_denovo/{s}.matches.bam", s=SAMPLES)
    output:
        "results/de_novo_param_opt/n_opt/rapr_n2_rerun/stacks_denovo/catalog.fa.gz",
        "results/de_novo_param_opt/n_opt/rapr_n2_rerun/stacks_denovo/catalog.calls"
    conda:
        "stacks2.68-3"
    threads: 12
    resources:
        mem_mb=44880,
        time="12:00:00"
    log:
        "results/de_novo_param_opt/n_opt/rapr_n2_rerun/logs/stacks_denovo/gstacks/gstacks.log"
    benchmark:
        "results/de_novo_param_opt/n_opt/rapr_n2_rerun/benchmarks/stacks_denovo/gstacks/gstacks.bmk"
    shell:
        " (gstacks				"
        " -P results/de_novo_param_opt/n_opt/rapr_n2_rerun/stacks_denovo/	"
        " -O results/de_novo_param_opt/n_opt/rapr_n2_rerun/stacks_denovo/	"
        " -M rapr-ddrad-smk-alpine/data/popmap_dnpo_rapr.tsv -t {threads})		"
        " 2> {log}				"
