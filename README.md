# Portfolio professionnel — Thierry AZONGAN

Site statique HTML/CSS/JavaScript, conçu pour une publication sur GitHub Pages. Le thème Dark Professional, la photo de profil et les sections principales sont conservés.

## Lancer en local
1. Ouvrir ce dossier dans Visual Studio Code.
2. Démarrer `index.html` avec Live Server ou l’ouvrir dans un navigateur.

## Projets présentés
- **Excel** : analyse et pilotage du budget 2025, avec 1 357 opérations et un tableau de bord interactif.
- **SQL/MySQL** : requêtes d’analyse sur une base clients.
- **Power BI** : deux tableaux de bord d’analyse des ventes.
- **R/RStudio** : analyse de 450 observations sur l’activité physique, l’HTA, le diabète et la tension systolique ; script, données et graphiques inclus.

Le classeur Excel effectivement transmis concerne le contrôle budgétaire, pas une analyse des ventes. Les analyses des ventes sont documentées dans les deux tableaux de bord Power BI. Le portfolio ne présente donc pas le classeur budgétaire comme un projet de ventes.

## Sécurité et confidentialité
- JavaScript local, sans dépendance d’exécution tierce ni formulaire collectant des données.
- Politique CSP restrictive dans les métadonnées : scripts et styles locaux, objets interdits, formulaires limités à l’origine locale.
- Liens externes ouverts avec `rel="noopener"` et politique de référent `strict-origin-when-cross-origin`.
- Le CV public est utilisé dans les liens du site ; le CV source non public reste non lié.

La politique CSP est un renforcement côté navigateur ; pour une protection complète, configurer également les en-têtes HTTP correspondants chez l’hébergeur si celui-ci le permet. GitHub Pages ne permet pas de définir librement tous les en-têtes HTTP.

## Publication GitHub Pages
Publier le contenu de ce dossier à la racine de la branche principale (`main` ou `master`), puis activer GitHub Pages dans les paramètres du dépôt.
