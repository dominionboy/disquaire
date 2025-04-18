-- Suppression de la base de données si elle existe
DROP DATABASE IF EXISTS disquaire_db;




-- Création de la base de données
CREATE DATABASE disquaire_db;




-- Utiliser la base de données 'disquaire_db' pour les requêtes suivantes
USE disquaire_db;




-- Suppression et création des tables
DROP TABLE IF EXISTS abonnement;
CREATE TABLE abonnement (
  id_abonnement INT NOT NULL,
  date_activation DATE NOT NULL,
  date_expiration DATE NOT NULL,
  nom_abonnement VARCHAR(50) NOT NULL,
  duree_abonnement INT NOT NULL,
  PRIMARY KEY (id_abonnement)
);




DROP TABLE IF EXISTS possession;
CREATE TABLE possession (
  id_abonnement INT NOT NULL,
  numero_client INT NOT NULL,
  id_personne INT NOT NULL,
  id_coordonnee INT NOT NULL,
  PRIMARY KEY (id_abonnement, numero_client, id_personne, id_coordonnee)
);




DROP TABLE IF EXISTS client;
CREATE TABLE client (
  numero_client INT NOT NULL,
  id_personne INT NOT NULL,
  id_coordonnee INT NOT NULL,
  nom VARCHAR(50) NOT NULL,
  prenom VARCHAR(50) NOT NULL,
  date_inscription DATE NOT NULL,
  solde_client FLOAT NOT NULL,
  npa INT NOT NULL,
  localite VARCHAR(50) NOT NULL,
  rue VARCHAR(50) NOT NULL,
  numero_rue INT NOT NULL,
  complement VARCHAR(50) NOT NULL,
  adresse_mail VARCHAR(50) NOT NULL,
  telephone CHAR(12) NOT NULL,
  PRIMARY KEY (numero_client, id_personne, id_coordonnee)
);




DROP TABLE IF EXISTS paiement;
CREATE TABLE paiement (
  id_paiement INT NOT NULL,
  methode_paiement VARCHAR(50) NOT NULL,
  montant_paiement FLOAT NOT NULL,
  numero_client INT NOT NULL,
  id_personne INT NOT NULL,
  id_coordonnee INT NOT NULL,
  PRIMARY KEY (id_paiement)
);




DROP TABLE IF EXISTS emprunt;
CREATE TABLE emprunt (
  id_emprunt INT NOT NULL,
  numero_client INT NOT NULL,
  id_personne INT NOT NULL,
  id_coordonnee INT NOT NULL,
  id_produit INT NOT NULL,
  code_interne INT NOT NULL,
  date_depart DATE NOT NULL,
  date_retour DATE NOT NULL,
  nb_jours_emprunt INT NOT NULL,
  periode_emprunt INT NOT NULL,
  prolongation BOOLEAN NOT NULL,
  PRIMARY KEY (id_emprunt, numero_client, id_personne, id_coordonnee, id_produit, code_interne)
);




DROP TABLE IF EXISTS reservation;
CREATE TABLE reservation (
  id_reservation INT NOT NULL,
  numero_client INT NOT NULL,
  id_personne INT NOT NULL,
  id_coordonnee INT NOT NULL,
  id_produit INT NOT NULL,
  code_interne INT NOT NULL,
  date_depart_reservation DATE NOT NULL,
  date_retour_reservation DATE NOT NULL,
  PRIMARY KEY (id_reservation, numero_client, id_personne, id_coordonnee, id_produit, code_interne)
);




DROP TABLE IF EXISTS exemplaire;
CREATE TABLE exemplaire (
  code_interne INT NOT NULL,
  id_produit INT NOT NULL,
  etat VARCHAR(20) NOT NULL,
  statut_exemplaire VARCHAR(20) NOT NULL,
  PRIMARY KEY (code_interne, id_produit)
);




DROP TABLE IF EXISTS produit;
CREATE TABLE produit (
  id_produit INT NOT NULL,
  titre_produit VARCHAR(50) NOT NULL,
  nb_exemplaire INT NOT NULL,
  annee_sortie INT NOT NULL,
  genre_musical VARCHAR(50) NOT NULL,
  format_physique VARCHAR(50) NOT NULL,
  type VARCHAR(50) NOT NULL,
  langue VARCHAR(50) NOT NULL,
  label VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_produit)
);




DROP TABLE IF EXISTS creation;
CREATE TABLE creation (
  id_artiste INT NOT NULL,
  id_personne INT NOT NULL,
  id_produit INT NOT NULL,
  PRIMARY KEY (id_artiste, id_personne, id_produit)
);




DROP TABLE IF EXISTS artiste;
CREATE TABLE artiste (
  id_artiste INT NOT NULL,
  id_personne INT NOT NULL,
  nom_artiste VARCHAR(100) NOT NULL,
  nom VARCHAR(50) NOT NULL,
  prenom VARCHAR(50) NOT NULL,
  pays_artiste VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_artiste, id_personne)
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




DROP TABLE IF EXISTS quantite;
CREATE TABLE quantite (
  id_commande INT NOT NULL,
  id_contrat INT NOT NULL,
  ide INT NOT NULL,
  id_coordonnee INT NOT NULL,
  id_produit INT NOT NULL,
  quantite INT NOT NULL,
  prix FLOAT NOT NULL,
  PRIMARY KEY (id_commande, id_contrat, ide, id_coordonnee, id_produit)
);




DROP TABLE IF EXISTS commande;
CREATE TABLE commande (
  id_commande INT NOT NULL,
  id_contrat INT NOT NULL,
  ide INT NOT NULL,
  id_coordonnee INT NOT NULL,
  date_commande DATE NOT NULL,
  date_livraison DATE NOT NULL,
  statut_commande VARCHAR(50) NOT NULL,
  prix_commande FLOAT NOT NULL,
  PRIMARY KEY (id_commande, id_contrat, ide, id_coordonnee)
);




DROP TABLE IF EXISTS contrat;
CREATE TABLE contrat (
  id_contrat INT NOT NULL,
  ide INT NOT NULL,
  id_coordonnee INT NOT NULL,
  date_contrat DATE NOT NULL,
  prix_contrat FLOAT NOT NULL,
  date_paiement DATE NOT NULL,
  paye_ou_non BOOLEAN NOT NULL,
  PRIMARY KEY (id_contrat, ide, id_coordonnee)
);




DROP TABLE IF EXISTS fournisseur;
CREATE TABLE fournisseur (
  ide INT NOT NULL,
  id_coordonnee INT NOT NULL,
  nom_entreprise VARCHAR(50) NOT NULL,
  npa INT NOT NULL,
  localite VARCHAR(50) NOT NULL,
  rue VARCHAR(50) NOT NULL,
  numero_rue INT NOT NULL,
  complement VARCHAR(50) NOT NULL,
  adresse_mail VARCHAR(50) NOT NULL,
  telephone CHAR(12),
  PRIMARY KEY (ide, id_coordonnee)
);




-- Ajouter les contraintes de clés étrangères sur les différentes tables




ALTER TABLE possession
   ADD CONSTRAINT fk_possession_abonnement
   FOREIGN KEY (id_abonnement)
   REFERENCES abonnement(id_abonnement);




ALTER TABLE possession
   ADD CONSTRAINT fk_possession_client
   FOREIGN KEY (numero_client, id_personne, id_coordonnee)
   REFERENCES client(numero_client, id_personne, id_coordonnee);




ALTER TABLE paiement
   ADD CONSTRAINT fk_paiement_client
   FOREIGN KEY (numero_client, id_personne, id_coordonnee)
   REFERENCES client(numero_client, id_personne, id_coordonnee);




ALTER TABLE emprunt
   ADD CONSTRAINT fk_emprunt_client
   FOREIGN KEY (numero_client, id_personne, id_coordonnee)
   REFERENCES client(numero_client, id_personne, id_coordonnee);




ALTER TABLE emprunt
   ADD CONSTRAINT fk_emprunt_exemplaire
   FOREIGN KEY (code_interne, id_produit)
   REFERENCES exemplaire(code_interne, id_produit);




ALTER TABLE reservation
   ADD CONSTRAINT fk_reservation_client
   FOREIGN KEY (numero_client, id_personne, id_coordonnee)
   REFERENCES client(numero_client, id_personne, id_coordonnee);




ALTER TABLE reservation
   ADD CONSTRAINT fk_reservation_exemplaire
   FOREIGN KEY (code_interne, id_produit)
   REFERENCES exemplaire (code_interne, id_produit);




ALTER TABLE exemplaire
   ADD CONSTRAINT fk_exemplaire_produit
   FOREIGN KEY (id_produit)
   REFERENCES produit(id_produit);




ALTER TABLE quantite
   ADD CONSTRAINT fk_quantite_commande
   FOREIGN KEY (id_commande, id_contrat, ide, id_coordonnee)
   REFERENCES commande(id_commande, id_contrat, ide, id_coordonnee);




ALTER TABLE quantite
   ADD CONSTRAINT fk_quantite_produit
   FOREIGN KEY (id_produit)
   REFERENCES produit(id_produit);




ALTER TABLE commande
   ADD CONSTRAINT fk_commande_contrat
   FOREIGN KEY (id_contrat, ide, id_coordonnee)
   REFERENCES contrat(id_contrat, ide, id_coordonnee);




ALTER TABLE contrat
   ADD CONSTRAINT fk_contrat_fournisseur
   FOREIGN KEY (ide, id_coordonnee)
   REFERENCES fournisseur(ide, id_coordonnee);




ALTER TABLE creation
   ADD CONSTRAINT fk_creation_artiste
   FOREIGN KEY (id_artiste, id_personne)
   REFERENCES artiste(id_artiste, id_personne);




ALTER TABLE creation
   ADD CONSTRAINT fk_creation_produit
   FOREIGN KEY (id_produit)
   REFERENCES produit(id_produit);




ALTER TABLE activite
   ADD CONSTRAINT fk_activite_artiste
   FOREIGN KEY (id_artiste, id_personne)
   REFERENCES artiste(id_artiste, id_personne);




ALTER TABLE activite
   ADD CONSTRAINT fk_activite_type_artiste
   FOREIGN KEY (id_type_artiste)
   REFERENCES type_artiste(id_type_artiste);










-- Insertion de valeurs (à faire sur un autre document VScode)
/*INSERT INTO abonnement (id_abonnement, date_activation, date_expiration, nom_abonnement, duree_abonnement) VALUES ();


INSERT INTO possession (id_abonnement, numero_client, id_personne, id_coordonnee) VALUES ();


INSERT INTO client (numero_client, id_personne, id_coordonnee, nom, prenom, date_inscription, solde_client, npa, localite, rue, numero_rue, complement, adresse_mail, telephone) VALUES ();


INSERT INTO paiement (id_paiement, methode_paiement, montant_paiement, numero_client, id_personne, id_coordonnee) VALUES ();


INSERT INTO reservation (id_reservation, numero_client, id_personne, id_coordonnee, id_produit, code_interne, date_depart_reservation, date_retour_reservation) VALUES ();


INSERT INTO exemplaire (code_interne, id_produit, etat, statut_exemplaire) VALUES ();


INSERT INTO emprunt (id_emprunt, numero_client, id_personne, id_coordonnee, id_produit, code_interne, date_depart, date_retour, nb_jours_emprunt, periode_emprunt, prolongation) VALUES ();


INSERT INTO produit (id_produit, titre_produit, nb_exemplaire, annee_sortie, genre_musical, format_physique, type, langue, label) VALUES ();


INSERT INTO quantite (id_commande, id_contrat, ide, id_coordonnee, id_produit, quantite, prix) VALUES ();


INSERT INTO creation (id_artiste, id_personne, id_produit) VALUES ();


INSERT INTO artiste (id_artiste, id_personne,nom_artiste, nom, prenom, pays_artiste) VALUES ();


INSERT INTO activite (id_artiste, id_personne, id_type_artiste) VALUES ();


INSERT INTO type_artiste (id_type_artiste, type_artiste) VALUES ();


INSERT INTO commande (id_commande, id_contrat, ide, id_coordonnee, date_commande, date_livraison, statut_commande, prix_commande) VALUES ();


INSERT INTO contrat (id_contrat, ide, id_coordonnee, date_contrat, prix_contrat, date_paiement, paye_ou_non) VALUES ();


INSERT INTO fournisseur (ide, id_coordonnee, nom_entreprise, npa, localite, rue, numero_rue, complement, adresse_mail, telephone) VALUES ();*/
