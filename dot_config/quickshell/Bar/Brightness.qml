import QtQuick
import qs.services

Item {
    implicitWidth: pill.implicitWidth
    implicitHeight: pill.implicitHeight
    anchors.verticalCenter: parent.verticalCenter

    visible: Brightness.available

    Group {
        id: pill

        padding: 6
        radius: 8
        spacing: 4
        borderWidth: 0
        color: Colors.subtle
        colorOpacity: 1

        Text {
            text: "brightness_6"
            font.family: Config.iconFont
            font.pixelSize: Config.iconSize
            color: Colors.base
        }

        Text {
            text: Brightness.level + "%"
            font.family: Config.textFont
            font.pixelSize: Config.textSize
            color: Colors.base
        }
    }

    MouseArea {
        anchors.fill: pill
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
