/*
 * Copyright (C) 2021  Mathieu Prot
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * gestionfournitures is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import QtQuick.Controls.Suru 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.5

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'gestionfournitures.mathieu'
    // automaticOrientation: true
    backgroundColor: '#e9e5dc'

    //width: phone ? units.gu(40) : units.gu(100)
    //height: units.gu(75)

    property string elementArechercher

    Page {
        id: page
        anchors.fill: parent

        header: PageHeader {
            id: mainheader
            StyleHints {
                foregroundColor: '#c2c2c2'
                backgroundColor: '#00062e'
                dividerColor: '#00062e'
            }

            leadingActionBar.actions: [
                Action {
                    id: navigation_menu
                    iconName: "navigation-menu"
                    onTriggered: { menuLoader.active = true }
                }
            ]

            title: i18n.tr('Gestion Fournitures')

            trailingActionBar.actions: [
                Action {
                    id: recherche
                    iconName: "find"
                    onTriggered: { PopupUtils.open(fenetreRecherche) }
                }
            ]
        }

        property string message: "Essai"

        Component {
            id: fenetreRecherche
            Dialog {
                id: fenetre
                style: Rectangle {
                    color: "#dd8500"
                    radius: 5
                }
                title: "Recherche"
                TextField {
                    id: rechercheTextfield
                    text: ""
                }
                Button {
                    text: "Rechercher"
                    color: "#eae9e7"
                    onClicked: {
                        root.elementArechercher = rechercheTextfield.text
                        rechercheLoader.active = true
                        PopupUtils.close(fenetre)
                    }
                }
                Button {
                    text: "Fermer"
                    color: "#eae9e7"
                    onClicked: PopupUtils.close(fenetre)
                }
            }
        }

        Component {
            id: fenetreMessage
            Dialog {
                id: fenetre
                style: Rectangle {
                    color: "#dd8500"
                    radius: 5
                }
                Text {
                    id: textMessage
                    horizontalAlignment: Text.AlignHCenter
                    text: page.message
                }
                Button {
                    text: "Valider"
                    color: "#eae9e7"
                    onClicked: PopupUtils.close(fenetre)
                }
            }
        }

        Loader {
            id: pageLoader
            anchors.fill: parent
            source: ""
        }
    }

    Loader {
        id: menuLoader
        anchors.fill: parent
        source: "pages/Menu.qml"
        active: false
    }

    Loader {
        id: rechercheLoader
        anchors.fill: parent
        source: "pages/Recherche.qml"
        active: false
    }

    Python {
        id: verifconnexion

        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('../src/'));

            importModule('connexion', function() {
                verifconnexion.call('connexion.verifconnexion', [], function(returnValue) {
                    if (returnValue['connecter'] == true) {
                        mainheader.title = i18n.tr("Accueil")
                        pageLoader.source = "pages/Accueil.qml"
                    } else {
                        mainheader.title = i18n.tr("Connexion")
                        pageLoader.source = "pages/Connexion.qml"
                        navigation_menu.visible = false
                        recherche.visible = false
                    }
                })
            });
        }

        onError: {
            console.log('python error: ' + traceback);
        }
    }
}
