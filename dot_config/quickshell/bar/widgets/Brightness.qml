import QtQuick
import qs.common
import qs.services as Services

Item {
    id: root

    width: Colors.barWidth
    height: content.height
    visible: Services.Brightness.available

    Column {
        id: content
        width: parent.width
        spacing: 1

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "\u{f00df}"
            font.family: Colors.iconFont
            font.pixelSize: Colors.iconSize
            color: Colors.text
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: Services.Brightness.level + "%"
            font.family: Colors.textFont
            font.pixelSize: Colors.textSize
            color: Colors.text
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.NoButton

        onWheel: event => {
            if (event.angleDelta.y > 0) {
                Services.Brightness.increase();
            } else if (event.angleDelta.y < 0) {
                Services.Brightness.decrease();
            }
        }
    }
}
