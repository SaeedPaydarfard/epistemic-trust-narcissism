# Shame-Inducing Effect on Epistemic Trust in Grandiose Narcissism

R analysis code for the paper:

> **The Shame-inducing effect on epistemic trust in individuals with grandiose narcissistic personality traits: Development of an implicit Task to measure epistemic trust.**
>
> Paydarfard, S., Zabihzadeh, A., Vazirian, M.H., Mousavi, M., Nolte, T., & Fonagy, P.

---

## Repository Structure

```
├── analysis.R     # Full statistical analysis script
└── README.md
```

> **Note:** The dataset (`DATA.sav`) is not included in this repository.
> It is publicly available at the Harvard Dataverse:
> [https://doi.org/10.7910/DVN/TBH2RE](https://doi.org/10.7910/DVN/TBH2RE)

---

## Requirements

R (≥ 4.0) with the following packages:

```r
install.packages(c("haven", "car", "emmeans", "effectsize", "Hmisc"))
```

---

## Analysis Overview

The script reproduces all statistical analyses reported in the paper:

| Section | Method |
|---------|--------|
| Demographic checks | One-way ANOVA, Chi-square |
| Affect manipulation check | Two-way ANOVA (PANAS) |
| Assumption checks | Levene's test |
| Main analysis | Two-way between-subjects MANOVA (Wilks' Λ) |
| Follow-up | Univariate ANOVAs with partial η² |
| Post-hoc | Simple effects with Bonferroni correction |
| Self-report (ETMCQ) | One-way ANOVA (no-shame condition) |
| Construct validity | Pearson correlations (Table 1) |

---

## Variables

| Variable | Description |
|----------|-------------|
| `nar` | Narcissism group (1 = Low, 2 = High) |
| `shame` | Shame condition (0 = No-Shame, 1 = Shame) |
| `ET` | Epistemic Trust — ETMCIT (implicit task) |
| `EM` | Epistemic Mistrust — ETMCIT |
| `EC` | Epistemic Credulity — ETMCIT |
| `ETq` | Epistemic Trust — ETMCQ (self-report) |
| `EMq` | Epistemic Mistrust — ETMCQ |
| `ECq` | Epistemic Credulity — ETMCQ |
| `Avo` | Avoidant Attachment — ECR-36 |
| `Anx` | Anxious Attachment — ECR-36 |
| `pA` | Positive Affect — PANAS |
| `nA` | Negative Affect — PANAS |
| `NPI` | Narcissistic Personality Inventory-16 score |

---

## Usage

1. Download `DATA.sav` from the Harvard Dataverse link above.
2. Place it in your working directory.
3. Open `analysis.R` and run all sections sequentially.

---

## Citation

If you use this code, please cite the original paper.
