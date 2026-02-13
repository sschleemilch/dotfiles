import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.common
import qs.bar.widgets

PanelWindow {
    id: root

    required property var screen

    anchors {
        left: true
        top: true
        bottom: true
    }

    implicitWidth: Colors.barWidth
    color: Colors.bar

    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.namespace: "quickshell:bar"

    Column {
        id: topSection
        width: parent.width
        anchors.top: parent.top
        anchors.topMargin: 10
        spacing: 15

        BarGroup {
            Workspaces {}
        }
    }

    Column {
        id: centerSection
        width: parent.width
        anchors.verticalCenter: parent.verticalCenter
        spacing: 15

        BarGroup {
            Cpu {}
            Memory {}
            Disk {}
        }
    }

    Column {
        id: bottomSection
        width: parent.width
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        spacing: 15

        Clock {}

        BarGroup {
            Brightness {}
            Sound {}
            Battery {}
            Network {}
        }
    }
}
