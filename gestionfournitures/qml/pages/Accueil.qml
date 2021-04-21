import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import QtQuick.Controls.Suru 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.5

import "../components" as Components
import "../models" as Models

ScrollView {
    anchors.fill: parent

    ListView {
        id: accueilListview
        anchors.top: parent.top
        anchors.topMargin: mainheader.height

        property string url: "localhost"
        property var contenu

        model: Models.AccueilModel {}
        delegate: Components.AccueilLayout {}

        Python {
            id: python
            Component.onCompleted: {
                addImportPath(Qt.resolvedUrl('../../src/'));

                importModule('connexion', function () {
                    call('connexion.recupUrl', [], function (returnValue) {
                        accueilListview.url = returnValue
                    })
                });

                importModule('accueil', function () {
                    call('accueil.recupDonnee', [], function (returnValue) {
                        accueilListview.contenu = returnValue
                        accueilListview.model.ajouter(accueilListview.contenu)
                    })
                });
            }

            function commander(idFournitures, nomFournitures, quantiteDemande, quantiteDisponible, index) {
                importModule('commande', function () {
                    call('commande.commander', [idFournitures, nomFournitures, quantiteDemande, quantiteDisponible, index], function (returnValue) {
                        accueilListview.model.modifier(returnValue["index"], "quantiteDisponible", returnValue["quantiteDisponible"])
                        page.message = returnValue['message']
                        PopupUtils.open(fenetreMessage)
                    })
                });
            }

            onError: {
                console.log('python error: ' + traceback);
            }
        }
    }
}
