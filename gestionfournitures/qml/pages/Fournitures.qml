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
    id: pagescrollview
    anchors.fill: parent

    ListView {
        id: fournituresListview
        anchors.top: parent.top
        anchors.topMargin: mainheader.height

        property string url: "localhost"
        property var contenu: []

        model: Models.FournituresModel {}
        delegate: Components.FournituresLayout {}

        Python {
            id: python
            Component.onCompleted: {
                addImportPath(Qt.resolvedUrl('../../src/'));
                importModule('connexion', function () {
                    call('connexion.recupUrl', [], function (returnValue) {
                        fournituresListview.url = returnValue
                    })
                });

                importModule('fournitures', function () {
                    call('fournitures.recupDonnee', [], function (returnValue) {
                        fournituresListview.contenu = returnValue
                        fournituresListview.model.ajouter(fournituresListview.contenu)
                    })
                });
            }

            function commander(idFournitures, nomFournitures, quantiteDemande, quantiteDisponible, index) {
                importModule('commande', function () {
                    call('commande.commander', [idFournitures, nomFournitures, quantiteDemande, quantiteDisponible, index], function (returnValue) {
                        fournituresListview.model.modifier(returnValue["index"], "quantiteDisponible", returnValue["quantiteDisponible"])
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
