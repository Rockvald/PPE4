import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import QtQuick.Controls.Suru 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.5

ListItem {
    divider.visible: false
    height: units.gu(5)
    highlightColor: "#dd8500"

    ListItemLayout {
        anchors.fill: parent
        title.text: model.nomFournitures
        title.color: "#000000"
    }

    onClicked: {
        PopupUtils.open(details)
    }

    Component {
        id: details
        Dialog {
            id: fenetre
            style: Rectangle {
                color: "#dd8500"
                radius: 5
            }

            title: model.nomFournitures

            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: units.gu(3)
                Column {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: units.gu(1)
                    Image {
                        source: "http://" + rechercheListview.url + "/PPE3/Application/storage/app/public/" + model.nomPhoto + ".jpg"
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

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: units.gu(3)
                    Button {
                        text: "Commander"
                        color: "#cdcdcd"
                        onClicked: {
                            python.commander(model.identifiant, model.nomFournitures, quantiteDemande.value, model.quantiteDisponible, index)
                            PopupUtils.close(fenetre)
                        }
                    }
                    Button {
                        text: "Fermer"
                        color: "#cdcdcd"
                        onClicked: PopupUtils.close(fenetre)
                    }
                }
            }
        }
    }
}
