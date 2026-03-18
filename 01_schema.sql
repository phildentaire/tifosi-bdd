-- ============================================================
-- Script 1 : création du schéma de la base de données Tifosi :
-- ============================================================

-- Création de la base de données
CREATE DATABASE IF NOT EXISTS tifosi
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

-- Création de l'utilisateur et attribution des droits
CREATE USER IF NOT EXISTS 'tifosi'@'localhost' IDENTIFIED BY 'Tifosi@2024!';
GRANT ALL PRIVILEGES ON tifosi.* TO 'tifosi'@'localhost';
FLUSH PRIVILEGES;

USE tifosi;

-------------------------
-- Table : ingredient
-------------------------
CREATE TABLE IF NOT EXISTS ingredient (
    id_ingredient INT          NOT NULL AUTO_INCREMENT,
    nom           VARCHAR(50)  NOT NULL UNIQUE,
    PRIMARY KEY (id_ingredient)
) ENGINE=InnoDB;

------------------------
-- Table : marque
------------------------
CREATE TABLE IF NOT EXISTS marque (
    id_marque INT         NOT NULL AUTO_INCREMENT,
    nom       VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY (id_marque)
) ENGINE=InnoDB;

---------------------
-- Table : boisson
---------------------
CREATE TABLE IF NOT EXISTS boisson (
    id_boisson INT         NOT NULL AUTO_INCREMENT,
    nom        VARCHAR(50) NOT NULL UNIQUE,
    id_marque  INT         NOT NULL,
    PRIMARY KEY (id_boisson),
    CONSTRAINT fk_boisson_marque
        FOREIGN KEY (id_marque) REFERENCES marque (id_marque)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

----------------------
-- Table : foccacia
----------------------
CREATE TABLE IF NOT EXISTS foccacia (
    id_focaccia INT            NOT NULL AUTO_INCREMENT,
    nom         VARCHAR(50)    NOT NULL UNIQUE,
    prix        DECIMAL(5, 2)  NOT NULL CHECK (prix > 0),
    PRIMARY KEY (id_focaccia)
) ENGINE=InnoDB;

-------------------------------------------------
-- Table de jonction : comprend (focaccia ↔ ingredient)
-------------------------------------------------
CREATE TABLE IF NOT EXISTS comprend (
    id_focaccia   INT NOT NULL,
    id_ingredient INT NOT NULL,
    quantite      INT NOT NULL CHECK (quantite > 0),
    PRIMARY KEY (id_focaccia, id_ingredient),
    CONSTRAINT fk_comprend_focaccia
        FOREIGN KEY (id_focaccia) REFERENCES foccacia (id_focaccia)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_comprend_ingredient
        FOREIGN KEY (id_ingredient) REFERENCES ingredient (id_ingredient)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;
