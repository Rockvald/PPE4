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
        visible: true

        property var contenu

        model: Models.SuiviModel { }
        delegate: Components.SuiviLayout { }

        Python {
            Component.onCompleted: {
                addImportPath(Qt.resolvedUrl('../../src/'));
                importModule('suivi', function () {
                    call('suivi.recupDonnee', [], function (returnValue) {
                        if (returnValue["aucunneDonnee"]) {
                            suiviListview.visible = false
                            aucunneDonneeListview.visible = true
                            aucunneDonneeListview.contenu = returnValue["commandespersonnel"]
                            aucunneDonneeListview.model.ajouter(aucunneDonneeListview.contenu)
                        } else {
                            suiviListview.contenu = returnValue["commandespersonnel"]
                            suiviListview.model.ajouter(suiviListview.contenu)
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
        visible: false

        property var contenu

        model: Models.AucunneDonneeModel { }
        delegate: Components.AucunneDonneeLayout { }
    }
}
