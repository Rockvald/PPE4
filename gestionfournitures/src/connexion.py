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
import pickle
import os
import hashlib

def connexion(mail, mdp):
    # Récupération des information correspondantes dans la base de données
    try:
        reponse = requests.get("http://{url}/PPE3/Application/server.php/api/personnel".format(url = url), data = json.dumps({"mail": mail}))
        donneePersonnel = reponse.json()
        mdp_utilisateur = donneePersonnel["pass"]
    except:
        connecter = False
        erreur = "Le mail est incorrect !"
        return {"connecter": connecter, "erreur": erreur}

    # Hashage du mot de passe pour la vérification
    mdp_fourni = hashlib.sha256(mdp.encode())

    # Vérification des mots de passes
    if mdp_fourni.hexdigest() == mdp_utilisateur:
        # Enregistrement des informations
        with open("data", "wb") as data:
            donnee = pickle.Pickler(data)
            donnee.dump(donneePersonnel)
        connecter = True
        erreur = "Aucune"
        return {"connecter": connecter, "erreur": erreur}
    else:
        connecter = False
        erreur = "Le mot de passe est incorrect !"
        return {"connecter": connecter, "erreur": erreur}

def verifconnexion():
    # Récupération du contenu du fichier avec les données enregistré
    try:
        with open("data", "rb") as data:
            donnees_unpickle = pickle.Unpickler(data)
            donnee_enregistre = donnees_unpickle.load()
    except FileNotFoundError:
        connecter = False
        erreur = "Pas de données enregistré !"
        return {"connecter": connecter, "erreur": erreur}

    # Récupération des données de connexion enregistré
    try:
        mail_enregistre = donnee_enregistre["mail"]
        mdp_enregistre = donnee_enregistre["pass"]
    except KeyError:
        connecter = False
        erreur = "Mauvaise données enregistré !"
        return {"connecter": connecter, "erreur": erreur}

    # Récupération des information correspondantes dans la base de données
    reponse = requests.get("http://{url}/PPE3/Application/server.php/api/personnel".format(url = url), data = json.dumps({"mail": mail_enregistre}))
    donneePersonnel = reponse.json()
    mdp_utilisateur = donneePersonnel["pass"]

    # Vérification des mots de passes
    if mdp_enregistre == mdp_utilisateur:
        with open("data", "wb") as data:
            donnee = pickle.Pickler(data)
            donnee.dump(donneePersonnel)
        connecter = True
        erreur = "Aucune"
        return {"connecter": connecter, "erreur": erreur}
    else:
        os.remove("data")
        connecter = False
        erreur = "Les mots de passe ne correspondes pas !"
        return {"connecter": connecter, "erreur": erreur}


def deconnexion():
    if os.path.isfile("data"):
        os.remove("data")
        deconnecter = True
        erreur = "Aucune"
        return {"deconnecter": deconnecter, "erreur": erreur}
    else:
        deconnecter = False
        erreur = "Le fichier n'éxiste pas ou est un dossier"
        return {"deconnecter": deconnecter, "erreur": erreur}


os.chdir("src")
with open("env.json", "r") as env:
    donnee = json.load(env)
    url = donnee["url"]


if __name__ == "__main__":
    test_connexion = connexion("admin@admin.fr", "admin")
    print(test_connexion["connecter"], ", ", test_connexion["erreur"])

    test_verifconnexion = verifconnexion()
    print(test_verifconnexion["connecter"], ", ", test_verifconnexion["erreur"])

    test_deconnexion = deconnexion()
    print(test_deconnexion["deconnecter"], ", ", test_deconnexion["erreur"])
