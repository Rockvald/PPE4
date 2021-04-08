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
import datetime

def recupDonnee():
    commandespersonnel = []
    commandesutilisateurs = []
    aucunneDonnee = False
    aucunneDonneeUtilisateur = False
    try:
        reponse = requests.get("http://{url}/PPE3/Application/server.php/api/liste/commandes".format(url = url))
        commandes = reponse.json()
    except:
        erreur = "Données non trouvé"
        aucunneDonnee = True
        return {"erreur": erreur, "aucunneDonnee": aucunneDonnee}

    try:
        reponse = requests.get("http://{url}/PPE3/Application/server.php/api/liste/personnels".format(url = url))
        personnels = reponse.json()
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
        # Modification des dates pour les rendre lisible
        donnee["created_at"] = datetime.datetime(int(donnee["created_at"][0:4]), int(donnee["created_at"][5:7]), int(donnee["created_at"][8:10]), int(donnee["created_at"][11:13]), int(donnee["created_at"][14:16]), int(donnee["created_at"][17:19])).strftime("%H:%M:%S le %d-%m-%Y")
        donnee["updated_at"] = datetime.datetime(int(donnee["updated_at"][0:4]), int(donnee["updated_at"][5:7]), int(donnee["updated_at"][8:10]), int(donnee["updated_at"][11:13]), int(donnee["updated_at"][14:16]), int(donnee["updated_at"][17:19])).strftime("%H:%M:%S le %d-%m-%Y")

        with open("data", "rb") as data:
            donnees_unpickle = pickle.Unpickler(data)
            donnee_enregistre = donnees_unpickle.load()

        if donnee_enregistre["idCategorie"] == 2:
            for personnel in personnels["data"]:
                if donnee_enregistre["idService"] == personnel["idService"] and personnel["id"] == donnee["idPersonnel"]:
                    donnee["nom"] = personnel["nom"]
                    donnee["prenom"] = personnel["prenom"]
                    commandesutilisateurs.append(donnee)
        if donnee_enregistre["id"] == donnee["idPersonnel"]:
            commandespersonnel.append(donnee)

    if commandespersonnel == []:
        aucunneDonnee = True
        commandespersonnel.append({"titre": "Commandes :", "description": "Vous n'avez pas encore effectué de commandes."})

    if commandesutilisateurs == []:
        aucunneDonneeUtilisateur = True
        commandesutilisateurs.append({"titre": "Commandes utilisateurs :", "description": "Vous n'avez pas de commandes d'utilisateurs."})

    return {"commandespersonnel": commandespersonnel, "commandesutilisateurs": commandesutilisateurs, "aucunneDonnee": aucunneDonnee, "aucunneDonneeUtilisateur": aucunneDonneeUtilisateur}


#os.chdir("src")
with open("env.json", "r") as env:
    donnee = json.load(env)
    url = donnee["url"]


if __name__ == "__main__":
    test_recupDonnee = recupDonnee()
    print(test_recupDonnee)
