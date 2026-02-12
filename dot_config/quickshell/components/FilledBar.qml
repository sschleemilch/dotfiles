import QtQuick
import qs.common

Item {
    id: root

    anchors.horizontalCenter: parent.horizontalCenter

    property real value: 75
    property color backgroundColor: Colors.dimmed
    property color fillColor: Colors.accent
    property real radius: bar.width / 2

    property string icon: ""
    property color iconColor: Colors.text
    property int iconSize: 16

    width: 12
    height: 60

    Column {
        anchors.fill: parent
        spacing: 4

        Rectangle {
            id: bar
            width: parent.width
            height: parent.height - (root.icon ? iconLabel.height + parent.spacing : 0)
            color: root.backgroundColor

            Rectangle {
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                height: parent.height * (root.value / 100)
                color: root.fillColor

                Behavior on height {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.OutQuad
                    }
                }
            }
        }

        Text {
            id: iconLabel
            visible: root.icon !== ""
            text: root.icon
            color: root.iconColor
            font.pixelSize: root.iconSize
            font.family: "Symbols Nerd Font"
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }
    }
}
