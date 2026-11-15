-- ==================================
    -- Projet SQL 1 Thierry AZONGAN
-- ==================================

-- VISUALISATION DE LA BASE --

SELECT *
FROM formation_sql.clients;

-- ===================================================================================
-- 1. Quelles sont les 3 villes qui comptent le plus de clients dont le nom contient
--    la lettre "a" et qui sont âgés de plus de 25 ans ?
-- ===================================================================================
SELECT ville, COUNT(id_client) AS nbre_clients
FROM formation_sql.clients
WHERE nom LIKE '%a%'
      AND age>25
GROUP BY ville
ORDER BY nbre_clients DESC
LIMIT 3;
-- le résultat de ce script nous donne Kinshasa 3, Goma 3 et Kisangani 2


-- ===================================================================================
-- 2. Quelles sont les 5 villes qui comptent le plus de clients de sexe féminin âgés 
--    de plus de 30 ans ? 
-- ===================================================================================
SELECT ville, COUNT(id_client) AS nbre_clients
FROM formation_sql.clients
WHERE sexe="Femme" 
      AND age>30
GROUP BY ville
ORDER BY nbre_clients DESC
LIMIT 5;
-- -- le résultat de ce script nous donne Goma 2 et Kinshasa 1


-- ===================================================================================
-- 3. Quelles sont les villes qui comptent plus de 5 clients dont le prénom commence par 
--    la lettre "J" ? 
-- ===================================================================================
SELECT ville, COUNT(id_client) AS nbre_clients
FROM formation_sql.clients
WHERE prenom LIKE 'J%'
GROUP BY ville
HAVING nbre_clients>5;
-- Les résultats montrent qu'il n'y a aucune ville répondant au critère de la question posée


-- ===================================================================================
-- 4. Quelles sont les 3 villes ayant le plus grand nombre de clients âgés de moins de 25 ans ? 
-- ===================================================================================
SELECT ville, COUNT(id_client) AS nbre_clients
FROM formation_sql.clients
WHERE age<25
GROUP BY ville
ORDER BY nbre_clients DESC
LIMIT 3;
-- La réponse n'est que Kinshasa possédant 1 seul client ayant 24 ans respectant les critères


-- ===================================================================================
-- 5. Quelles sont les villes qui comptent au moins 10 clients et dont le nombre de clients
--    est supérieur à celui des autres villes ? Classez les résultats du plus grand nombre de clients au plus petit. 
-- ===================================================================================
SELECT ville, COUNT(id_client) AS nbre_clients
FROM formation_sql.clients
GROUP BY ville
HAVING nbre_clients>=10
ORDER BY nbre_clients DESC;
-- ce résultat ne présente aucune ville car les données ne comporte pas des villes remplissant ce critère


-- ===================================================================================
-- 6. Quels sont les 5 clients les plus âgés dont le nom commence par "M" et qui habitent à Kinshasa ? 
-- ===================================================================================
SELECT DISTINCT nom, age, ville
FROM formation_sql.clients
WHERE nom LIKE 'M%' 
	  AND ville = "Kinshasa"
ORDER BY age DESC
LIMIT 5;
-- La réponse nous donne en ordre decroissant selon l'age : Mwamba 45, Mbuyi 42 et Mbuyi 32


-- ===================================================================================
-- 7. Quelles sont les villes qui comptent plus de 5 clients dont l'email contient "gmail" ? 
-- ===================================================================================
SELECT ville, COUNT(id_client) AS nbre_clients
FROM formation_sql.clients
WHERE email LIKE '%gmail%'
GROUP BY ville
HAVING nbre_clients>5;
-- La colonne email n'existe pas dans notre base de donnée donc nous ne pouvons terminer la requête


-- ===================================================================================
-- 8. Quelles sont les 5 villes ayant le plus de clients dont le prénom contient la lettre "a" 
--    et qui ont plus de 20 ans ? 
-- ===================================================================================
SELECT ville, COUNT(id_client) AS nbre_clients
FROM formation_sql.clients
WHERE prenom LIKE '%a%' 
	  AND age>20
GROUP BY ville
ORDER BY nbre_clients DESC
LIMIT 5;
-- La réponse est Kinshasa 5, Goma 2, Kisangani 2, Lubumbashi 1 et Matadi 1


-- ===================================================================================
-- 9. Quelles sont les villes dont le nombre de clients âgés de plus de 30 ans est supérieur à 5 ? 
--    Classez les villes de la plus représentée à la moins représentée. 
-- ===================================================================================
SELECT ville, COUNT(id_client) AS nbre_client
FROM formation_sql.clients
WHERE age>30
GROUP BY ville
HAVING nbre_client>5
ORDER BY nbre_client DESC;
-- Aucune ville ne reponds à ce critère dans nos données
   
   
-- ===================================================================================  
-- 10. Quelles sont les 3 villes ayant le plus de clients dont le nom se termine par la lettre "a" ? 
-- ===================================================================================
SELECT ville, COUNT(id_client) AS nbre_clients
FROM formation_sql.clients
WHERE nom LIKE '%a'
GROUP BY ville
ORDER BY nbre_clients DESC
LIMIT 3;
-- Nous avons Kinshasa 4, Goma 3 et Lubumbashi 1


-- ===================================================================================
-- 11. Quelles sont les villes qui comptent au moins 5 clients de sexe féminin âgés de plus de 25 ans ? 
--     Classez les résultats par nombre de clientes décroissant. 
-- ===================================================================================
SELECT ville, COUNT(id_client) AS nbre_clients
FROM formation_sql.clients
WHERE sexe ="Femme" AND age>25
GROUP BY ville
HAVING nbre_clients>=5
ORDER BY nbre_clients DESC;
-- Aucune donnée de la base ne rempli cette condition de la requête


-- ===================================================================================
-- 12. Quels sont les 10 premiers clients dont le nom contient la lettre "n", qui ont plus de 30 ans, 
--     classés du plus âgé au plus jeune ? 
-- ===================================================================================
SELECT nom, age
FROM formation_sql.clients
WHERE nom LIKE '%n%' 
	  AND age>30
ORDER BY age DESC
LIMIT 10;
-- La réponse nous donne 04 noms à savoir Mukendi 41, Tshibanda 35, Nsimba 34 et Banza 31


-- ===================================================================================
-- 13. Quelles sont les 5 villes ayant le plus de clients dont le nom commence par "K" et 
--     qui ont moins de 40 ans ? 
-- ===================================================================================
SELECT ville, COUNT(id_client) AS nbre_clients
FROM formation_sql.clients
WHERE nom LIKE 'K%' 
	  AND age<40
GROUP BY ville
ORDER BY nbre_clients DESC
LIMIT 5;
-- Les villes repondant à la requête sont: Kisangani 2, Lubumbashi 2 et Kinshasa 1

-- ===================================================================================
-- 14. Quelles sont les villes qui comptent plus de 10 clients dont le prénom commence par "A" ? 
--     Classez les villes par nombre de clients décroissant. 
-- ===================================================================================
SELECT ville, COUNT(id_client) AS nbre_clients
FROM formation_sql.clients
WHERE prenom LIKE 'A%'
GROUP BY ville
HAVING nbre_clients>10
ORDER BY nbre_clients DESC;
-- Aucune donnée de la base ne rempli cette condition de la requête


-- ===================================================================================
-- 15. Quelles sont les 3 villes ayant le plus de clients de sexe masculin dont le nom contient 
--     la lettre "e" et qui ont plus de 25 ans ? 
-- ===================================================================================
SELECT ville, COUNT(id_client) AS nbre_clients
FROM formation_sql.clients
WHERE sexe = "Homme" AND nom LIKE '%E%'AND age>25
GROUP BY ville
ORDER BY nbre_clients DESC
LIMIT 3;
-- Une seule ville correspond à la requête : Lubumbashi