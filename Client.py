import pandas as pd
import random, string, spotipy
import numpy as np

from spotipy.oauth2 import SpotifyClientCredentials


client_id = 'e83c78dd6c24466192e051776013968d'
client_secret = "21a0b33f1d3c4a04bb7eabd6e3484ccb"

client_credential_manager = SpotifyClientCredentials(
    client_id=client_id,
    client_secret=client_secret)

sp = spotipy.Spotify(client_credentials_manager=client_credential_manager)


def ABONNEMENT_ACTIF():
    data = pd.read_csv("Client.csv")
    formats = [True, False]
    prob = [0.35, 0.65]

    mychoice = np.random.choice(formats, size=len(data), p=prob)

    abonnement = pd.DataFrame({
        "numero_client": data[data.columns[0]],
        "id_personne": data[data.columns[1]],
        "en_cour": mychoice
    })

    abonnement.to_csv("Abonnement_actif.csv", index=False)


from datetime import datetime, timedelta

def select_dates():
    date_format = "%Y-%m-%d"
    start_dt = datetime.strptime("2023-03-02", date_format)
    end_dt = datetime.strptime("2025-03-28", date_format)

    delta = (end_dt - start_dt).days
    rand_days_1 = random.randint(0, delta)
    rand_days_2 = random.randint(0, delta)
    
    while rand_days_1 >= rand_days_2:
        rand_days_2 = random.randint(0, delta)
    
    date1 = start_dt + timedelta(days=rand_days_1)
    date2 = start_dt + timedelta(days=rand_days_2)

    delta2 = delta = (date2 - date1).days
    
    a, b = str(date1).split(" ")
    c, d = str(date2).split(" ")

    return  a, c, delta2

def ABONNEMENT():
    data2 = pd.read_csv("Abonnement_actif.csv", header=0)
    date_activation = []
    date_expiration = []
    id_type_abonnement = []

    for j in data2[data2.columns[2]]:
        if j == False:
            date_activation.append("None")
            date_expiration.append("None")
            id_type_abonnement.append("913908")
        else:
            a,b, c = select_dates()
            date_activation.append(a)
            date_expiration.append(b)
            id_type_abonnement.append(random.choice(["991990", "943003"]))

    abonnement = pd.DataFrame({
        "id_abonnement": generate_unique_number(n=len(id_type_abonnement), nb=4),
        "id_type_abonnement": id_type_abonnement,
        "date_activation": date_activation,
        "date_expiration": date_expiration
    })

    abonnement.to_csv("Abonnement.csv", index=False)
    data2["id_abonnement"] = abonnement["id_abonnement"]
    data2.to_csv("Abonnement_actif(1).csv", index=False)

def generate_unique_number(n: int, nb: int):
    generated_numbers = set()
    letters = string.ascii_letters

    while len(generated_numbers) < n:
        id = ''.join(random.choice(letters) for i in range(nb))
        if id not in generated_numbers:
            generated_numbers.add(id)

    return list(generated_numbers)

def PAIMENT():
    data = pd.read_csv("data.csv", header=0)

    liste_finale = []
    for chaine in data[data.columns[1]]:
        repetitions = random.randint(1, 12)
        liste_finale.extend([chaine] * repetitions)
    random.shuffle(liste_finale)

    montant_paiment = []
    while len(montant_paiment) < len(liste_finale):
        values = random.randint(2, 100)
        montant_paiment.append(float(values))

    id_personne = []
    col_cible = data.columns[1]

    for i in liste_finale:
        lignes_trouvees = data[data[col_cible] == i]
        if not lignes_trouvees.empty:
            valeurs = lignes_trouvees['id_personne'].dropna().unique()
            id_personne.extend(valeurs)

    id_methode_paiment = np.random.choice([25, 41, 18], size=len(liste_finale), p=[0.5,0.3,0.2])
    id_paiment = generate_unique_number(n=len(liste_finale), nb=10)

    paiment = pd.DataFrame({
        "id_paiment": id_paiment,
        "montant_paiment": montant_paiment,
        "numero_client": liste_finale,
        "id_personne": id_personne,
        "id_methode_paiment": id_methode_paiment
    })

    paiment.to_csv("Paiment.csv", index=False)



# france : 250, germany : 276, switzerland : 756
def generate_unique_number(n: int, nb=10):
    generated_numbers = set()
    letters = string.ascii_lowercase

    while len(generated_numbers) < n:
        id = ''.join(random.choice(letters) for i in range(nb))
        if id not in generated_numbers:
            generated_numbers.add(id)

    return list(generated_numbers)

def LOCALITE():
    data = pd.read_csv("AMTOVZ_CSV_WGS84.csv", sep=";", header=0)

    new_data = data.iloc[:, 0:2]
    new_data.to_csv("Localite.csv", index=False)


def id_nap(n):
    data = pd.read_csv("Localite.csv", header=0)
    sample = data.sample(n=n)

    return list(sample["PLZ"])


def CLIENT():
    sample = pd.read_csv("Coordonne.csv", header=0)

    coordonne = pd.DataFrame({
        "id_coordonne": list(sample["id_coordonne"]),
        "rue": list(sample["id_npa"]),
        "numero_rue": list(sample["numero_rue"]),
        "complement": list(sample["complement"]),
        "adresse_mail": list(sample["adresse_mail"]),
        "telephone": list(sample["telephone"]),
        "id_pays": list(sample["id_pays"]),
        "id_npa": id_nap(n=len(sample))
    })

    coordonne.to_csv("Coordonne(1).csv", index=False)



"""ABONNEMENT_ACTIF()
ABONNEMENT()
PAIMENT()"""

CLIENT()