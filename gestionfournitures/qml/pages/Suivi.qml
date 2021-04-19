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
        id: suiviListview
        anchors.top: parent.top
        anchors.topMargin: mainheader.height
        visible: page.element1Visible

        property var contenu
        property bool valideur: false
        property bool admin: false

        model: Models.SuiviModel { }
        delegate: Components.SuiviLayout { }

        Python {
            Component.onCompleted: {
                addImportPath(Qt.resolvedUrl('../../src/'));
                importModule('accueil', function () {
                    call('accueil.donneePersonnel', [], function (returnValue) {
                        if (returnValue["idCategorie"] == 2) {
                            suiviListview.valideur = true
                        }else if (returnValue["idCategorie"] == 3) {
                            suiviListview.admin = true
                        }
                    })
                });
                importModule('suivi', function () {
                    call('suivi.recupDonnee', [], function (returnValue) {
                        if (suiviListview.valideur || suiviListview.admin) {
                            section.visible = true
                            page.titrePage1 = "Commandes personnel"
                            page.titrePage2 = "Commandes utilisateurs"
                            mainheader.extension = section
                            if (returnValue["aucunneDonneeUtilisateur"]) {
                                aucunneDonneeUtilisateurListview.contenu = returnValue["commandesutilisateurs"]
                                aucunneDonneeUtilisateurListview.model.ajouter(aucunneDonneeUtilisateurListview.contenu)
                                page.page2 = "aucunneDonnee"
                            } else {
                                commandeValideListview.contenu = returnValue["commandesutilisateurs"]
                                commandeValideListview.model.ajouter(commandeValideListview.contenu)
                                page.page2 = "demande"
                            }
                        }
                        if (returnValue["aucunneDonnee"]) {
                            aucunneDonneeListview.contenu = returnValue["commandespersonnel"]
                            aucunneDonneeListview.model.ajouter(aucunneDonneeListview.contenu)
                            page.page1 = "aucunneDonnee"
                            page.element2Visible = true
                        } else {
                            suiviListview.contenu = returnValue["commandespersonnel"]
                            suiviListview.model.ajouter(suiviListview.contenu)
                            page.page1 = "demande"
                            page.element1Visible = true
                        }
                    })
                });
            }

            onError: {
                console.log('python error: ' + traceback);
            }
        }
    }

    ListView {
        id: aucunneDonneeListview
        anchors.top: parent.top
        anchors.topMargin: mainheader.height
        visible: page.element2Visible

        property var contenu

        model: Models.AucunneDonneeModel { }
        delegate: Components.AucunneDonneeLayout { }
    }

    ListView {
        id: commandeValideListview
        anchors.top: parent.top
        anchors.topMargin: mainheader.height
        visible: page.element3Visible

        property var contenu

        model: Models.SuiviValideModel { }
        delegate: Components.SuiviValideLayout { }

        Python {
            id: python
            function valider(idCommande, nouveauIdEtat, index) {
                addImportPath(Qt.resolvedUrl('../../src/'));
                importModule('suivi', function () {
                    call('suivi.valider', [idCommande, nouveauIdEtat, index], function (returnValue) {
                        commandeValideListview.model.modifier(returnValue["index"], "idEtat", returnValue["idEtat"])
                        commandeValideListview.model.modifier(returnValue["index"], "nomEtat", returnValue["nomEtat"])
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

    ListView {
        id: aucunneDonneeUtilisateurListview
        anchors.top: parent.top
        anchors.topMargin: mainheader.height
        visible: page.element4Visible

        property var contenu

        model: Models.AucunneDonneeModel { }
        delegate: Components.AucunneDonneeLayout { }
    }
}
