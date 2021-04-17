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
        id: demandeSpecifiqueListview
        anchors.top: parent.top
        anchors.topMargin: mainheader.height
        visible: page.element1Visible

        property var contenu
        property bool valideur: false

        model: Models.DemandeSpecifiqueModel { }
        delegate: Components.DemandeSpecifiqueLayout { }

        Python {
            Component.onCompleted: {
                addImportPath(Qt.resolvedUrl('../../src/'));
                importModule('accueil', function () {
                    call('accueil.donneePersonnel', [], function (returnValue) {
                        if (returnValue["idCategorie"] == 2) {
                            demandeSpecifiqueListview.valideur = true
                        }
                    })
                });
                importModule('demandespecifique', function () {
                    call('demandespecifique.recupDonnee', [], function (returnValue) {
                        if (demandeSpecifiqueListview.valideur) {
                            section.visible = true
                            page.titrePage1 = "Demandes personnel"
                            page.titrePage2 = "Demandes utilisateurs"
                            mainheader.extension = section
                            if (returnValue["aucunneDonneeUtilisateur"]) {
                                aucunneDonneeUtilisateurListview.contenu = returnValue["demandesutilisateurs"]
                                aucunneDonneeUtilisateurListview.model.ajouter(aucunneDonneeUtilisateurListview.contenu)
                                page.page2 = "aucunneDonnee"
                            } else {
                                demandeValideListview.contenu = returnValue["demandesutilisateurs"]
                                demandeValideListview.model.ajouter(demandeValideListview.contenu)
                                page.page2 = "demande"
                            }
                        }
                        if (returnValue["aucunneDonnee"]) {
                            aucunneDonneeListview.contenu = returnValue["demandespersonnel"]
                            aucunneDonneeListview.model.ajouter(aucunneDonneeListview.contenu)
                            page.page1 = "aucunneDonnee"
                            page.element2Visible = true
                        } else {
                            demandeSpecifiqueListview.contenu = returnValue["demandespersonnel"]
                            demandeSpecifiqueListview.model.ajouter(demandeSpecifiqueListview.contenu)
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
        id: demandeValideListview
        anchors.top: parent.top
        anchors.topMargin: mainheader.height
        visible: page.element3Visible

        property var contenu

        model: Models.DemandeValideModel { }
        delegate: Components.DemandeValideLayout { }

        Python {
            id: python
            function valider(idDemande, index) {
                addImportPath(Qt.resolvedUrl('../../src/'));
                importModule('demandespecifique', function () {
                    call('demandespecifique.valider', [idDemande, index], function (returnValue) {
                        demandeValideListview.model.modifier(returnValue["index"], "idEtat", returnValue["idEtat"])
                        demandeValideListview.model.modifier(returnValue["index"], "nomEtat", returnValue["nomEtat"])
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
