import QtQuick
import Quickshell.Io
import qs.common

Column {
    id: root
    anchors.horizontalCenter: parent.horizontalCenter

    spacing: 1

    property string status: "disconnected"
    property string ssid: ""
    property string connectionType: ""

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: {
            if (root.connectionType === "wifi")
                return "\uf1eb";
            if (root.connectionType === "ethernet")
                return "\u{f0200}";
            return "\u{f0551}";
        }
        font.family: Config.iconFont
        font.pixelSize: Config.iconSize
        color: root.status === "connected" ? Colors.fg: Colors.dimmed
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: {
            if (root.connectionType === "wifi" && root.ssid !== "")
                return root.ssid.substring(0, 4);
            if (root.connectionType === "ethernet")
                return "ETH";
            return "OFF";
        }
        font.family: Config.textFont
        font.pixelSize: Config.textSize - 1
        color: root.status === "connected" ? Colors.fg: Colors.dimmed
    }

    Component.onCompleted: pollNetwork()

    Timer {
        interval: 10000
        repeat: true
        running: true
        onTriggered: root.pollNetwork()
    }

    function pollNetwork() {
        if (nmcliProcess.running)
            return;
        nmcliProcess.running = true;
    }

    Process {
        id: nmcliProcess
        command: ["nmcli", "-t", "-f", "TYPE,STATE,CONNECTION", "device"]
        stdout: StdioCollector {
            onStreamFinished: root._parseNmcli(this.text)
        }
    }

    function _parseNmcli(data) {
        let lines = data.trim().split("\n");
        let wifiLine = lines.find(l => l.startsWith("wifi:connected:"));
        let ethLine = lines.find(l => l.startsWith("ethernet:connected:"));

        if (wifiLine) {
            root.status = "connected";
            root.connectionType = "wifi";
            root.ssid = wifiLine.split(":")[2] || "";
        } else if (ethLine) {
            root.status = "connected";
            root.connectionType = "ethernet";
            root.ssid = "";
        } else {
            root.status = "disconnected";
            root.connectionType = "";
            root.ssid = "";
        }
    }
}
