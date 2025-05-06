import pandas as pd
import spotipy
from spotipy.oauth2 import SpotifyClientCredentials
import random


client_id = '86ae3de650f04755a3bd6b84457fa3d8'
client_secret = "d0b6a2f4af3946ffba75e0e4980ee906"

client_credential_manager = SpotifyClientCredentials(
    client_id=client_id,
    client_secret=client_secret)

sp = spotipy.Spotify(client_credentials_manager=client_credential_manager)


def generate_id_number(n: int):
    data1 = pd.read_csv("Client.csv", header=0)
    generated_numbers = set()

    while len(generated_numbers) < n:
        number = int("4" + str(random.randint(10000, 99999)))
        if number not in generated_numbers and number not in data1[data1.columns[1]]:
            generated_numbers.add(int(number))

    return list(generated_numbers)

def ARTISTE():
    data = pd.read_csv("Produits.csv",  header=0)
    nom_artiste = []
    id_de_artiste = []

    for album_id in data[data.columns[0]]:
        album = sp.album(album_id)
        artist_name = album['artists'][0]['name']
        artiste_id = album['artists'][0]['id']
        nom_artiste.append(artist_name)
        id_de_artiste.append(artiste_id)

    id_personne = generate_id_number(n=len(nom_artiste))

    artiste = pd.DataFrame({
        "id_artiste": id_de_artiste,
        "id_personne": id_personne,
        "nom_artiste": nom_artiste
    })

    artiste.to_csv("Artiste.csv", index=False)

def CREATION():
    data = pd.read_csv("Artiste.csv", header=0)
    data1 = pd.read_csv("Produits.csv", header=0)

    creation = pd.DataFrame({
        "id_artiste": data[data.columns[0]],
        "id_personne": data[data.columns[1]],
        "id_produit": data1[data1.columns[0]]
    })

    creation.to_csv("Creation.csv", index=False)

def search_id_2(csv, element_list):
    import re
    data = pd.read_csv(csv, header=0)

    col_0 = data.columns[0]
    col_1 = data.columns[1]

    pattern = '|'.join(re.escape(el) for el in element_list)
    lignes_trouvees = data[data[col_1].str.contains(pattern, case=False, na=False)]

    if lignes_trouvees.empty:
        return "None"

    resultats = lignes_trouvees[col_0].unique().tolist()
    return resultats

def search_id(csv, col_index, element):
    data = pd.read_csv(csv, header=0)

    lignes_trouvees = data[data.iloc[:, col_index] == element]
    nom_colonne_avant = data.columns[0]

    if lignes_trouvees.empty:
        return 0
    
    resultat = lignes_trouvees.iloc[0][nom_colonne_avant]
    return resultat

def ACTIVITE():
    data = pd.read_csv("Artiste.csv", header=0)

    genres = []
    for id in data[data.columns[0]]:
        artiste = sp.artist(id)
        genre = artiste['genres']
        genres.append(genre)

    id_type_artiste = []
    for id in genres:
        element = search_id_2("Type_artiste.csv", id)
        id_type_artiste.append(element)

    activite = pd.DataFrame({
        "id_artiste": data[data.columns[0]],
        "id_personne": data[data.columns[1]],
        "id_type_artiste": id_type_artiste
    })

    activite.to_csv("Activite.csv", index=False)


def NATIONALITE():
    import musicbrainzngs
    artiste = pd.read_csv("Artiste.csv")

    list_country = []
    for i in artiste[artiste.columns[2]]:
        musicbrainzngs.set_useragent("MonApp", "1.0", "comite.frimouss@gmail.com")
        result = musicbrainzngs.search_artists(artist=i, limit=1)

        if result['artist-list']:
            artist_info = result['artist-list'][0]
            country = artist_info.get('country', 'Inconnu')
            list_country.append(country)

    id_country = []
    for country in list_country:
        element = search_id("Pays.csv", 1, str(country).lower())
        id_country.append(element)

    data = pd.DataFrame({
        "id_pays": id_country,
        "id_artiste": artiste[artiste.columns[0]],
        "id_personne": artiste[artiste.columns[1]]
    })

    data.to_csv("Nationalite.csv", index=False)


"""ARTISTE()
CREATION()
ACTIVITE()
NATIONALITE()"""
import string
def generate_unique_number(n: int, nb=5):
    generated_numbers = set()
    letters = string.ascii_lowercase

    while len(generated_numbers) < n:
        id = ''.join(random.choice(letters) for i in range(nb))
        if id not in generated_numbers:
            generated_numbers.add(id)

    return list(generated_numbers)

data = pd.read_csv("Commandes.csv", header=0)

data["id_commande"] = generate_unique_number(n=len(data))
data.to_csv("Commandes.csv", index=False)