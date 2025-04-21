
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
  id_coordonnee INT NOT NULL,
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
  nom_abonnement VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_type_abonnement)
);

CREATE TABLE methode_paiement(
  id_methode_paiement INT NOT NULL,
  methode_paiement VARCHAR(20) NOT NULL,
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




ALTER TABLE 
  ADD CONSTRAINT
  FOREIGN KEY ()
  REFERENCES  ()

ALTER TABLE categorie
  ADD CONSTRAINT fk_categorie_produit
  FOREIGN KEY (id_produit)
  REFERENCES produit (id_produit)

ALTER TABLE categorie
  ADD CONSTRAINT fk_categorie_genre
  FOREIGN KEY (id_genre)
  REFERENCES genre (id_genre)

ALTER TABLE disponible
  ADD CONSTRAINT fk_disponible_format
  FOREIGN KEY (id_format)
  REFERENCES format (id_format)

ALTER TABLE disponible
  ADD CONSTRAINT fk_disponible_produit
  FOREIGN KEY (id_produit)
  REFERENCES produit (id_produit)

ALTER TABLE produit
  ADD CONSTRAINT fk_produit_type
  FOREIGN KEY (id_type)
  REFERENCES type (id_type)

ALTER TABLE coordonnee
  ADD CONSTRAINT
  FOREIGN KEY (id_pays)
  REFERENCES pays (id_pays)

ALTER TABLE coordonnee
  ADD CONSTRAINT fk_coordonnee_localite
  FOREIGN KEY (npa)
  REFERENCES locallite (npa)

ALTER TABLE client
  ADD CONSTRAINT fk_client_coordonnee
  FOREIGN KEY (id_coordonnee)
  REFERENCES coordonnee (id_coordonnee)

ALTER TABLE fournisseur
  ADD CONSTRAINT fk_fournisseur_coordonnee
  FOREIGN KEY (id_coordonnee)
  REFERENCES coordonnee (id_coordonnee)

ALTER TABLE commande
  ADD CONSTRAINT fk_commande_fournisseur
  FOREIGN KEY (id_fournisseur)
  REFERENCES fournisseur (id_fournisseur)


ALTER TABLE quantite
  ADD CONSTRAINT fk_quantite_commande
  FOREIGN KEY (id_commande,id_fournisseur)
  REFERENCES commande (id_commande,id_fournisseur)


ALTER TABLE quantite
  ADD CONSTRAINT fk_quantite_produit
  FOREIGN KEY (id_produit)
  REFERENCES produit (id_produit)


ALTER TABLE nationalite
  ADD CONSTRAINT fk_nationalite_pays
  FOREIGN KEY (id_pays)
  REFERENCES pays (id_pays)


ALTER TABLE nationalite
  ADD CONSTRAINT fk_nationalite_artiste
  FOREIGN KEY (id_artiste,id_personne)
  REFERENCES artiste (id_artitste,id_personne)


ALTER TABLE activite
  ADD CONSTRAINT fk_activite_type_artiste
  FOREIGN KEY (id_type_artiste)
  REFERENCES artiste (id_type_artiste);


ALTER TABLE activite
  ADD CONSTRAINT fk_activite_artiste
  FOREIGN KEY (id_artiste,id_personne)
  REFERENCES artiste (id_artiste, id_personne);

ALTER TABLE creation
   ADD CONSTRAINT fk_creation_produit
   FOREIGN KEY (id_produit)
   REFERENCES produit(id_produit);


ALTER TABLE creation
   ADD CONSTRAINT fk_creation_artiste
   FOREIGN KEY (id_artiste,id_personne)
   REFERENCES artiste(id_artiste,id_personne);



ALTER TABLE parler
   ADD CONSTRAINT fk_parler_langue
   FOREIGN KEY (id_langue)
   REFERENCES langue(id_langue);

ALTER TABLE parler
   ADD CONSTRAINT fk_parler_produit
   FOREIGN KEY (id_produit)
   REFERENCES produit(id_produit);



ALTER TABLE changement_stock
   ADD CONSTRAINT fk_changement_stock_prdoduit
   FOREIGN KEY (id_produit)
   REFERENCES client(id_produit);







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







ALTER TABLE reservation
   ADD CONSTRAINT fk_contrat_exemplaire
   FOREIGN KEY (code_interne, id_produit)
   REFERENCES exemplaire(ide, id_produit);




ALTER TABLE reservation
   ADD CONSTRAINT fk_reservation_client
   FOREIGN KEY (numero_client, id_personne)
   REFERENCES client(numero_client, id_personne);


ALTER TABLE paiement
   ADD CONSTRAINT fk_paiement_client
   FOREIGN KEY (numero_client,id_personne)
   REFERENCES client(id_personne);

ALTER TABLE paiement
   ADD CONSTRAINT fk_paiement_methode_paiement
   FOREIGN KEY (id_methode_paiement)
   REFERENCES methode_paiementduit(id_methode_paiement);




ALTER TABLE abonnement_actif
   ADD CONSTRAINT fk_abonnement_actif_client
   FOREIGN KEY (numero_client, id_personne)
   REFERENCES client(id_anumero_clietrtiste, id_personne);




ALTER TABLE abonnement_actif
   ADD CONSTRAINT fk_abonnement_actif_abonnement
   FOREIGN KEY (id_abonnement)
   REFERENCES abonnement(id_abonnement);


ALTER TABLE abonnement
   ADD CONSTRAINT fk_abonnement_type_abonnement
   FOREIGN KEY (id_type_abonnement)
   REFERENCES type_abonnement(id_type_abonnement);
