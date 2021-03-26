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

def rechercher(elementArechercher):
    resultat = []
    message = "Résultat trouvé"
    listeFournitures = fournitures.recupDonnee()

    for fourniture in listeFournitures:
        if elementArechercher.lower() in fourniture["nomFournitures"].lower() or elementArechercher.lower() in fourniture["nomFamille"].lower():
            resultat.append(fourniture)

    if resultat == []:
        message = "Aucun résultat trouvé"

    return {"resultat": resultat, "message": message}


#os.chdir("src")
with open("env.json", "r") as env:
    donnee = json.load(env)
    url = donnee["url"]


if __name__ == "__main__":
    rechercher = rechercher("stylo")
    print(rechercher)
