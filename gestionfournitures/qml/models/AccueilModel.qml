import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import QtQuick.Controls.Suru 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.5

ListModel {
    id: accueilModel
    ListElement {
        message: ""
        nom: ""
        description: ""
        quantiteDisponible: ""
    }

    function ajouter(contenuAajouter) {
        var contenu = contenuAajouter
        accueilModel.append(contenu)
    }
}
