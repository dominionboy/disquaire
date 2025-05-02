-- Suppression de la base de données si elle existe
DROP DATABASE IF EXISTS disquaire_db;

-- Création de la base de données
CREATE DATABASE disquaire_db;

-- Utiliser la base de données 'horaires_de_bus' pour les requêtes suivantes
USE disquaire_db;

-- Suppression et création des tables ainsi que leurs colonnes
DROP TABLE IF EXISTS client;
CREATE TABLE client (
  numero_client INT NOT NULL,
  id_personne INT NOT NULL,
  nom VARCHAR(50) NOT NULL,
  prenom VARCHAR(50) NOT NULL,
  date_inscription DATE NOT NULL,
  solde_client FLOAT NOT NULL,
  id_coordonnee INT NOT NULL,
  PRIMARY KEY (numero_client, id_personne)
);

DROP TABLE IF EXISTS coordonnees;
CREATE TABLE coordonnees (
  id_coordonnee INT NOT NULL,
  rue VARCHAR(50) NOT NULL,
  numero_rue INT NOT NULL,
  complement VARCHAR(50) NOT NULL,
  adresse_mail VARCHAR(50) NOT NULL,
  telephone VARCHAR(12) NOT NULL,
  id_pays INT NOT NULL,
  npa INT NOT NULL,
  PRIMARY KEY (id_coordonnee)
);

DROP TABLE IF EXISTS produit;
CREATE TABLE produit (
  id_produit INT NOT NULL,
  titre_produit VARCHAR(50) NOT NULL,
  annee_sortie INT NOT NULL,
  id_type INT NOT NULL,
  PRIMARY KEY (id_produit)
);

DROP TABLE IF EXISTS exemplaire;
CREATE TABLE exemplaire (
  code_interne INT NOT NULL,
  id_produit INT not null,
  id_etat INT NOT NULL,
  PRIMARY KEY (code_interne, id_produit)
);

DROP TABLE IF EXISTS genre;
CREATE TABLE genre (
    id_genre INT NOT NULL,
    genre VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_genre)
);

DROP TABLE IF EXISTS emprunt;
CREATE TABLE emprunt (
  id_emprunt INT NOT NULL,
  numero_client INT NOT NULL,
  id_personne INT NOT NULL,
  id_produit INT NOT NULL,
  code_interne INT NOT NULL,
  date_depart DATE NOT NULL,
  date_retour DATE NOT NULL,
  prolongation BOOLEAN NOT NULL,
  PRIMARY KEY (id_emprunt, numero_client, id_personne, id_produit, code_interne)
);

DROP TABLE IF EXISTS paiement;
CREATE TABLE paiement (
  id_paiement INT NOT NULL,
  montant_paiement FLOAT NOT NULL,
  numero_client INT NOT NULL,
  id_personne INT NOT NULL,
  id_methode_paiement INT NOT NULL,
  PRIMARY KEY (id_paiement)
);

DROP TABLE IF EXISTS abonnement;
CREATE TABLE abonnement (
  id_abonnement INT NOT NULL,
  date_activation DATE NOT NULL,
  date_expiration DATE NOT NULL,
  id_type_abonnement INT NOT NULL,
  PRIMARY KEY (id_abonnement)
);


DROP TABLE IF EXISTS artiste;
CREATE TABLE artiste (
  id_artiste INT NOT NULL,
  id_personne INT NOT NULL,
  nom_artiste VARCHAR(100) NOT NULL,
  nom VARCHAR(50) NOT NULL,
  prenom VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_artiste, id_personne)
);

DROP TABLE IF EXISTS commande;
CREATE TABLE commande (
  id_commande INT NOT NULL,
  id_fournisseur INT NOT NULL,
  date_livraison DATE NOT NULL,
  date_commande DATE NOT NULL,
  date_paiement DATE NOT NULL,
  PRIMARY KEY (id_commande, id_fournisseur)
);

DROP TABLE IF EXISTS fournisseur;
CREATE TABLE fournisseur (
  id_fournisseur INT NOT NULL,
  nom_entreprise VARCHAR(50) NOT NULL,
  id_coordonnee INT NOT NULL,
  PRIMARY KEY (id_fournisseur)
);

DROP TABLE IF EXISTS quantite;
CREATE TABLE quantite (
  id_commande INT NOT NULL,
  id_fournisseur INT NOT NULL,
  id_produit INT NOT NULL,
  quantite INT NOT NULL,
  prix FLOAT NOT NULL,
  PRIMARY KEY (id_commande, id_fournisseur, id_produit)
);

DROP TABLE IF EXISTS reservation;
CREATE TABLE reservation (
  id_reservation INT NOT NULL,
  numero_client INT NOT NULL,
  id_personne INT NOT NULL,
  id_produit INT NOT NULL,
  code_interne INT NOT NULL,
  date_depart_reservation DATE NOT NULL,
  PRIMARY KEY (id_reservation, numero_client, id_personne, id_produit, code_interne)
);

DROP TABLE IF EXISTS abonnement_actif;
CREATE TABLE abonnement_actif (
  id_abonnement INT NOT NULL,
  numero_client INT NOT NULL,
  id_personne INT NOT NULL,
  en_cours BOOLEAN NOT NULL,
  PRIMARY KEY (id_abonnement, numero_client, id_personne)
);

DROP TABLE IF EXISTS type_abonnement;
CREATE TABLE type_abonnement(
  id_type_abonnement INT NOT NULL,
  nom_abonnement VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_type_abonnement)
);

DROP TABLE IF EXISTS methode_paiement;
CREATE TABLE methode_paiement(
  id_methode_paiement INT NOT NULL,
  methode_paiement VARCHAR(20) NOT NULL,
  PRIMARY KEY (id_methode_paiement)
);

DROP TABLE IF EXISTS changement_stock;
CREATE TABLE changement_stock(
  id_stock_changement INT NOT NULL,
  quantite_changee INT NOT NULL,
  id_produit INT NOT NULL,
  PRIMARY KEY (id_stock_changement)
);

DROP TABLE IF EXISTS langue;
CREATE TABLE langue(
  id_langue INT NOT NULL,
  langue VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_langue)
);

DROP TABLE IF EXISTS type;
CREATE TABLE type(
  id_type INT NOT NULL,
  type VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_type)
);

DROP TABLE IF EXISTS format;
CREATE TABLE format(
  id_format INT NOT NULL,
  format VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_format)
);

DROP TABLE IF EXISTS pays;
CREATE TABLE pays(
  id_pays INT NOT NULL,
  pays VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_pays)
);

DROP TABLE IF EXISTS localite;
CREATE TABLE localite (
  npa INT NOT NULL,
  localite VARCHAR(50) NOT NULL,
  PRIMARY KEY (npa)
);

DROP TABLE IF EXISTS etat;
CREATE TABLE etat (
  id_etat INT NOT NULL,
  etat VARCHAR(20) NOT NULL,
  PRIMARY KEY (id_etat)
);

DROP TABLE IF EXISTS parler;
CREATE TABLE parler (
  id_langue INT NOT NULL,
  id_produit INT NOT NULL,
  PRIMARY KEY (id_langue, id_produit)
);

DROP TABLE IF EXISTS disponible;
CREATE TABLE disponible (
  id_produit INT NOT NULL,
  id_format INT NOT NULL,
  PRIMARY KEY (id_produit, id_format)
);

DROP TABLE IF EXISTS categorie;
CREATE TABLE categorie (
  id_produit INT NOT NULL,
  id_genre INT NOT NULL,
  PRIMARY KEY (id_produit, id_genre)
);

DROP TABLE IF EXISTS creation;
CREATE TABLE creation (
  id_artiste INT NOT NULL,
  id_personne INT NOT NULL,
  id_produit INT NOT NULL,
  PRIMARY KEY (id_artiste, id_personne, id_produit)
);

DROP TABLE IF EXISTS activite;
CREATE TABLE activite (
  id_artiste INT NOT NULL,
  id_personne INT NOT NULL,
  id_type_artiste INT NOT NULL,
  PRIMARY KEY (id_artiste, id_personne, id_type_artiste)
);

DROP TABLE IF EXISTS type_artiste;
CREATE TABLE type_artiste (
  id_type_artiste INT NOT NULL,
  type_artiste VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_type_artiste)
);

DROP TABLE IF EXISTS nationalite;
CREATE TABLE nationalite (
  id_pays INT NOT NULL,
  id_artiste INT NOT NULL,
  id_personne INT NOT NULL,
  PRIMARY KEY (id_pays, id_artiste, id_personne)
);

-- Ajouter les contraintes de clés étrangères sur les différentes tables
ALTER TABLE abonnement
   ADD CONSTRAINT fk_abonnement_type_abonnement
   FOREIGN KEY (id_type_abonnement)
   REFERENCES type_abonnement(id_type_abonnement);

ALTER TABLE abonnement_actif
   ADD CONSTRAINT fk_abonnement_actif_abonnement
   FOREIGN KEY (id_abonnement)
   REFERENCES abonnement(id_abonnement);

ALTER TABLE abonnement_actif
   ADD CONSTRAINT fk_abonnement_actif_client
   FOREIGN KEY (numero_client, id_personne)
   REFERENCES client(numero_client, id_personne);

ALTER TABLE paiement
   ADD CONSTRAINT fk_paiement_client
   FOREIGN KEY (numero_client, id_personne)
   REFERENCES client(numero_client, id_personne);

ALTER TABLE paiement
   ADD CONSTRAINT fk_paiement_methode_paiement
   FOREIGN KEY (id_methode_paiement)
   REFERENCES methode_paiement(id_methode_paiement);

ALTER TABLE client
  ADD CONSTRAINT fk_client_coordonnees
  FOREIGN KEY (id_coordonnee)
  REFERENCES coordonnees(id_coordonnee)

ALTER TABLE reservation
   ADD CONSTRAINT fk_reservation_exemplaire
   FOREIGN KEY (code_interne, id_produit)
   REFERENCES exemplaire(code_interne, id_produit);

ALTER TABLE reservation
   ADD CONSTRAINT fk_reservation_client
   FOREIGN KEY (numero_client, id_personne)
   REFERENCES client(numero_client, id_personne);

ALTER TABLE emprunt
   ADD CONSTRAINT fk_emprunt_client
   FOREIGN KEY (numero_client, id_personne)
   REFERENCES client(numero_client, id_personne);

ALTER TABLE emprunt
   ADD CONSTRAINT fk_emprunt_exemplaire
   FOREIGN KEY (code_interne, id_produit)
   REFERENCES exemplaire(code_interne, id_produit);

ALTER TABLE exemplaire
   ADD CONSTRAINT fk_exemplaire_produit
   FOREIGN KEY (id_produit)
   REFERENCES produit(id_produit);

ALTER TABLE exemplaire
   ADD CONSTRAINT fk_exemplaire_etat
   FOREIGN KEY (id_etat)
   REFERENCES etat(id_etat);

ALTER TABLE changement_stock
   ADD CONSTRAINT fk_changement_stock_prdoduit
   FOREIGN KEY (id_produit)
   REFERENCES produit(id_produit);

ALTER TABLE parler
   ADD CONSTRAINT fk_parler_langue
   FOREIGN KEY (id_langue)
   REFERENCES langue(id_langue);

ALTER TABLE parler
   ADD CONSTRAINT fk_parler_produit
   FOREIGN KEY (id_produit)
   REFERENCES produit(id_produit);

ALTER TABLE produit
  ADD CONSTRAINT fk_produit_type
  FOREIGN KEY (id_type)
  REFERENCES type(id_type)

ALTER TABLE disponible
  ADD CONSTRAINT fk_disponible_format
  FOREIGN KEY (id_format)
  REFERENCES format(id_format)

ALTER TABLE disponible
  ADD CONSTRAINT fk_disponible_produit
  FOREIGN KEY (id_produit)
  REFERENCES produit(id_produit)

ALTER TABLE categorie
  ADD CONSTRAINT fk_categorie_produit
  FOREIGN KEY (id_produit)
  REFERENCES produit(id_produit)

ALTER TABLE categorie
  ADD CONSTRAINT fk_categorie_genre
  FOREIGN KEY (id_genre)
  REFERENCES genre(id_genre)

ALTER TABLE quantite
  ADD CONSTRAINT fk_quantite_commande
  FOREIGN KEY (id_commande, id_fournisseur)
  REFERENCES commande(id_commande, id_fournisseur)

ALTER TABLE quantite
  ADD CONSTRAINT fk_quantite_produit
  FOREIGN KEY (id_produit)
  REFERENCES produit(id_produit)

ALTER TABLE commande
  ADD CONSTRAINT fk_commande_fournisseur
  FOREIGN KEY (id_fournisseur)
  REFERENCES fournisseur(id_fournisseur)

ALTER TABLE fournisseur
  ADD CONSTRAINT fk_fournisseur_coordonnees
  FOREIGN KEY (id_coordonnee)
  REFERENCES coordonnees(id_coordonnee)

ALTER TABLE coordonnees
  ADD CONSTRAINT fk_coordonnees_pays
  FOREIGN KEY (id_pays)
  REFERENCES pays(id_pays)

ALTER TABLE coordonnees
  ADD CONSTRAINT fk_coordonnees_localite
  FOREIGN KEY (npa)
  REFERENCES localite(npa)

ALTER TABLE creation
   ADD CONSTRAINT fk_creation_produit
   FOREIGN KEY (id_produit)
   REFERENCES produit(id_produit);

ALTER TABLE creation
   ADD CONSTRAINT fk_creation_artiste
   FOREIGN KEY (id_artiste, id_personne)
   REFERENCES artiste(id_artiste, id_personne);

ALTER TABLE activite
  ADD CONSTRAINT fk_activite_type_artiste
  FOREIGN KEY (id_type_artiste)
  REFERENCES type_artiste(id_type_artiste);

ALTER TABLE activite
  ADD CONSTRAINT fk_activite_artiste
  FOREIGN KEY (id_artiste, id_personne)
  REFERENCES artiste(id_artiste, id_personne);

ALTER TABLE nationalite
  ADD CONSTRAINT fk_nationalite_pays
  FOREIGN KEY (id_pays)
  REFERENCES pays(id_pays)

ALTER TABLE nationalite
  ADD CONSTRAINT fk_nationalite_artiste
  FOREIGN KEY (id_artiste, id_personne)
  REFERENCES artiste(id_artiste, id_personne)

