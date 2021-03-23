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
        visible: true

        property var contenu

        model: Models.DemandeSpecifiqueModel { }
        delegate: Components.DemandeSpecifiqueLayout { }

        Python {
            id: recupcontenu
            Component.onCompleted: {
                addImportPath(Qt.resolvedUrl('../../src/'));

                importModule('demandespecifique', function () {
                    call('demandespecifique.recupDonnee', [], function (returnValue) {
                        if (returnValue["aucunneDonnee"]) {
                            demandeSpecifiqueListview.visible = false
                            aucunneDonneeListview.visible = true
                            aucunneDonneeListview.contenu = returnValue["demandespersonnel"]
                            aucunneDonneeListview.model.ajouter(aucunneDonneeListview.contenu)
                        } else {
                            demandeSpecifiqueListview.contenu = returnValue["demandespersonnel"]
                            demandeSpecifiqueListview.model.ajouter(demandeSpecifiqueListview.contenu)
                        }
                    })
                });
            }
        }
    }

    ListView {
        id: aucunneDonneeListview
        anchors.top: parent.top
        anchors.topMargin: mainheader.height
        visible: false

        property var contenu

        model: Models.AucunneDonneeModel { }
        delegate: Components.AucunneDonneeLayout { }
    }
}
