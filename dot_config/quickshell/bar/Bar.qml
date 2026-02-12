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
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 15

        Workspaces {}
    }

    Column {
        id: centerSection
        anchors.verticalCenter: parent.verticalCenter
        spacing: 15

        Cpu {}
        Memory {}
        Disk {}
    }

    Column {
        id: bottomSection
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 15

        Clock {}
        Brightness {}
        Sound {}
        Network {}
        Battery {}
    }
}
