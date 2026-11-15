
#Installation des packages
install.packages("tidyverse")
install.packages("janitor")
install.packages("skimr")
install.packages("readxl")
install.packages("shiny")

#Chargement des librairies
library(tidyverse)
library(janitor)
library(skimr)
library(readxl)
library(shiny)
library(dplyr)

### Partie 1 — Importation et exploration des données

# 1 - Importation du fichier excel
dataTP <- read_excel(file.path("data", "base_donnees_TP_R_450.xlsx"))
View(dataTP)

# 2 - Affichage des premières et dernières observations
        # -les 6 premières lignes
head(dataTP)
        # - les 6 dernières lignes
tail(dataTP)

# 3 - Vérification du nombre de lignes et de colonnes
dim(dataTP)

# 4 - Identification du type de chaque variable
str(dataTP)
glimpse(dataTP)

# 5 - Affichage d'un résumé statistique de la base
summary(dataTP)

### Partie 2 — Statistiques descriptives

## A - QUESTIONS D'INTERPRETATIONS

# 1 - l'âge moyen des participants
mean(dataTP$Age)
mean(dataTP[["Age"]])

# 2 - la valeur médiane de l'IMC
median(dataTP$IMC)
median(dataTP[["IMC"]])

# 3 - la moyenne TA systolique moyenne
mean(dataTP$TA_systolique)

# 4 - variable présentant la plus grande dispersion
      # je déclare les variables numériques
var_num <- dataTP[c("Age", "IMC", "TA_systolique", "Cholesterol")]

      # je déclare la fonction permettant de calculer le coef. de variation
calcul_cv <- function(x) {sd(x, na.rm = TRUE) / mean(x, na.rm = TRUE) * 100}

      # je calcule la coef de variation de chaque variable
cv <- sapply(var_num, calcul_cv)
View(cv)

      # voici la variable ayant la plus grande dispersion (Age)
names(which.max(cv))

## B - VARIABLES QUALITATIVES

# 1 - La proportion d'hommes et de femmes
table(dataTP$Sexe)
prop.table(table(dataTP$Sexe))*100

# 2 - Quelle catégorie d'activité physique est la plus représentée (modérée)
table(dataTP$Activite_physique)
names(which.max(table(dataTP$Activite_physique)))

# 3 - Quelle proportion des participants est hypertendue ?
table(dataTP$HTA)
prop.table(table(dataTP$HTA))*100

# 4 - Quelle proportion présente un diabète ?
table(dataTP$Diabete)
prop.table(table(dataTP$Diabete))*100


### PARTIE 3 — REPRESENTATIONS GRAPHIQUES

# 1 - Un diagramme en barres du sexe.
barplot(table(dataTP$Sexe))

barplot(table(dataTP$Sexe),
        main = "Répartition par Sexe",
        xlab = "Sexe",
        ylab = "Effectif",
        ylim = c(0, 250),
        col = c("steelblue", "seagreen"),
        border = "white")


#2 - Un diagramme en barres de l'activité physique.

barplot(table(dataTP$Activite_physique),
        main = "Répartition par activité physique",
        xlab = "Activité physique",
        ylab = "Effectif",
        col = c("steelblue", "darkred", "lightpink"),
        ylim = c(0, 250),
        border = "white")

       ###❖ Peut-on conclure qu'il existe une association statistiquement 
       ###❖ significative entre le sexe et l'HTA ?
 
# Etablissons un croissement entre le sexe et HTA
tab <- table(dataTP$Sexe, dataTP$HTA)
round(prop.table(tab, margin = 1)*100, 2)

chisq.test(dataTP$Sexe, dataTP$HTA)
# Effectuons le Test d'hypothèse de Chi2 
test <- chisq.test(tab)
test


                        #---COMMENTAIRE1---
# L’analyse croisée du sexe et du statut d’hypertension artérielle (HTA) 
# montre que, sur les 234 individus de sexe féminin enquêtés, 56 présentent 
# une HTA, soit une proportion de 23,9 %. En revanche, parmi les 216 individus 
# de sexe masculin, 63 sont déclarés hypertendus, représentant une proportion 
# de 29,2 %. Ces résultats indiquent une fréquence de l’HTA plus élevée chez 
# les hommes que chez les femmes dans la population étudiée.


                  #---COMMENTAIRE2(test de chi2)---
# Hypothèses :
# H0 : le sexe et l'HTA sont indépendants.
# H1 : le sexe et l'HTA sont associés.
# Comme p = 0,2497 > 0,05, on ne rejette pas H0.

# Conclusion
# Le test du Khi-deux d'indépendance donne χ² = 1,32 (ddl = 1), p = 0,25. 
# Au seuil de 5 %, on ne rejette pas H0 l'hypothèse d'indépendance. 
# On ne peut donc pas conclure à une association statistiquement significative 
# entre le sexe et l'HTA dans cet échantillon.
# Donc les variables Sexe et HTA sont indépendantes


###❖ Étudier la relation entre Tabagisme et HTA
#J'effectue le croisement entre Tabagisme et HTA
tab_2 <- table(dataTP$Tabagisme, dataTP$HTA)
tab_2
round(prop.table(tab_2, margin=1)*100, 2)

#J'effectue le test de chi2
test_2 <- chisq.test(tab_2)
test_2

                    #---COMMENTAIRE1---
# L’analyse croisée du Tabagisme et HTA 
# montre que, sur les 334 individUS non fumant enquêtés, 94 présentent
# une HTA, soit une proportion de 28,14 %. En revanche, parmi les 116 individus 
# fumant du tabac, 25 sont déclarés hypertendus, représentant une proportion 
# de 21,55 %. Ces résultats indiquent une fréquence de l’HTA plus élevée chez 
# les individus non fumeur que chez les fumeurs dans la population étudiée.


                #---COMMENTAIRE2(test de chi2)---
# Hypothèses :
# H0 : le Tabagisme et l'HTA sont indépendants.
# H1 : le Tabagisme et l'HTA sont dépendants.
# Comme p = 0,206 > 0,05, on ne rejette pas H0.

# Conclusion
# Le test du Khi-deux d'indépendance donne χ² = 1,5995 (ddl = 1), p = 0,206. 
# Au seuil de 5 %, on ne rejette pas H0 l'hypothèse d'indépendance. 
# On ne peut donc pas conclure à une association statistiquement significative 
# entre le Tabagisme et l'HTA dans cet échantillon.
# Donc les variables Tabagisme et HTA sont indépendantes

 
     ### ❖ Déterminer si l'activité physique est statistiquement 
     ### ❖ associée au diabète.

#J'effectue le croisement entre Activité physique et Diabète
tab_3 <- table(dataTP$Activite_physique, dataTP$Diabete)
tab_3
round(prop.table(tab_3, margin = 1)*100, 2)

#J'effectue le test de chi2
test_3 <- chisq.test(tab_3)
test_3
            # ---Interprétation du test de chi2---
# Hypothèses :
# H0 : l'Activité physique et le Diabète sont indépendants.
# H1 : l'Activité physique et le Diabète sont dépendants.
# p=0.9397 > 0.05, on ne rejette pas H0 donc les variables Activité Physique
# et diabète sont indépendante


         ### ❖ Existe-t-il une relation statistiquement significative 
         ### ❖ entre l'âge et la TA systolique ?

# Visualition du nuage de point entre l'âge et la TA systolique
plot(dataTP$Age, dataTP$TA_systolique,
     main = "Nuage de point TA systolique selon l'âge",
     xlab = "Âge (an)",
     ylab = "TA systolique",
     pch = 19,
     col = ("steelblue"))
abline(lm(TA_systolique ~ Age, data = dataTP), col="red", lwd = 2)
       # ---Interprétation du nuage de point---
   # Le nuage de point montre que la relation est croissante et linéaire

# Etudions la normalité des variables 
shapiro.test(dataTP$Age) 
shapiro.test(dataTP$TA_systolique)
        #---Interprétation de la normalité---
# Pour la variable Age, p=2.243e-10 < 0.05 donc on utilisera 
# le test de pearson pour la suite de notre analyse

cor.test(dataTP$TA_systolique, dataTP$Age, method = "pearson")

# #Hypothèses
# H0 : ρ = 0, pas de relation entre l'âge et la TA systolique.
# H1 : ρ ≠ 0, il existe un lien statistiquement significatif entre l'âge et la TA systolique.
# Comme p < 0,05, on rejette H0.
# rho est positif, donc la TA systolique augmente avec l'âge. 
#Plus les personnes sont âgées, plus leur TA systolique tend à être élevée.
#rho = 0,67 correspond à une corrélation forte
# Au régard de ce qui précède, nous pouvons affirmer qu'il existe éffectivement 
# une relation significative entre l'age et la TA systolique.





