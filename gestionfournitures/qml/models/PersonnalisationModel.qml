import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import QtQuick.Controls.Suru 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.5

ListModel {
    id: personnalisationModel
    ListElement {
        identifiant: 0
        idCategorie: 0
        idService: 0
        nom: ""
        prenom: ""
        mail: ""
        pass: ""
        message: ""
        created_at: ""
        updated_at: ""
    }

    function ajouter(contenuAajouter) {
        var contenu = contenuAajouter
        personnalisationModel.append(contenu)
        personnalisationModel.remove(0)
    }
}
