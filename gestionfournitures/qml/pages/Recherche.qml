import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import QtQuick.Controls.Suru 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.5

import "../components" as Components
import "../models" as Models

Page {
    id: recherchePage
    anchors.fill: parent
    style: Rectangle {
        color: "#e9e5dc"
    }

    header: PageHeader {
        id: rechercheheader
        StyleHints {
            foregroundColor: '#c2c2c2'
            backgroundColor: '#00062e'
            dividerColor: '#00062e'
        }

        leadingActionBar.actions: [
            Action {
                iconName: "back"
                onTriggered: { rechercheLoader.active = false }
            }
        ]

        title: "Résultat de la recherche"
    }

    property string message: "Essai"

    Component {
        id: fenetreMessage
        Dialog {
            id: fenetre
            style: Rectangle {
                color: "#dd8500"
                radius: 5
            }
            Text {
                id: textMessage
                horizontalAlignment: Text.AlignHCenter
                text: recherchePage.message
            }
            Button {
                text: "Valider"
                color: "#eae9e7"
                onClicked: {
                    PopupUtils.close(fenetre)
                    if (textMessage.text == "Aucun résultat trouvé") {
                        rechercheLoader.active = false
                    }
                }
            }
        }
    }

    ScrollView {
        id: pagescrollview
        anchors.fill: parent

        ListView {
            id: rechercheListview
            anchors.top: parent.top
            anchors.topMargin: mainheader.height

            property string url: "localhost"
            property var contenu: []

            model: Models.RechercheModel {}
            delegate: Components.RechercheLayout {}

            Python {
                id: python
                Component.onCompleted: {
                    addImportPath(Qt.resolvedUrl('../../src/'));
                    importModule('connexion', function () {
                        call('connexion.recupUrl', [], function (returnValue) {
                            rechercheListview.url = returnValue
                        })
                    });

                    importModule('recherche', function () {
                        call('recherche.rechercher', [root.elementArechercher], function (returnValue) {
                            if (returnValue["message"] == "Résultat trouvé") {
                                rechercheListview.contenu = returnValue["resultat"]
                                rechercheListview.model.ajouter(rechercheListview.contenu)
                            } else {
                                recherchePage.message = returnValue["message"]
                                PopupUtils.open(fenetreMessage)
                            }
                        })
                    });
                }

                function commander(idFournitures, nomFournitures, quantiteDemande, quantiteDisponible, index) {
                    importModule('commande', function () {
                        call('commande.commander', [idFournitures, nomFournitures, quantiteDemande, quantiteDisponible, index], function (returnValue) {
                            rechercheListview.model.modifier(returnValue["index"], "quantiteDisponible", returnValue["quantiteDisponible"])
                            recherchePage.message = returnValue['message']
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
}
