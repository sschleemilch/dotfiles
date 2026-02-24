import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.common
import qs.bar.widgets

PanelWindow {
    id: root

    required property var screen

    readonly property int margin: 10
    readonly property int spacing: 24

    anchors {
        left: true
        top: true
        bottom: true
    }

    implicitWidth: 55
    color: "transparent"

    Rectangle {
        anchors.fill: parent

        anchors.topMargin: margin
        anchors.bottomMargin: margin

        color: Colors.bg

        border.width: 1
        border.color: Colors.dimmed

        radius: 14

        Column {
            width: parent.width - 8

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: root.spacing

            spacing: root.spacing

            Clock {}
            Cpu {}
            Memory {}
            Disk {}
        }

        Column {
            width: parent.width - 8

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            spacing: root.spacing
                Workspaces {}
        }

        Column {
            width: parent.width - 8

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: root.spacing

            spacing: root.spacing


            Brightness {}
            Sound {}
            Battery {}

            Network {}
        }
    }
}
