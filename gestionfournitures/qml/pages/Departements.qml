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
        id: departementsListview
        anchors.top: parent.top
        anchors.topMargin: mainheader.height

        property var contenu

        model: Models.DepartementsModel { }
        delegate: Components.DepartementsLayout { }

        Python {
            id: recupcontenu
            Component.onCompleted: {
                addImportPath(Qt.resolvedUrl('../../src/'));

                importModule('departements', function () {
                    call('departements.recupDonnee', [], function (returnValue) {
                        departementsListview.contenu = returnValue
                        departementsListview.model.ajouter(departementsListview.contenu)
                    })
                });
            }
        }
    }
}
