-- ====================================================================
-- Script 3 : requêtes de vérification de la base de données Tifosi :
-- ====================================================================

USE tifosi;

-- ============================================================
-- Requête 1 : liste des noms des focaccias par ordre
--             alphabétique croissant :
-- ============================================================
-- But : Vérifier que toutes les focaccias sont bien insérées
--       et affichées dans l'ordre A → Z. :
--
-- Résultat attendu :
--   Américaine
--   Emmentalaccia
--   Gorgonzollaccia
--   Hawaienne
--   Mozaccia
--   Paysanne
--   Raclaccia
--   Tradizione
--------------------------------------------------------------
SELECT nom
FROM foccacia
ORDER BY nom ASC;

-- ============================================================
-- Requête 2 : nombre total d'ingrédients :
-- ============================================================
-- But : Compter le nombre de lignes dans la table ingredient.
--
-- Résultat attendu : 25
-- -----------------------------------------------------------
SELECT COUNT(*) AS nombre_ingredients
FROM ingredient;

-- ============================================================
-- Requête 3 : prix moyen des focaccias :
-- ============================================================
-- But : Calculer la moyenne des prix de toutes les focaccias.
--
-- Résultat attendu : (9.80 + 10.80 + 8.90 + 9.80 + 8.90
--                     + 11.20 + 10.80 + 12.80) / 8 = 10.375
--                   → 10.38 (arrondi à 2 décimales)
--------------------------------------------------------------
SELECT ROUND(AVG(prix), 2) AS prix_moyen
FROM foccacia;

-- ============================================================
-- Requête 4 : liste des boissons avec leur marque,
--             triée par nom de boisson :
-- ============================================================
-- But : Vérifier la jointure boisson ↔ marque et le tri.
--
-- Résultat attendu :
--   Capri-sun          | Coca-cola
--   Coca-cola original | Coca-cola
--   Coca-cola zéro     | Coca-cola
--   Eau de source      | Cristalline
--   Fanta citron       | Coca-cola
--   Fanta orange       | Coca-cola
--   Lipton Peach       | Pepsico
--   Lipton zéro citron | Pepsico
--   Monster energy ultra blue | Monster
--   Monster energy ultra gold | Monster
--   Pepsi              | Pepsico
--   Pepsi Max Zéro     | Pepsico
--------------------------------------------------------------
SELECT b.nom AS boisson, m.nom AS marque
FROM boisson b
JOIN marque m ON b.id_marque = m.id_marque
ORDER BY b.nom ASC;

-- ============================================================
-- Requête 5 : liste des ingrédients pour une Raclaccia :
-- ============================================================
-- But : Vérifier les données de composition de la Raclaccia.
--
-- Résultat attendu (7 ingrédients) :
--   ail, base Tomate, champignon, cresson,
--   parmesan, poivre, raclette
--------------------------------------------------------------
SELECT i.nom AS ingredient, c.quantite
FROM comprend c
JOIN ingredient i ON c.id_ingredient = i.id_ingredient
JOIN foccacia f   ON c.id_focaccia   = f.id_focaccia
WHERE f.nom = 'Raclaccia'
ORDER BY i.nom ASC;

-- ===============================================================
-- Requête 6 : nom et nombre d'ingrédients pour chaque focaccia :
-- ===============================================================
-- But : Vérifier que toutes les compositions sont correctes.
--
-- Résultat attendu :
--   Américaine      → 8
--   Emmentalaccia   → 7
--   Gorgonzollaccia → 8
--   Hawaienne       → 9
--   Mozaccia        → 10
--   Paysanne        → 12
--   Raclaccia       → 7
--   Tradizione      → 9
--------------------------------------------------------------
SELECT f.nom AS focaccia, COUNT(c.id_ingredient) AS nb_ingredients
FROM foccacia f
JOIN comprend c ON f.id_focaccia = c.id_focaccia
GROUP BY f.id_focaccia, f.nom
ORDER BY f.nom ASC;

-- ============================================================
-- Requête 7 : focaccia qui a le plus d'ingrédients :
-- ============================================================
-- But : Identifier la focaccia la plus garnie.
--
-- Résultat attendu : Paysanne (12 ingrédients)
--------------------------------------------------------------
SELECT f.nom AS focaccia, COUNT(c.id_ingredient) AS nb_ingredients
FROM foccacia f
JOIN comprend c ON f.id_focaccia = c.id_focaccia
GROUP BY f.id_focaccia, f.nom
ORDER BY nb_ingredients DESC
LIMIT 1;

-- =============================================================
-- Requête 8 : liste des focaccias qui contiennent de l'ail :
-- =============================================================
-- But : Filtrer les focaccias selon un ingrédient spécifique.
--
-- Résultat attendu :
--   Gorgonzollaccia, Mozaccia, Paysanne, Raclaccia
--------------------------------------------------------------
SELECT DISTINCT f.nom AS focaccia
FROM foccacia f
JOIN comprend c    ON f.id_focaccia   = c.id_focaccia
JOIN ingredient i  ON c.id_ingredient = i.id_ingredient
WHERE i.nom = 'Ail'
ORDER BY f.nom ASC;

-- ============================================================
-- Requête 9 : liste des ingrédients inutilisés :
-- ============================================================
-- But : identifier les ingrédients présents dans la table
--       ingredient mais n'apparaissant dans aucune focaccia.
--
-- Résultat attendu :
--   Salami, Tomate cerise
--   (ces deux ingrédients ne sont utilisés dans aucune focaccia)
--------------------------------------------------------------
SELECT i.nom AS ingredient_inutilise
FROM ingredient i
LEFT JOIN comprend c ON i.id_ingredient = c.id_ingredient
WHERE c.id_focaccia IS NULL
ORDER BY i.nom ASC;

-- ============================================================
-- Requête 10 : liste des focaccias sans champignons :
-- ============================================================
-- But : trouver les focaccias qui ne contiennent pas
--       de champignon.
--
-- Résultat attendu :
--   Américaine, Hawaienne
--   (les 6 autres contiennent des champignons)
--------------------------------------------------------------
SELECT f.nom AS focaccia
FROM foccacia f
WHERE f.id_focaccia NOT IN (
    SELECT c.id_focaccia
    FROM comprend c
    JOIN ingredient i ON c.id_ingredient = i.id_ingredient
    WHERE i.nom = 'Champignon'
)
ORDER BY f.nom ASC;
