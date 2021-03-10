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
    id: menu
    anchors.fill: parent
    header: PageHeader {
        id: menuheader
        StyleHints {
            foregroundColor: '#c2c2c2'
            backgroundColor: '#00062e'
            dividerColor: '#00062e'
        }

        leadingActionBar.actions: [
            Action {
                iconName: "back"
                onTriggered: { menuLoader.active = false; root.backgroundColor = "#e9e5dc" }
            }
        ]

        title: i18n.tr('Menu')

        trailingActionBar.actions: [
            Action {
                iconName: "system-log-out"
                onTriggered: { deconnexion.sedeconnecter() }
            },
            Action {
                iconName: "account"
                onTriggered: { print('Test') }
            }
        ]
    }

    ScrollView {
        id: menuscrollView
        anchors.fill: parent

        ListView {
            anchors.top: parent.top
            anchors.topMargin: menuheader.height

            model: Models.MenuModel { }
            delegate: Components.MenuLayout { }
        }
    }

    Python {
        id: deconnexion

        function sedeconnecter() {
            addImportPath(Qt.resolvedUrl('../../src/'));

            importModule('connexion', function () {
                call('connexion.deconnexion', [], function (returnValue) {
                    if (returnValue['deconnecter'] == true) {
                        print(returnValue['erreur'])
                        mainheader.title = i18n.tr("Connexion")
                        pageLoader.source = "Connexion.qml"
                        menuLoader.active = false
                        root.backgroundColor = "#e9e5dc"
                        navigation_menu.visible = false
                        recherche.visible = false
                        ajouter.visible = false
                    }
                })
            });
        }

        onError: {
            console.log('python error: ' + traceback);
        }
    }
}
