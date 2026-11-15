# ============================================================
# PROJET : ACTIVITE PHYSIQUE ET INDICATEURS DE SANTE
# Donnees : 450 participants
# Outil : R / RStudio
# ============================================================

# Installer une seule fois si les packages ne sont pas disponibles :
# install.packages(c("readxl", "dplyr", "janitor", "skimr", "ggplot2"))

library(readxl)
library(dplyr)
library(janitor)
library(skimr)
library(ggplot2)

# 1. IMPORTATION ET EXPLORATION --------------------------------
fichier_donnees <- file.path("data", "base_donnees_TP_R_450.xlsx")
if (!file.exists(fichier_donnees)) {
  stop("Fichier absent : placez base_donnees_TP_R_450.xlsx dans le sous-dossier data/")
}
dataTP <- read_excel(fichier_donnees) |> clean_names()

cat("Dimensions :", nrow(dataTP), "lignes x", ncol(dataTP), "colonnes\n")
str(dataTP)
summary(dataTP)
skim(dataTP)

# 2. STATISTIQUES DESCRIPTIVES -------------------------------
vars_num <- dataTP |> select(where(is.numeric))
resume_num <- vars_num |> summarise(across(everything(),
  list(moyenne = ~mean(.x, na.rm=TRUE),
       mediane = ~median(.x, na.rm=TRUE),
       ecart_type = ~sd(.x, na.rm=TRUE),
       cv_pct = ~sd(.x, na.rm=TRUE)/mean(.x, na.rm=TRUE)*100)))
print(resume_num)

# Effectifs et pourcentages des variables qualitatives
for (v in c("sexe", "activite_physique", "hta", "diabete", "tabagisme")) {
  if (v %in% names(dataTP)) {
    cat("\nDistribution :", v, "\n")
    print(table(dataTP[[v]], useNA="ifany"))
    print(round(prop.table(table(dataTP[[v]]))*100, 2))
  }
}

# 3. ASSOCIATION ACTIVITE PHYSIQUE - HTA ----------------------
# H0 : activité physique et HTA sont indépendantes.
# H1 : elles sont associées.
tab_activite_hta <- table(dataTP$activite_physique, dataTP$hta)
print(tab_activite_hta)
print(round(prop.table(tab_activite_hta, margin=1)*100, 2))
test_activite_hta <- chisq.test(tab_activite_hta, correct=FALSE)
print(test_activite_hta)
if (any(test_activite_hta$expected < 5)) {
  message("Attention : certains effectifs théoriques sont < 5 ; envisager un test exact/Monte-Carlo.")
  print(chisq.test(tab_activite_hta, simulate.p.value=TRUE, B=10000))
}

# 4. ASSOCIATION ACTIVITE PHYSIQUE - DIABETE ------------------
# H0 : activité physique et diabète sont indépendants.
# H1 : elles sont associées.
tab_activite_diabete <- table(dataTP$activite_physique, dataTP$diabete)
print(tab_activite_diabete)
print(round(prop.table(tab_activite_diabete, margin=1)*100, 2))
test_activite_diabete <- chisq.test(tab_activite_diabete, correct=FALSE)
print(test_activite_diabete)
if (any(test_activite_diabete$expected < 5)) {
  message("Attention : certains effectifs théoriques sont < 5 ; envisager un test exact/Monte-Carlo.")
  print(chisq.test(tab_activite_diabete, simulate.p.value=TRUE, B=10000))
}

# 5. AUTRES CROISEMENTS ---------------------------------------
for (v in c("sexe", "tabagisme")) {
  if (v %in% names(dataTP)) {
    tab <- table(dataTP[[v]], dataTP$hta)
    cat("\nAssociation", v, "- HTA\n")
    print(tab)
    print(chisq.test(tab, correct=FALSE))
  }
}

# 6. RELATION AGE - TENSION ARTERIELLE SYSTOLIQUE ------------
# Shapiro-Wilk est utilisé comme indicateur, avec prudence pour n élevé.
shapiro_age <- shapiro.test(dataTP$age)
shapiro_ta <- shapiro.test(dataTP$ta_systolique)
print(shapiro_age)
print(shapiro_ta)

# Si au moins une variable n'est pas compatible avec la normalité,
# utiliser Spearman (relation monotone) ; sinon Pearson (relation linéaire).
if (shapiro_age$p.value < 0.05 || shapiro_ta$p.value < 0.05) {
  test_cor <- cor.test(dataTP$age, dataTP$ta_systolique, method="spearman", exact=FALSE)
  methode <- "Spearman"
} else {
  test_cor <- cor.test(dataTP$age, dataTP$ta_systolique, method="pearson")
  methode <- "Pearson"
}
cat("Méthode de corrélation retenue :", methode, "\n")
print(test_cor)

# 7. GRAPHIQUES ------------------------------------------------
ggplot(dataTP, aes(x=activite_physique)) +
  geom_bar(fill="#2B83BA") +
  labs(title="Répartition selon l'activité physique", x="Activité physique", y="Effectif") +
  theme_minimal()

ggplot(dataTP, aes(x=age, y=ta_systolique)) +
  geom_point(alpha=.65, color="#2B83BA") +
  geom_smooth(method="lm", se=TRUE, color="#D7191C") +
  labs(title="Âge et tension artérielle systolique", x="Âge (ans)", y="TA systolique") +
  theme_minimal()

# 8. REGLE D'INTERPRETATION -----------------------------------
# p < 0,05 : association statistiquement significative au seuil de 5 %.
# p >= 0,05 : les données ne permettent pas de mettre en évidence
# une association statistiquement significative. Cela ne prouve pas
# l'absence de relation et ne démontre aucune causalité.
