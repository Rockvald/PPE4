import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import QtQuick.Controls.Suru 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.5

Column {
    anchors.horizontalCenter: parent.horizontalCenter
    width: parent.width
    spacing: units.gu(5)
    topPadding: units.gu(5)
    bottomPadding: units.gu(5)
    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#dd8500"
        radius: units.gu(1)
        Text {
            id: textMessage
            width: units.gu(30)
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
            text: model.message
        }
        width: units.gu(33)
        height: textMessage.height
    }
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Bonjour " + model.nom + " " + model.prenom
    }
    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: units.gu(3)
        Text {
            width: units.gu(30)
            horizontalAlignment: Text.AlignHCenter
            text: "Fourniture à l'honneur :"
        }
        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: units.gu(3)
            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: units.gu(1)
                Image {
                    source: "http://" + accueilListview.url + "/PPE3/Application/storage/app/public/" + model.nomPhoto + ".jpg"
                    width: units.gu(17)
                    height: units.gu(17)
                }
            }
            Column {
                spacing: units.gu(1)
                Text {
                    width: units.gu(30)
                    horizontalAlignment: Text.AlignHCenter
                    text: "Description :"
                }
                Text {
                    width: units.gu(30)
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.Wrap
                    text: model.descriptionFournitures
                }
            }
            Column {
                spacing: units.gu(1)
                Text {
                    width: units.gu(30)
                    horizontalAlignment: Text.AlignHCenter
                    text: "Famille :"
                }
                Text {
                    width: units.gu(30)
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.Wrap
                    text: model.nomFamille
                }
            }
            Column {
                spacing: units.gu(1)
                Text {
                    width: units.gu(30)
                    horizontalAlignment: Text.AlignHCenter
                    text: "Quantitée disponible :"
                }
                Text {
                    width: units.gu(30)
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.Wrap
                    text: model.quantiteDisponible
                }
            }
            Column {
                spacing: units.gu(1)
                Text {
                    width: units.gu(30)
                    horizontalAlignment: Text.AlignHCenter
                    text: "Quantitée demandée :"
                }
                Slider {
                    id: quantiteDemande
                    width: parent.width
                    live: true
                    minimumValue: 1
                    maximumValue: model.quantiteDisponible
                    value: 1
                    stepSize: 1
                }
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Commander"
                color: "#cdcdcd"
                onClicked: {
                    python.commander(model.identifiant, model.nomFournitures, quantiteDemande.value, model.quantiteDisponible, index)
                }
            }
        }
    }
}
