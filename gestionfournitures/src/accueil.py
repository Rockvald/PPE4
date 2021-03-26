'''
 Copyright (C) 2021  Mathieu Prot

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; version 3.

 gestionfournitures is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
'''

import requests
import json
import os
import pickle
import fournitures
from random import randint

def donneePersonnel():
    with open("data", "rb") as data:
        donnees_unpickle = pickle.Unpickler(data)
        donnee_enregistre = donnees_unpickle.load()

    try:
        reponse = requests.get("http://{url}/PPE3/Application/server.php/api/service/{id}".format(url = url, id = donnee_enregistre["idService"]))
        service = reponse.json()
    except:
        erreur = "Service non trouvé"
        return erreur

    try:
        reponse = requests.get("http://{url}/PPE3/Application/server.php/api/categorie/{id}".format(url = url, id = donnee_enregistre["idCategorie"]))
        categorie = reponse.json()
    except:
        erreur = "Catégorie non trouvé"
        return erreur

    donnee_enregistre["nomService"] = service["service"]["nomService"]
    donnee_enregistre["nomCategorie"] = categorie["categorie"]["nomCategorie"]

    return donnee_enregistre


def recupDonnee():
    donnee = []
    donnee_personnel = donneePersonnel()
    listeFournitures = fournitures.recupDonnee()

    generer = False
    while generer == False:
        index = randint(0, len(listeFournitures)-1)
        if listeFournitures[index]["quantiteDisponible"] > 0:
            listeFournitures[index]["nom"] = donnee_personnel["nom"]
            listeFournitures[index]["prenom"] = donnee_personnel["prenom"]
            listeFournitures[index]["message"] = donnee_personnel["message"]
            donnee.append(listeFournitures[index])
            generer = True

    return donnee


#os.chdir("src")
with open("env.json", "r") as env:
    donnee = json.load(env)
    url = donnee["url"]


if __name__ == "__main__":
    donnee_Personnel = donneePersonnel()
    print(donnee_Personnel)

    recupDonnee = recupDonnee()
    print(recupDonnee)
