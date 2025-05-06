import pandas as pd
import random, string, spotipy
import numpy as np

from spotipy.oauth2 import SpotifyClientCredentials


client_id = '86ae3de650f04755a3bd6b84457fa3d8'
client_secret = "d0b6a2f4af3946ffba75e0e4980ee906"

client_credential_manager = SpotifyClientCredentials(
    client_id=client_id,
    client_secret=client_secret)

sp = spotipy.Spotify(client_credentials_manager=client_credential_manager)


def generate_unique_number(n: int, nb: int):
    generated_numbers = set()
    letters = string.ascii_letters

    while len(generated_numbers) < n:
        id = ''.join(random.choice(letters) for i in range(nb))
        if id not in generated_numbers:
            generated_numbers.add(id)

    return list(generated_numbers)


def generate_id_number(n: int):
    generated_numbers = set()

    while len(generated_numbers) < n:
        number = int("7" + str(random.randint(10000000, 99999999)))
        if number not in generated_numbers:
            generated_numbers.add(number)

    return list(generated_numbers)

def GENRE():
    datas = pd.read_csv("Produits.csv", header=0)
    df_genres = pd.read_csv("Genre.csv", header=0)
    list_genres_discs = []
    list_ids_discs  = []

    for track_id in datas[datas.columns[0]]:
        try:
            track = sp.album(track_id)
            artist = track['artists'][0]
            artist_id = artist['id']
            artist_info = sp.artist(artist_id)
            list_ids_discs.append(track_id)
            list_genres_discs.append(artist_info['genres'])

        except spotipy.exceptions.SpotifyException:
            list_ids_discs.append(track_id)
            list_genres_discs.append("None")

    dict_genres = dict(zip(df_genres['genre'], df_genres['id_genre']))

    id_produit = []
    id_genre = []

    for disc_id, genres in zip(list_ids_discs, list_genres_discs):
        for genre in genres:
            genre_id = dict_genres.get(str(genre).title())

            if genre_id is not None:
                id_genre.append(genre_id)
                id_produit.append(disc_id)
            else:
                id_genre.append("abcdEF")
                id_produit.append(disc_id)
    
    df_result = pd.DataFrame({
        "id_produit": id_produit,
        "id_genre": id_genre
    })
    df_result.to_csv("Categorie.csv", index=False)

def FORMAT():
    datas = pd.read_csv("Produits.csv", header=0)
    formats = ["DZfnW", "abDXN", "geMpU"]
    prob_formats = [0.1, 0.7, 0.2]

    disponible = pd.DataFrame({
        "id_produit": datas[datas.columns[0]],
        "id_format": np.random.choice(a=formats, size=len(datas[datas.columns[1]]), p=prob_formats)
    })

    disponible.to_csv("Disponible.csv", index=False)

def CHANGEMENT_STOCK(n):
    data = pd.read_csv("Produits.csv", header=0)
    datas = data.sample(n)

    changement = pd.DataFrame({
        "id_stock_changement": generate_unique_number(n=n, nb=8),
        "quantite_changee": np.random.choice(size=n, a=[3, 5, 7, 10, 15], p=[0.3, 0.3, 0.20, 0.12, 0.08]),
        "id_produit": datas[datas.columns[0]]
    })

    changement.to_csv("Changement_stock.csv", index=False)

def CREATION(n, nb=12):
    datas = pd.read_csv("Produits.csv", header=0)
    list_artiste = []

    for albums in datas[datas.columns[1]]:
        track = sp.album(albums)
        list_artiste.append(track['artists'][0]['id'])
    creation = pd.DataFrame({
        "id_produit": datas[datas.columns[1]],
        "id_artiste": list_artiste,
        "id_personne": generate_unique_number(n=n, nb=nb)
    })

    creation.to_csv("Creation.csv", index=False)

def PRODUIT():
    datas = pd.read_csv("Produits.csv", header=0)
    my_list = []
    while len(my_list) < len(datas):
        element = random.choices(population=["dNzrqro", "NcUkSOM", "fKfSWLB"], weights=[0.05, 0.15, 0.8])
        final_elemnent = str(element).replace("['", '').replace("']", '')
        my_list.append(final_elemnent)

    datas["id_type"] = my_list
    datas.to_csv("Produits.csv", index=False)

def search_id(csv, col2, element):
    data = pd.DataFrame(csv)
    
    if isinstance(col2, int):
        nom_colonne_recherche = data.columns[col2]
        nom_colonne_avant = data.columns[col2 - 1]
    else:
        nom_colonne_recherche = col2
        index_colonne_cible = data.columns.get_loc(col2)
        nom_colonne_avant = data.columns[index_colonne_cible - 1]
    
    lignes_trouvees = data[data[nom_colonne_recherche] == element]
    resultats = lignes_trouvees[nom_colonne_avant]
    
    return resultats

def QUANTITE(n):
    datas = pd.read_csv("data.csv", header=0)
    data1 = pd.read_csv("Fournisseurs.csv", header=0)

    id_commande = generer_chaines_aleatoires(n=n)
    id_fournisseur = np.random.choice(a=data1[data1.columns[0]], size=len(id_commande))
    id_produit = np.random.choice(a=datas[datas.columns[0]], size=len(id_commande))
    quantite = np.random.choice(a=[3, 5, 7, 10, 15], size=len(id_commande))
    prix = [round(random.uniform(1500, 3000),2) for _ in range(len(id_commande))]

    quantite = pd.DataFrame({
        "id_commande": id_commande,
        "id_fournisseur":id_fournisseur,
        "id_produit":id_produit,
        "quantite":quantite,
        "prix":prix
    })

    quantite.to_csv("Quantite.csv", index=False)

def generer_chaines_aleatoires(n, longueur=5, min_repetitions=1, max_repetitions=5):
    chaines_uniques = []
    for _ in range(n):
        chaine = ''.join(random.choices(string.ascii_lowercase, k=longueur))
        chaines_uniques.append(chaine)

    liste_finale = []
    for chaine in chaines_uniques:
        repetitions = random.randint(min_repetitions, max_repetitions)
        liste_finale.extend([chaine] * repetitions)

    random.shuffle(liste_finale)
    return liste_finale

def COMMANDE():
    data = pd.read_csv("Quantite.csv", header=0)
    list_livraison = []
    list_commande = []
    list_paiment = []

    while len(list_commande) < len(data):
        a,b,c = generer_dates()
        list_commande.append(a)
        list_livraison.append(b)
        list_paiment.append(c)

    commande = pd.DataFrame({
        "id_commande":data[data.columns[0]],
        "id_fournisseur":data[data.columns[1]],
        "date_commande":list_commande,
        "date_livraison":list_livraison,
        "date_paiment":list_paiment
    })

    commande.to_csv("Commandes.csv", index=False)

def generer_dates():
    from datetime import datetime, timedelta
    today = datetime.today()

    jours_recul = random.randint(0, 80)
    date_commande = today - timedelta(days=jours_recul)

    jours_livraison = random.randint(5, 15)
    date_livraison = date_commande + timedelta(days=jours_livraison)

    jours_paiement = random.randint(1, 10)
    date_paiement = date_livraison + timedelta(days=jours_paiement)

    return date_commande.strftime('%Y-%m-%d'), date_livraison.strftime('%Y-%m-%d'), date_paiement.strftime('%Y-%m-%d')




PRODUIT()
"""CHANGEMENT_STOCK(n=74)
GENRE()
FORMAT()
QUANTITE(n=23)
COMMANDE()"""