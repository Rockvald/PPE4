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
    style: Rectangle {
        color: "#002239"
    }

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
                onTriggered: { menuLoader.active = false }
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
            anchors.bottom: parent.bottom

            model: Models.MenuModel {}
            delegate: Components.MenuLayout {}
        }
    }

    Rectangle {
        id: footer
        anchors.bottom: parent.bottom
        width: parent.width
        height: units.gu(5)
        color: '#00062e'
        property var donneePersonnel: []
        Row {
            anchors.centerIn: parent
            spacing: 25
            Text {
                id: service
                text: "Service : " + footer.donneePersonnel["nomService"]
                color: "#c2c2c2"
            }
            Text {
                text: "Statut : " + footer.donneePersonnel["nomCategorie"]
                color: "#c2c2c2"
            }

            Python {
                id: recupdonneepersonnel
                Component.onCompleted: {
                    addImportPath(Qt.resolvedUrl('../../src/'));
                    importModule('accueil', function () {
                        call('accueil.donneePersonnel', [], function (returnValue) {
                            footer.donneePersonnel = returnValue
                        })
                    });
                }
            }
        }
    }


    Python {
        id: deconnexion

        function sedeconnecter() {
            addImportPath(Qt.resolvedUrl('../../src/'));

            importModule('connexion', function () {
                call('connexion.deconnexion', [], function (returnValue) {
                    if (returnValue['deconnecter'] == true) {
                        mainheader.title = i18n.tr("Connexion")
                        pageLoader.source = "Connexion.qml"
                        menuLoader.active = false
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
