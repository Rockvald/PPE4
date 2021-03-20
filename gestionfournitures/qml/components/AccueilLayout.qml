import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import QtQuick.Controls.Suru 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.5

Column {
    Row {
        spacing: 10
        Text {
            width: units.gu(10)
            wrapMode: Text.WordWrap
            //wrapMode: Text.WrapAnywhere
            //wrapMode: Text.Wrap
            text: model.nom
        }
        Text {
            width: units.gu(10)
            wrapMode: Text.WordWrap
            text: model.description
        }
    }
}
