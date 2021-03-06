import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import QtQuick.Controls.Suru 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.5

ListModel {
    ListElement {
        nom: "Accueil"
        url: "../pages/Accueil.qml"
    }
    ListElement {
        nom: "Départements"
        url: "../pages/Departements.qml"
    }
    ListElement {
        nom: "Fournitures"
        url: "../pages/Fournitures.qml"
    }
    ListElement {
        nom: "Demande spécifique"
        url: "../pages/DemandeSpecifique.qml"
    }
    ListElement {
        nom: "Suivi"
        url: "../pages/Suivi.qml"
    }
    ListElement {
        nom: "Personnalisation"
        url: "../pages/Personnalisation.qml"
    }
}
