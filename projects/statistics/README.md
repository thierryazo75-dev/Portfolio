# Projet statistique — Activité physique et santé cardiovasculaire

## Objectif
Étudier, sur 450 observations, les liens entre le niveau d’activité physique et plusieurs indicateurs de santé, notamment l’hypertension artérielle (HTA), ainsi que le diabète. Le projet comporte aussi une exploration descriptive et l’étude de la relation entre l’âge et la tension artérielle systolique.

## Fichiers
- `analyse-statistique-sante.R` : script principal reproductible.
- `data/base_donnees_TP_R_450.xlsx` : jeu de données utilisé par le script.
- `repart par activité physique.png`, `repart par sexe.png`, `nuage de point TA systolique selon l'age.png` : graphiques exportés.

## Méthodes
- Statistiques descriptives des variables quantitatives et qualitatives.
- Tableaux croisés et test du Khi-deux d’indépendance pour les associations entre activité physique et HTA, puis activité physique et diabète.
- Contrôle des conditions du Khi-deux à partir des effectifs théoriques.
- Contrôle de la distribution avant l’analyse de corrélation entre âge et tension systolique ; le script retient Spearman si la normalité n’est pas établie.

## Résultats à interpréter avec prudence
Sur les données fournies, le test du Khi-deux entre activité physique et HTA donne χ² = 0,285, ddl = 2, p = 0,867. Celui entre activité physique et diabète donne χ² = 0,124, ddl = 2, p = 0,940. Au seuil de 5 %, ces résultats ne mettent pas en évidence d’association statistiquement significative dans cet échantillon. Ils ne prouvent pas l’absence de relation dans la population générale et ne permettent pas d’inférer une causalité.

## Exécution
Ouvrir `Projet_SocioDemo.Rproj` dans RStudio ou lancer `analyse-statistique-sante.R` depuis le dossier `projects/statistics/`. Le script recherche le classeur dans `data/`. Installer les packages requis une seule fois si nécessaire (`readxl`, `dplyr`, `janitor`, `skimr`, `ggplot2`).
