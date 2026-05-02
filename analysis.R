# =============================================================================
# Shame-Inducing Effect on Epistemic Trust in Individuals with
# Grandiose Narcissistic Personality Traits
#
# Authors: Paydarfard, S., Zabihzadeh, A., Vazirian, M.H.,
#          Mousavi, M., Nolte, T., & Fonagy, P.
#
# Data: Harvard Dataverse — https://doi.org/10.7910/DVN/TBH2RE
# =============================================================================


# 0. PACKAGES ------------------------------------------------------------------

# install.packages(c("haven", "car", "emmeans", "effectsize", "Hmisc"))

library(haven)
library(car)
library(emmeans)
library(effectsize)
library(Hmisc)


# 1. DATA ----------------------------------------------------------------------

df <- read_sav("DATA.sav")

# Convert grouping variables to factors
df$nar   <- factor(df$nar,   levels = c(1, 2), labels = c("Low", "High"))
df$shame <- factor(df$shame, levels = c(0, 1), labels = c("No-Shame", "Shame"))


# 2. DESCRIPTIVE STATISTICS ----------------------------------------------------

# Overall summary
summary(df[, c("ET", "EM", "EC", "ETq", "EMq", "ECq",
               "Age", "NPI", "pA", "nA")])

# Group means and SDs for the implicit task (ETMCIT)
aggregate(cbind(ET, EM, EC) ~ nar + shame, data = df,
          FUN = function(x) c(mean = mean(x), sd = sd(x)))


# 3. DEMOGRAPHIC CHECKS --------------------------------------------------------

# Age differences across groups
age_aov <- aov(Age ~ nar * shame, data = df)
summary(age_aov)

# Sex ratio across groups
chisq.test(table(df$Gender, interaction(df$nar, df$shame)))


# 4. AFFECT CHECK (PANAS) ------------------------------------------------------

# Positive affect
summary(aov(pA ~ nar * shame, data = df))

# Negative affect
summary(aov(nA ~ nar * shame, data = df))


# 5. HOMOGENEITY OF VARIANCE (LEVENE'S TEST) -----------------------------------

leveneTest(ET ~ nar * shame, data = df)
leveneTest(EM ~ nar * shame, data = df)
leveneTest(EC ~ nar * shame, data = df)


# 6. MANOVA --------------------------------------------------------------------

manova_model <- manova(cbind(ET, EM, EC) ~ nar * shame, data = df)

# Wilks' Lambda
summary(manova_model, test = "Wilks")


# 7. UNIVARIATE ANOVAs (follow-up to MANOVA) -----------------------------------

# Epistemic Trust
ET_aov <- aov(ET ~ nar * shame, data = df)
summary(ET_aov)
eta_squared(ET_aov, partial = TRUE)

# Epistemic Mistrust
EM_aov <- aov(EM ~ nar * shame, data = df)
summary(EM_aov)
eta_squared(EM_aov, partial = TRUE)

# Epistemic Credulity
EC_aov <- aov(EC ~ nar * shame, data = df)
summary(EC_aov)
eta_squared(EC_aov, partial = TRUE)


# 8. SIMPLE EFFECTS (Bonferroni-corrected) -------------------------------------

# Epistemic Trust
emm_ET <- emmeans(ET_aov, ~ nar | shame)
pairs(emm_ET, adjust = "bonferroni")

emm_ET2 <- emmeans(ET_aov, ~ shame | nar)
pairs(emm_ET2, adjust = "bonferroni")

# Epistemic Mistrust
emm_EM <- emmeans(EM_aov, ~ nar | shame)
pairs(emm_EM, adjust = "bonferroni")

# Epistemic Credulity
emm_EC <- emmeans(EC_aov, ~ nar | shame)
pairs(emm_EC, adjust = "bonferroni")

emm_EC2 <- emmeans(EC_aov, ~ shame | nar)
pairs(emm_EC2, adjust = "bonferroni")


# 9. SELF-REPORT MEASURE (ETMCQ) — No-Shame condition only --------------------

df_noshame <- subset(df, shame == "No-Shame")

# Epistemic Trust
ET_q_aov <- aov(ETq ~ nar, data = df_noshame)
summary(ET_q_aov)
eta_squared(ET_q_aov, partial = TRUE)

# Epistemic Mistrust
EM_q_aov <- aov(EMq ~ nar, data = df_noshame)
summary(EM_q_aov)
eta_squared(EM_q_aov, partial = TRUE)

# Epistemic Credulity
EC_q_aov <- aov(ECq ~ nar, data = df_noshame)
summary(EC_q_aov)
eta_squared(EC_q_aov, partial = TRUE)


# 10. CONSTRUCT VALIDITY CORRELATIONS (Table 1) --------------------------------
# Computed in the No-Shame sample (n = 109)

cor_vars <- df_noshame[, c("ET", "EM", "EC", "Avo", "Anx",
                            "ETq", "EMq", "ECq")]

cor_results <- rcorr(as.matrix(cor_vars))

cat("\n--- Correlation Matrix ---\n")
print(round(cor_results$r, 2))

cat("\n--- p-values ---\n")
print(round(cor_results$P, 3))


# =============================================================================
# END OF SCRIPT
# =============================================================================
