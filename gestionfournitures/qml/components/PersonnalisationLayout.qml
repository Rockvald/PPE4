import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import QtQuick.Controls.Suru 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.5

Column {
    anchors.horizontalCenter: parent.horizontalCenter
    spacing: units.gu(3)
    topPadding: units.gu(5)
    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: units.gu(1)
        Text {
            width: units.gu(30)
            horizontalAlignment: Text.AlignHCenter
            text: "Nom :"
        }
        TextField {
            anchors.horizontalCenter: parent.horizontalCenter
            id: nomTexfield
            text: model.nom
        }
    }
    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: units.gu(1)
        Text {
            width: units.gu(30)
            horizontalAlignment: Text.AlignHCenter
            text: "Prénom :"
        }
        TextField {
            anchors.horizontalCenter: parent.horizontalCenter
            id: prenomTexfield
            text: model.prenom
        }
    }
    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: units.gu(1)
        Text {
            width: units.gu(30)
            horizontalAlignment: Text.AlignHCenter
            text: "Adresse mail :"
        }
        TextField {
            anchors.horizontalCenter: parent.horizontalCenter
            id: mailTexfield
            text: model.mail
        }
    }
    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: units.gu(1)
        Text {
            width: units.gu(30)
            horizontalAlignment: Text.AlignHCenter
            text: "Mot de passe :"
        }
        TextField {
            id: mdpTextfield
            anchors.horizontalCenter: parent.horizontalCenter
            echoMode: TextInput.Password
            text: ""
        }
    }
    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: units.gu(1)
        Text {
            width: units.gu(30)
            horizontalAlignment: Text.AlignHCenter
            text: "Confirmation du mot de passe :"
        }
        TextField {
            id: confirmMdpTextfield
            anchors.horizontalCenter: parent.horizontalCenter
            echoMode: TextInput.Password
            text: ""
        }
    }
    Column {
        id: boutonModifier
        anchors.horizontalCenter: parent.horizontalCenter

        Button {
            text: "Modifier"
            color: "#dd8500"
            onClicked: {
                python.modifier(model.identifiant, nomTexfield.text, prenomTexfield.text, mailTexfield.text, mdpTextfield.text, confirmMdpTextfield.text)
            }
        }
    }
}
