import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import QtQuick.Controls.Suru 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.5

Column {
    anchors {
        top: parent.top
        topMargin: mainheader.height + units.gu(15)
    }

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width - units.gu(11)
        height: units.gu(26)
        color: "#dd8500"
        radius: units.gu(2)

        Column {
            anchors {
                top: parent.top
                topMargin: units.gu(3)
                horizontalCenter: parent.horizontalCenter
            }
            spacing: units.gu(2)

            Column {
                id: mail
                anchors.horizontalCenter: parent.horizontalCenter
                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: i18n.tr('Adresse mail')
                }

                TextField {}
            }

            Column {
                id: motdepasse
                anchors.horizontalCenter: parent.horizontalCenter
                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: i18n.tr('Mot de passe')
                }

                TextField {}
            }

            Column {
                id: connexion
                anchors.horizontalCenter: parent.horizontalCenter

                Button {
                    text: "Se connecter"
                    color: "#eae9e7"
                    onClicked: print('Test')
                }
            }
        }
    }
}
