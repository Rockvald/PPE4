import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import QtQuick.Controls.Suru 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.5

ListModel {
    id: demandeSpecifiqueModel
    ListElement {
        identifiant: 0
        idEtat: 0
        nomEtat: ""
        idPersonnel: 0
        nomDemande: ""
        quantiteDemande: 0
        lienProduit: ""
        created_at: ""
        updated_at: ""
    }

    function ajouter(contenuAajouter) {
        var contenu = contenuAajouter
        demandeSpecifiqueModel.append(contenu)
        demandeSpecifiqueModel.remove(0)
    }
}
