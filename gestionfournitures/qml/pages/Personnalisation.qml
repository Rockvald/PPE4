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
        id: personnalisationListview
        anchors.top: parent.top
        anchors.topMargin: mainheader.height

        property var contenu

        model: Models.PersonnalisationModel { }
        delegate: Components.PersonnalisationLayout { }

        Python {
            id: python
            Component.onCompleted: {
                addImportPath(Qt.resolvedUrl('../../src/'));
                importModule('personnalisation', function () {
                    call('personnalisation.recupDonnee', [], function (returnValue) {
                        personnalisationListview.contenu = returnValue
                        personnalisationListview.model.ajouter(personnalisationListview.contenu)
                    })
                });
            }

            function modifier(idPersonnel, nom, prenom, mail, mdp, verifPass) {
                importModule('personnalisation', function () {
                    call('personnalisation.modifier', [idPersonnel, nom, prenom, mail, mdp, verifPass], function (returnValue) {
                        page.message = returnValue
                        PopupUtils.open(fenetreMessage)
                    })
                    if (page.message != "Aucune information à modifier.") {
                        call('personnalisation.recupDonnee', [], function (returnValue) {
                            personnalisationListview.contenu = returnValue
                            personnalisationListview.model.ajouter(personnalisationListview.contenu)
                        })
                    }
                });
            }

            onError: {
                console.log('python error: ' + traceback);
            }
        }
    }
}
