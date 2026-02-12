pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property int level: 0
    property bool available: false

    Component.onCompleted: {
        readBrightness();
    }

    Timer {
        id: pollTimer
        interval: 5000
        repeat: true
        running: true
        onTriggered: root.readBrightness()
    }

    function readBrightness() {
        if (readProcess.running) return;
        readProcess.running = true;
    }

    Process {
        id: readProcess
        command: ["brightnessctl", "-m"]
        stdout: StdioCollector {
            onStreamFinished: {
                let data = this.text.trim();
                let parts = data.split(",");
                if (parts.length >= 4) {
                    root.available = true;
                    let pct = parts[3].replace("%", "");
                    root.level = parseInt(pct) || 0;
                }
            }
        }
    }

    function increase() {
        if (setProcess.running) return;
        setProcess.command = ["brightnessctl", "set", "+5%"];
        setProcess.running = true;
    }

    function decrease() {
        if (setProcess.running) return;
        setProcess.command = ["brightnessctl", "set", "5%-"];
        setProcess.running = true;
    }

    Process {
        id: setProcess
        onExited: root.readBrightness()
    }
}
