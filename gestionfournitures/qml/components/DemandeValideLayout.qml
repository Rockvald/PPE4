import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import QtQuick.Controls.Suru 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.5

ListItem {
    divider.visible: false
    height: units.gu(6)
    highlightColor: "#dd8500"

    ListItemLayout {
        anchors.fill: parent
        title.text: model.nomDemande
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

            title: model.nomDemande

            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: units.gu(3)
                Column {
                    spacing: units.gu(1)
                    Text {
                        width: units.gu(30)
                        horizontalAlignment: Text.AlignHCenter
                        text: "Demandeur :"
                    }
                    Text {
                        width: units.gu(30)
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.Wrap
                        text: model.nom + " " + model.prenom
                    }
                }
                Column {
                    spacing: units.gu(1)
                    Text {
                        width: units.gu(30)
                        horizontalAlignment: Text.AlignHCenter
                        text: "Quantitée demandée :"
                    }
                    Text {
                        width: units.gu(30)
                        horizontalAlignment: Text.AlignHCenter
                        text: model.quantiteDemande
                    }
                }
                Column {
                    spacing: units.gu(1)
                    Text {
                        width: units.gu(30)
                        horizontalAlignment: Text.AlignHCenter
                        text: "Lien du produit :"
                    }
                    Text {
                        width: units.gu(30)
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.Wrap
                        textFormat: Text.RichText
                        text: {
                            if (model.lienProduit == "Aucun lien fourni") {
                                return model.lienProduit;
                            } else {
                                return "<a href=" + model.lienProduit + ">" + model.lienProduit + "</a>";
                            }
                        }
                        onLinkActivated: Qt.openUrlExternally(model.lienProduit)
                    }
                }
                Column {
                    spacing: units.gu(1)
                    Text {
                        width: units.gu(30)
                        horizontalAlignment: Text.AlignHCenter
                        text: "État :"
                    }
                    Text {
                        width: units.gu(30)
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.Wrap
                        text: model.nomEtat
                    }
                }
                Column {
                    spacing: units.gu(1)
                    Text {
                        width: units.gu(30)
                        horizontalAlignment: Text.AlignHCenter
                        text: "Création :"
                    }
                    Text {
                        width: units.gu(30)
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.Wrap
                        text: model.created_at
                    }
                }
                Column {
                    spacing: units.gu(1)
                    Text {
                        width: units.gu(30)
                        horizontalAlignment: Text.AlignHCenter
                        text: "Dernière mise à jour :"
                    }
                    Text {
                        width: units.gu(30)
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.Wrap
                        text: model.updated_at
                    }
                }

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: units.gu(3)
                    Button {
                        text: "Valider"
                        color: "#cdcdcd"
                        onClicked: {
                            python.valider(model.identifiant, 2, index)
                            PopupUtils.close(fenetre)
                        }
                        visible: {
                            if (model.nomEtat == "Prise en compte" && demandeSpecifiqueListview.valideur) {
                                return true;
                            } else {
                                return false;
                            }
                        }
                    }

                    Button {
                        text: "En cours"
                        color: "#cdcdcd"
                        onClicked: {
                            python.valider(model.identifiant, 3, index)
                            PopupUtils.close(fenetre)
                        }
                        visible: {
                            if (model.nomEtat == "Validé" && demandeSpecifiqueListview.admin) {
                                return true;
                            } else {
                                return false;
                            }
                        }
                    }

                    Button {
                        text: "Livré"
                        color: "#cdcdcd"
                        onClicked: {
                            python.valider(model.identifiant, 4, index)
                            PopupUtils.close(fenetre)
                        }
                        visible: {
                            if (model.nomEtat == "En cours" && demandeSpecifiqueListview.admin) {
                                return true;
                            } else {
                                return false;
                            }
                        }
                    }

                    Button {
                        text: "Annulé"
                        color: "#cdcdcd"
                        onClicked: {
                            python.valider(model.identifiant, 5, index)
                            PopupUtils.close(fenetre)
                        }
                        visible: {
                            if (model.nomEtat == "En cours" && demandeSpecifiqueListview.admin) {
                                return true;
                            } else {
                                return false;
                            }
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
