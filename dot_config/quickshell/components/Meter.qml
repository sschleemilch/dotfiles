import QtQuick
import qs.common

Item {
    id: root

    anchors.horizontalCenter: parent.horizontalCenter

    property real value: 0.0
    property string icon: ""
    property real radius: 6

    property color color: Colors.fg

    width: 25
    height: 60


    Rectangle {
        id: background
        anchors.fill: parent
        color: Qt.darker(root.color, 1.5)
        radius: root.radius

        Rectangle {
            id: fill
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: root.value * parent.height < root.radius ? 0 : root.value * parent.height
            color: root.color
            radius: root.radius
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
        }

        Text {
            id: iconText
            visible: !mouseArea.containsMouse
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: root.icon
            font.pixelSize: Config.iconSize
            font.family: Config.iconFont
            color: Colors.bg
        }

        Text {
            id: percentText
            visible: mouseArea.containsMouse
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: Math.round(root.value * 100) + "%"
            rotation: -90
            font.pixelSize: Config.textSize
            font.family: Config.textFont
            color: Colors.bg
        }
    }
}
