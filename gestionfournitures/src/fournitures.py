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
    listeFournitures = []
    try:
        reponse = requests.get("http://{url}/PPE3/Application/server.php/api/liste/fournitures".format(url = url))
        fournitures = reponse.json()
    except:
        erreur = "Données non trouvé"
        return erreur

    for donnee in fournitures["data"]:
        try:
            reponse = requests.get("http://{url}/PPE3/Application/server.php/api/famille/{id}".format(url = url, id = donnee["idFamille"]))
            famille = reponse.json()
        except:
            erreur = "Données non trouvé"
            return erreur

        donnee["nomFamille"] = famille["famille"]["nomFamille"]
        donnee["identifiant"] = donnee["id"]

        listeFournitures.append(donnee)

    return listeFournitures



#os.chdir("src")
with open("env.json", "r") as env:
    donnee = json.load(env)
    url = donnee["url"]


if __name__ == "__main__":
    recupDonnee = recupDonnee()
    print(recupDonnee)
