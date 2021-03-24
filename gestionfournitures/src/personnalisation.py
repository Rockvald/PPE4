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
import hashlib

def recupDonnee():
    with open("data", "rb") as data:
        donnees_unpickle = pickle.Unpickler(data)
        donnee_enregistre = donnees_unpickle.load()

    donnee_enregistre["identifiant"] = donnee_enregistre["id"]

    return donnee_enregistre


def modifier(idPersonnel, nom, prenom, mail, mdp, verifMdp):
    donnees = {}
    with open("data", "rb") as data:
        donnees_unpickle = pickle.Unpickler(data)
        donnee_enregistre = donnees_unpickle.load()
    if nom != donnee_enregistre["nom"]:
        donnees["nom"] = nom
    if prenom != donnee_enregistre["prenom"]:
        donnees["prenom"] = prenom
    if mail != donnee_enregistre["mail"]:
        donnees["mail"] = mail

    if mdp != verifMdp:
        erreur = "Les mots de passe sont différents !"
        return erreur

    mdp_fourni = hashlib.sha256(mdp.encode())
    if mdp_fourni.hexdigest() != donnee_enregistre["pass"]:
        donnees["pass"] = mdp

    if donnees == {}:
        message = "Aucune information à modifier."
        return message

    try:
        reponse = requests.put("http://{url}/PPE3/Application/server.php/api/modifier/personnel/{id}".format(url = url, id = idPersonnel), data = json.dumps(donnees))
        message = reponse.json()["message"]
    except:
        erreur = "Un problème est survenue lors de l'envoi des données !"
        return erreur

    try:
        reponse = requests.get("http://{url}/PPE3/Application/server.php/api/personnel".format(url = url), data = json.dumps({"mail": mail}))
        donneePersonnel = reponse.json()
    except:
        erreur = "Un problème est survenue lors de la récupération des données utilisateur !"
        return erreur

    with open("data", "wb") as data:
        donnee = pickle.Pickler(data)
        donnee.dump(donneePersonnel)

    return message


#os.chdir("src")
with open("env.json", "r") as env:
    donnee = json.load(env)
    url = donnee["url"]


if __name__ == "__main__":
    recupDonnee = recupDonnee()
    print(recupDonnee)

    modifier = modifier(1, "Admin", "Admin", "admin@admin.fr", "admin", "admin")
    print(modifier)
