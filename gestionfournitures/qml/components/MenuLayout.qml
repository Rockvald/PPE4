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
    highlightColor: UbuntuColors.red

    ListItemLayout {
        anchors.fill: parent
        title.text: model.nom
        title.color: "#c2c2c2"
    }

    onClicked: {
        mainheader.title = model.nom
        pageLoader.source = model.url
        menuLoader.active = false
    }
}
