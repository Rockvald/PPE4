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
        spacing: units.gu(1)
        Text {
            width: units.gu(30)
            horizontalAlignment: Text.AlignHCenter
            text: model.titre
        }
        Text {
            width: units.gu(30)
            horizontalAlignment: Text.AlignHCenter
            text: model.description
        }
    }
}
