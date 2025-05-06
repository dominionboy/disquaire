import pandas as pd
import random, string
import numpy as np
from datetime import datetime, timedelta


def generate_id_number(n: int):
    data1 = pd.read_csv("Client.csv", header=0)
    generated_numbers = set()

    while len(generated_numbers) < n:
        number = int("1" + str(random.randint(100000, 999999)))
        if number not in generated_numbers and number not in data1[data1.columns[1]]:
            generated_numbers.add(number)

    return list(generated_numbers)

def generate_unique_number(n: int, nb=5):
    generated_numbers = set()
    letters = string.ascii_lowercase

    while len(generated_numbers) < n:
        id = ''.join(random.choice(letters) for i in range(nb))
        if id not in generated_numbers:
            generated_numbers.add(id)

    return list(generated_numbers)

def EXEMPLAIRE():
    emprunt = pd.read_csv("Emprunt.csv", header=0)
    exemplaire = pd.read_csv("Exemplaire.csv", header=0)

    """id_produit = []
    for chaine in data[data.columns[0]]:
        repetitions = random.randint(1, 12)
        id_produit.extend([chaine] * repetitions)
    random.shuffle(id_produit)"""

    exemplaire = pd.DataFrame({
        "code_interne": exemplaire["code_interne"],
        "id_produit": exemplaire["id"],
        "id_etat": np.random.choice(5, size=len(exemplaire["code_interne"]))
    })

    exemplaire.to_csv("Exemplaire.csv", index=False)


def generer_emprunt():
    # Booléen aléatoire : True = renouvelé, False = non renouvelé
    renouvelé = random.choice([True, False])

    # Durée totale selon le renouvellement
    durée = 60 if renouvelé else 30

    # Date de retour : max aujourd’hui, min aujourd’hui - durée jours
    jours_retard_max = random.randint(0, durée)
    date_retour = datetime.today() - timedelta(days=jours_retard_max)

    # Date d’emprunt = date de retour - durée totale
    date_emprunt = date_retour - timedelta(days=durée)

    # Formater les dates au format YYYY-MM-DD
    date_emprunt_str = date_emprunt.strftime('%Y-%m-%d')
    date_retour_str = date_retour.strftime('%Y-%m-%d')

    return renouvelé, date_emprunt_str, date_retour_str

def generer_liste_emprunts(n):
    emprunts = []
    departs = []
    retours = []
    for _ in range(n):
        emprunt, depart, retour = generer_emprunt()
        emprunts.append(emprunt)
        departs.append(depart)
        retours.append(retour)
    return emprunts, departs, retours

def EMPRUNT():
    data = pd.read_csv("Client.csv", header=0)
    data1 = pd.read_csv("Exemplaire.csv", header=0)
    client = data.sample(n=38)
    exemplaire = data1.sample(n=38)

    a, b, c = generer_liste_emprunts(38)

    emprunt = pd.DataFrame({
        "id_emprunt": generate_unique_number(n=38),
        "id_personne": list(client[client.columns[1]]),
        "numero_client": list(client[client.columns[0]]),
        "code_interne": list(exemplaire[exemplaire.columns[0]]),
        "id_produit": list(exemplaire[exemplaire.columns[0]]),
        "date_depart": b,
        "date_retour": c,
        "prolongation": a
    })

    emprunt.to_csv("Emprunt.csv", index=False)

def date_aleatoire_semaine_prochaine_mois_prochain():
    jours_ajouter = random.randint(7, 37)

    date_cible = datetime.today() + timedelta(days=jours_ajouter)
    date_str = date_cible.strftime('%Y-%m-%d')

    return date_str

def RESERVATION():
    data = pd.read_csv("Client.csv", header=0)
    data1 = pd.read_csv("Exemplaire.csv", header=0)
    client = data.sample(n=14)
    exemplaire = data1.sample(n=14)

    reservation = []
    for _ in range(14):
        reservation.append(date_aleatoire_semaine_prochaine_mois_prochain())

    reservation = pd.DataFrame({
        "id_reservation": generate_unique_number(n=14),
        "numero_client": list(client[client.columns[0]]),
        "id_personne": list(client[client.columns[1]]),
        "code_interne": list(exemplaire[exemplaire.columns[0]]),
        "id_produit": list(exemplaire[exemplaire.columns[1]]),
        "date_depart_reservation": reservation
    })

    reservation.to_csv("Reservation.csv", index=False)


#EXEMPLAIRE()
#EMPRUNT()
#RESERVATION()

import pandas as pd

exemplaire_df = pd.read_csv('Exemplaire.csv')
produits_df = pd.read_csv('Produits.csv')

# Liste pour stocker les id_produit
id_produits_list = []

# Boucle sur chaque titre_produit de Exemplaire
for titre in exemplaire_df['id_produit']:
    matching_rows = produits_df[produits_df['titre_produit'] == titre]
    
    if not matching_rows.empty:
        id_produit = matching_rows.iloc[0]['id_produit']
        id_produits_list.append(id_produit)
    else:
        id_produits_list.append("NULL")

exemplaire_df["id_produit"] = id_produits_list
exemplaire_df.to_csv("Exemplaire.csv", header=0)
