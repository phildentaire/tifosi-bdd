-- ============================================================
-- Script 2 : peuplement de la base de données Tifosi :
-- ============================================================

USE tifosi;

-------------------------------------------------
-- ingrédients (source : ingredient.xlsx)
-------------------------------------------------
INSERT INTO ingredient (id_ingredient, nom) VALUES
(1,  'Ail'),
(2,  'Ananas'),
(3,  'Artichaut'),
(4,  'Bacon'),
(5,  'Base Tomate'),
(6,  'Base crème'),
(7,  'Champignon'),
(8,  'Chevre'),
(9,  'Cresson'),
(10, 'Emmental'),
(11, 'Gorgonzola'),
(12, 'Jambon cuit'),
(13, 'Jambon fumé'),
(14, 'Oeuf'),
(15, 'Oignon'),
(16, 'Olive noire'),
(17, 'Olive verte'),
(18, 'Parmesan'),
(19, 'Piment'),
(20, 'Poivre'),
(21, 'Pomme de terre'),
(22, 'Raclette'),
(23, 'Salami'),
(24, 'Tomate cerise'),
(25, 'Mozarella');

------------------------------------
-- marques (source : marque.xlsx)
------------------------------------
INSERT INTO marque (id_marque, nom) VALUES
(1, 'Coca-cola'),
(2, 'Cristalline'),
(3, 'Monster'),
(4, 'Pepsico');

-------------------------------------
-- boissons (source : boisson.xlsx)
-------------------------------------
INSERT INTO boisson (id_boisson, nom, id_marque) VALUES
(1,  'Coca-cola zéro',           1),
(2,  'Coca-cola original',       1),
(3,  'Fanta citron',             1),
(4,  'Fanta orange',             1),
(5,  'Capri-sun',                1),
(6,  'Pepsi',                    4),
(7,  'Pepsi Max Zéro',           4),
(8,  'Lipton zéro citron',       4),
(9,  'Lipton Peach',             4),
(10, 'Monster energy ultra gold', 3),
(11, 'Monster energy ultra blue', 3),
(12, 'Eau de source',             2);

---------------------------------------
-- focaccias (source : focaccia.xlsx)
---------------------------------------
INSERT INTO foccacia (id_focaccia, nom, prix) VALUES
(1, 'Mozaccia',        9.80),
(2, 'Gorgonzollaccia', 10.80),
(3, 'Raclaccia',       8.90),
(4, 'Emmentalaccia',   9.80),
(5, 'Tradizione',      8.90),
(6, 'Hawaienne',       11.20),
(7, 'Américaine',      10.80),
(8, 'Paysanne',        12.80);

-------------------------------------------
-- Compositions : focaccia ↔ ingrédients
-- Quantités par défaut (en grammes) :
--   ail:2, ananas:40, artichaut:20, bacon:80,
--   base tomate:200, base crème:200, champignon:40,
--   chevre:50, cresson:20, emmental:50, gorgonzola:50,
--   jambon cuit:80, jambon fumé:80, oeuf:50, oignon:20,
--   olive noire:20, olive verte:20, parmesan:50,
--   piment:2, poivre:1, pomme de terre:80,
--   raclette:50, mozarella:50
--------------------------------------------

-- 1. mozaccia : base tomate(200), mozarella(50), cresson(20), jambon fumé(80),
--               ail(2), artichaut(20), champignon(40), parmesan(50), poivre(1), olive noire(20)
INSERT INTO comprend (id_focaccia, id_ingredient, quantite) VALUES
(1, 5,  200),  -- base Tomate
(1, 25,  50),  -- mozarella
(1, 9,   20),  -- cresson
(1, 13,  80),  -- jambon fumé
(1, 1,    2),  -- ail
(1, 3,   20),  -- artichaut
(1, 7,   40),  -- champignon
(1, 18,  50),  -- parmesan
(1, 20,   1),  -- poivre
(1, 16,  20);  -- olive noire

-- 2. Gorgonzollaccia : base tomate(200), gorgonzola(50), cresson(20), ail(2),
--                      champignon(40), parmesan(50), poivre(1), olive noire(20)
INSERT INTO comprend (id_focaccia, id_ingredient, quantite) VALUES
(2, 5,  200),  -- base Tomate
(2, 11,  50),  -- gorgonzola
(2, 9,   20),  -- cresson
(2, 1,    2),  -- ail
(2, 7,   40),  -- champignon
(2, 18,  50),  -- parmesan
(2, 20,   1),  -- poivre
(2, 16,  20);  -- olive noire

-- 3. Raclaccia : base tomate(200), raclette(50), cresson(20), ail(2),
--                champignon(40), parmesan(50), poivre(1)
INSERT INTO comprend (id_focaccia, id_ingredient, quantite) VALUES
(3, 5,  200),  -- base Tomate
(3, 22,  50),  -- raclette
(3, 9,   20),  -- cresson
(3, 1,    2),  -- ail
(3, 7,   40),  -- champignon
(3, 18,  50),  -- parmesan
(3, 20,   1);  -- poivre

-- 4. Emmentalaccia : base crème(200), emmental(50), cresson(20), champignon(40),
--                    parmesan(50), poivre(1), oignon(20)
INSERT INTO comprend (id_focaccia, id_ingredient, quantite) VALUES
(4, 6,  200),  -- base crème
(4, 10,  50),  -- emmental
(4, 9,   20),  -- cresson
(4, 7,   40),  -- champignon
(4, 18,  50),  -- parmesan
(4, 20,   1),  -- poivre
(4, 15,  20);  -- oignon

-- 5. Tradizione : base tomate(200), mozarella(50), cresson(20), jambon cuit(80),
--                 champignon(80), parmesan(50), Poivre(1), olive noire(10), olive verte(10)
INSERT INTO comprend (id_focaccia, id_ingredient, quantite) VALUES
(5, 5,  200),  -- base Tomate
(5, 25,  50),  -- mozarella
(5, 9,   20),  -- cresson
(5, 12,  80),  -- jambon cuit
(5, 7,   80),  -- champignon (quantité spéciale 80g)
(5, 18,  50),  -- parmesan
(5, 20,   1),  -- poivre
(5, 16,  10),  -- olive noire (quantité spéciale 10g)
(5, 17,  10);  -- olive verte (quantité spéciale 10g)

-- 6. Hawaienne : base tomate(200), mozarella(50), cresson(20), bacon(80),
--                ananas(40), piment(2), parmesan(50), poivre(1), olive noire(20)
INSERT INTO comprend (id_focaccia, id_ingredient, quantite) VALUES
(6, 5,  200),  -- base Tomate
(6, 25,  50),  -- mozarella
(6, 9,   20),  -- cresson
(6, 4,   80),  -- bacon
(6, 2,   40),  -- ananas
(6, 19,   2),  -- piment
(6, 18,  50),  -- parmesan
(6, 20,   1),  -- poivre
(6, 16,  20);  -- olive noire

-- 7. Américaine : base tomate(200), mozarella(50), cresson(20), bacon(80),
--                 pomme de terre(40), parmesan(50), poivre(1), olive noire(20)
INSERT INTO comprend (id_focaccia, id_ingredient, quantite) VALUES
(7, 5,  200),  -- base Tomate
(7, 25,  50),  -- mozarella
(7, 9,   20),  -- cresson
(7, 4,   80),  -- bacon
(7, 21,  40),  -- pomme de terre (quantité spéciale 40g)
(7, 18,  50),  -- parmesan
(7, 20,   1),  -- poivre
(7, 16,  20);  -- olive noire

-- 8. Paysanne : base crème(200), chevre(50), cresson(20), pomme de terre(80),
--               jambon fumé(80), ail(2), artichaut(20), champignon(40),
--               parmesan(50), poivre(1), olive noire(20), oeuf(50)
INSERT INTO comprend (id_focaccia, id_ingredient, quantite) VALUES
(8, 6,  200),  -- base crème
(8, 8,   50),  -- chevre
(8, 9,   20),  -- cresson
(8, 21,  80),  -- pomme de terre
(8, 13,  80),  -- jambon fumé
(8, 1,    2),  -- ail
(8, 3,   20),  -- artichaut
(8, 7,   40),  -- champignon
(8, 18,  50),  -- parmesan
(8, 20,   1),  -- poivre
(8, 16,  20),  -- olive noire
(8, 14,  50);  -- oeuf
