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

        property var contenu

        model: Models.DemandeSpecifiqueModel { }
        delegate: Components.DemandeSpecifiqueLayout { }

        Python {
            id: recupcontenu
            Component.onCompleted: {
                addImportPath(Qt.resolvedUrl('../../src/'));

                importModule('demandespecifique', function () {
                    call('demandespecifique.recupDonnee', [], function (returnValue) {
                        demandeSpecifiqueListview.contenu = returnValue
                        demandeSpecifiqueListview.model.ajouter(demandeSpecifiqueListview.contenu)
                    })
                });
            }
        }
    }
}
