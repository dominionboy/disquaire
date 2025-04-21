
DROP DATABASE IF EXISTS disquaire_db;
CREATE DATABASE disquaire_db;
USE disquaire_db;


CREATE TABLE client (
  numero_client INT NOT NULL,
  id_personne INT NOT NULL,
  nom VARCHAR(50) NOT NULL,
  prenom VARCHAR(50) NOT NULL,
  date_inscription DATE NOT NULL,
  solde_client FLOAT NOT NULL,
  id_coordonnee
  PRIMARY KEY (numero_client,id_personne)
);

CREATE TABLE coordonnees (
  id_coordonnee INT NOT NULL,
  npa INT NOT NULL,
  localite VARCHAR(50) NOT NULL,
  rue VARCHAR(50) NOT NULL,
  numero_rue INT NOT NULL,
  complement VARCHAR(50),
  adresse_mail VARCHAR(50) NOT NULL,
  telephone VARCHAR(12) NOT NULL,
  id_pays INT NOT NULL
  PRIMARY KEY (id_coordonnee)
);


CREATE TABLE produit (
  id_produit INT NOT NULL,
  titre_produit VARCHAR(100) NOT NULL,
  annee_sortie INT,
  id_type INT NOT NULL,
  PRIMARY KEY (id_produit)
);

CREATE TABLE exemplaire (
  code_interne INT NOT NULL,
  id_produit INT not null,
  id_etat INT NOT NULL,
  PRIMARY KEY (code_interne,id_produit)
);

CREATE TABLE genre (
    id_genre INT NOT NULL,
    genre VARCHAR(100) NOT NULL
    PRIMARY KEY (id_genre)
);

CREATE TABLE emprunt (
  id_emprunt INT NOT NULL,
  numero_client INT NOT NULL,
  id_personne INT NOT NULL,
  id_produit INT NOT NULL,
  code_interne INT NOT NULL,
  date_depart DATE NOT NULL,
  date_retour DATE NOT NULL,
  prolongation BOOLEAN NOT NULL,
  PRIMARY KEY (id_emprunt,numero_client,id_personne,id_produit,code_interne)
);

CREATE TABLE paiement (
  id_paiement INT NOT NULL,
  montant_paiement FLOAT not null,
  numero_client INT NOT NULL,
  id_personne INT NOT NULL,
  id_methode_paiement int not null,
  PRIMARY KEY (id_paiement)
);

CREATE TABLE abonnement (
  id_abonnement INT NOT NULL,
  date_activation DATE NOT NULL,
  date_expiration DATE NOT NULL,
  PRIMARY KEY (id_abonnement)
);



CREATE TABLE artiste (
  id_artiste INT NOT NULL,
  id_personne INT NOT NULL,
  nom VARCHAR(50) NOT NULL,
  prenom VARCHAR(50) NOT NULL,
  nom_artiste VARCHAR(100),
  PRIMARY KEY (id_artiste)
);


CREATE TABLE commande (
  id_commande INT NOT NULL,
  id_fournisseur INT NOT NULL,
  date_livraison DATE NOT NULL,
  date_commande DATE NOT NULL,
  date_paiement DATE NOT NULL,
  PRIMARY KEY (id_commande)
);


CREATE TABLE fournisseur (
  id_fournisseur INT NOT NULL,
  nom_entreprise VARCHAR(50)
  id_coordonnee INT NOT NULL,
  PRIMARY KEY (id_fournisseur)
);

CREATE TABLE quantite (
  id_commande INT NOT NULL,
  id_fournisseur INT NOT NULL,
  id_produit INT NOT NULL,
  quantite INT NOT NULL,
  prix FLOAT NOT NULL,
  PRIMARY KEY (id_commande, id_fournisseur, id_produit)
);

CREATE TABLE reservation (
  id_reservation INT NOT NULL,
  numero_client INT NOT NULL,
  id_personne INT NOT NULL,
  id_produit INT NOT NULL,
  code_interne INT NOT NULL,
  date_depart_reservation DATE NOT NULL,

  PRIMARY KEY (id_reservation, numero_client, id_personne, id_produit, code_interne)
);

CREATE TABLE abonnement_actif (
  id_abonnement INT NOT NULL,
  numero_client INT NOT NULL,
  id_personne INT NOT NULL,
  en_cours BOOLEAN NOT NULL,

  PRIMARY KEY (id_abonnement, numero_client, id_personne)
);

CREATE TABLE reservation (
  id_reservation INT NOT NULL,
  numero_client INT NOT NULL,
  id_personne INT NOT NULL,
  id_produit INT NOT NULL,
  code_interne INT NOT NULL,
  date_depart_reservation DATE NOT NULL,

  PRIMARY KEY (id_reservation, numero_client, id_personne, id_produit, code_interne)
);

CREATE TABLE abonnement (
  id_abonnement INT NOT NULL,
  date_activation DATE NOT NULL,
  date_expiration DATE NOT NULL,
  id_type_abonnement INT NOT NULL,
  PRIMARY KEY (id_abonnement)
);

CREATE TABLE type_abonnement(
  id_type_abonnement INT not null,
  nom_abonnement VARCHAR(50),
  PRIMARY KEY (id_type_abonnement)
);

CREATE TABLE methode_paiement(
  id_methode_paiement INT NOT NULL,
  methode_paiement VARCHAR(20),
  PRIMARY KEY (id_methode_paiement)
);

CREATE TABLE type_artiste(
  id_type_artiste INT NOT NULL,
  type_artiste VARCHAR(50),
  PRIMARY KEY (id_methode_paiement)
);

CREATE TABLE changement_stock(
  id_stock_changement INT NOT NULL,
  quantite_changee INT NOT NULL,
  id_produit INT NOT NULL,
  PRIMARY KEY (id_stock_changement)
);

CREATE TABLE langue(
  id_langue INT NOT NULL,
  langue VARCHAR(50),
  PRIMARY KEY (id_stock_changement)
);



CREATE TABLE type(
  id_type INT NOT NULL,
  type VARCHAR(50),
  PRIMARY KEY (id_type)
);

CREATE TABLE format(
  id_format INT NOT NULL,
  format VARCHAR(50),
  PRIMARY KEY (id_format)
);


CREATE TABLE pays(
  id_pays INT NOT NULL,
  pays VARCHAR(50),
  PRIMARY KEY (id_pays)
);

CREATE TABLE localite (
  npa INT NOT NULL,
  localite VARCHAR(50) NOT NULL,
  PRIMARY KEY (npa)
);


