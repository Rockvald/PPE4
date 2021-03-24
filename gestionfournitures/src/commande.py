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

def commander(idFournitures, nomFournitures, quantiteDemande, quantiteDisponible, index):
    with open("data", "rb") as data:
        donnees_unpickle = pickle.Unpickler(data)
        donnee_enregistre = donnees_unpickle.load()

    try:
        reponse = requests.post("http://{url}/PPE3/Application/server.php/api/creer/commande".format(url = url), data = json.dumps({
            "nomCommandes": nomFournitures,
            "quantiteDemande": quantiteDemande,
            "idFournitures": idFournitures,
            "idPersonnel": donnee_enregistre["id"]
        }))
        message = reponse.json()["message"]
    except:
        message = "La commande à échouer !"
        quantiteDisponible = quantiteDisponible
        return {"message": message, "quantiteDisponible": quantiteDisponible, "index": index}

    try:
        reponse = requests.put("http://{url}/PPE3/Application/server.php/api/modifier/fourniture/{id}".format(url = url, id = idFournitures), data = json.dumps({ "quantiteDisponible": quantiteDisponible - quantiteDemande }))
    except:
        message = "La mise à jour de la quantitée à échouer !"
        quantiteDisponible = quantiteDisponible
        return {"message": message, "quantiteDisponible": quantiteDisponible, "index": index}

    try:
        reponse = requests.get("http://{url}/PPE3/Application/server.php/api/fourniture/{id}".format(url = url, id = idFournitures))
        quantiteDisponible = reponse.json()["fourniture"]["quantiteDisponible"]
    except:
        erreur = "Données non trouvé"
        return {"message": message, "quantiteDisponible": quantiteDisponible, "index": index}

    return {"message": message, "quantiteDisponible": quantiteDisponible, "index": index}


#os.chdir("src")
with open("env.json", "r") as env:
    donnee = json.load(env)
    url = donnee["url"]


if __name__ == "__main__":
    commander = commander(2, "Stylo bic cristal vert", 3, 9, 3)
    print(commander)
