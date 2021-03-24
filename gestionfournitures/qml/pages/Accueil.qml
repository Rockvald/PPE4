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
        property var contenu

        model: Models.AccueilModel {}
        delegate: Components.AccueilLayout {}

        Python {
            Component.onCompleted: {
                addImportPath(Qt.resolvedUrl('../../src/'));
                importModule('accueil', function () {
                    call('accueil.donneePersonnel', [], function (returnValue) {
                        accueilListview.contenu = {"message": returnValue["message"]}
                        accueilListview.model.ajouter(accueilListview.contenu)
                    })
                });
            }

            onError: {
                console.log('python error: ' + traceback);
            }
        }
    }
}
