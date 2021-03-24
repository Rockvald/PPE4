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
    spacing: units.gu(6)
    topPadding: units.gu(5)
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
}
