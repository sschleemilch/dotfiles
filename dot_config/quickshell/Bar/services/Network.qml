import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
    id: root

    property string status: "disconnected"
    property string ssid: ""
    property string connectionType: ""

    function poll() {
        if (nmcliProcess.running)
            return ;

        nmcliProcess.running = true;
    }

    function _parseNmcli(data) {
        let lines = data.trim().split("\n");
        let wifiLine = lines.find((l) => {
            return l.startsWith("wifi:connected:");
        });
        let ethLine = lines.find((l) => {
            return l.startsWith("ethernet:connected:");
        });
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

    Component.onCompleted: poll()

    Timer {
        interval: 10000
        repeat: true
        running: true
        onTriggered: root.poll()
    }

    Process {
        id: nmcliProcess

        command: ["nmcli", "-t", "-f", "TYPE,STATE,CONNECTION", "device"]

        stdout: StdioCollector {
            onStreamFinished: root._parseNmcli(this.text)
        }

    }

}
