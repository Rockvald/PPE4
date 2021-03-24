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
    commandespersonnel = []
    aucunneDonnee = False
    try:
        reponse = requests.get("http://{url}/PPE3/Application/server.php/api/liste/commandes".format(url = url))
        commandes = reponse.json()
    except:
        erreur = "Données non trouvé"
        aucunneDonnee = True
        return {"erreur": erreur, "aucunneDonnee": aucunneDonnee}

    for donnee in commandes["data"]:
        try:
            reponse = requests.get("http://{url}/PPE3/Application/server.php/api/etat/{id}".format(url = url, id = donnee["idEtat"]))
            etat = reponse.json()
        except:
            erreur = "Données non trouvé"
            return erreur

        donnee["nomEtat"] = etat["etat"]["nomEtat"]
        donnee["identifiant"] = donnee["id"]

        with open("data", "rb") as data:
            donnees_unpickle = pickle.Unpickler(data)
            donnee_enregistre = donnees_unpickle.load()

        if donnee_enregistre["id"] == donnee["idPersonnel"]:
            commandespersonnel.append(donnee)

    if commandespersonnel == []:
        aucunneDonnee = True
        commandespersonnel.append({"titre": "Commandes :", "description": "Vous n'avez pas encore effectué de commandes."})

    return {"commandespersonnel": commandespersonnel, "aucunneDonnee": aucunneDonnee}


#os.chdir("src")
with open("env.json", "r") as env:
    donnee = json.load(env)
    url = donnee["url"]


if __name__ == "__main__":
    recupDonnee = recupDonnee()
    print(recupDonnee)