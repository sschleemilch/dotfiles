import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.common
import qs.bar.widgets

PanelWindow {
    id: root

    required property var screen
    readonly property int margin: 10

    anchors {
        left: true
        top: true
        bottom: true
    }

    implicitWidth: 70
    color: "transparent"

    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.namespace: "quickshell:bar"

    Rectangle {
        id: barBackground
        anchors.fill: parent
        anchors.topMargin: margin
        anchors.bottomMargin: margin
        anchors.leftMargin: margin
        color: Colors.bar
        border.width: 1
        border.color: Colors.dimmed
        radius: 18

        Column {
            id: topSection
            width: parent.width - 8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 24

            BarGroup {
                Workspaces {}
            }
        }

        Column {
            id: centerSection
            width: parent.width - 8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            spacing: 12

        }

        Column {
            id: bottomSection
            width: parent.width - 8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 24
            spacing: 12

            Clock {}

            BarGroup {
                Cpu {}
                Memory {}
                Disk {}
            }

            BarGroup {
                Brightness {}
                Sound {}
                Battery {}
            }

            Network {
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
