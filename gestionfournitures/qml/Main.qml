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

    width: phone ? units.gu(40) : units.gu(100)
    height: units.gu(75)

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
                    onTriggered: { menuLoader.active = true; root.backgroundColor = "#002c4a" }
                }
            ]

            title: i18n.tr('Gestion Fournitures')

            trailingActionBar.actions: [
                Action {
                    iconName: "find"
                    onTriggered: { print('Test') }
                },
                Action {
                    iconName: "add"
                    onTriggered: { print('Test') }
                }
            ]
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
        //visible: false
    }
}
