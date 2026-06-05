import QtQuick
import qs.services

Item {
    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    visible: Brightness.available

    Row {
        id: content

        spacing: 4

        Text {
            text: "brightness_6"
            font.family: Config.iconFont
            font.pixelSize: Config.iconSize
            color: Colors.text
        }

        Text {
            text: Brightness.level + "%"
            font.family: Config.textFont
            font.pixelSize: Config.textSize
            color: Colors.text
        }
    }

    MouseArea {
        anchors.fill: content
        acceptedButtons: Qt.NoButton

        onWheel: event => {
            if (event.angleDelta.y > 0) {
                Brightness.increase();
            } else if (event.angleDelta.y < 0) {
                Brightness.decrease();
            }
        }
    }
}
