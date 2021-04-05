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

def recupDonnee():
    servicePersonnel = []
    try:
        reponse = requests.get("http://{url}/PPE3/Application/server.php/api/liste/services".format(url = url))
        services = reponse.json()
    except:
        erreur = "Données non trouvé"
        return erreur

    try:
        reponse = requests.get("http://{url}/PPE3/Application/server.php/api/liste/personnels".format(url = url))
        personnels = reponse.json()
    except:
        erreur = "Données non trouvé"
        return erreur

    with open("data", "rb") as data:
        donnees_unpickle = pickle.Unpickler(data)
        donnee_enregistre = donnees_unpickle.load()

    for service in services["data"]:
        if donnee_enregistre["idService"] == service["id"]:
            servicePersonnel.append(service)

    servicePersonnel[0]["nomValideur"] = "Aucun"
    servicePersonnel[0]["contactValideur"] = "N/A"

    for personnel in personnels["data"]:
        if servicePersonnel[0]["id"] == personnel["idService"] and personnel["idCategorie"] == 2:
            servicePersonnel[0]["nomValideur"] = personnel["nom"] + " " + personnel["prenom"]
            servicePersonnel[0]["contactValideur"] = personnel["mail"]

    return servicePersonnel


#os.chdir("src")
with open("env.json", "r") as env:
    donnee = json.load(env)
    url = donnee["url"]


if __name__ == "__main__":
    test_recupDonnee = recupDonnee()
    print(test_recupDonnee)
