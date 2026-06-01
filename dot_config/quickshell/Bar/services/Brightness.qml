import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
    id: root

    property int level: 0
    property bool available: false

    function readBrightness() {
        if (!available || readProcess.running)
            return ;

        readProcess.running = true;
    }

    function increase() {
        if (!available || setProcess.running)
            return ;

        setProcess.command = ["brightnessctl", "set", "+5%"];
        setProcess.running = true;
    }

    function decrease() {
        if (!available || setProcess.running)
            return ;

        setProcess.command = ["brightnessctl", "set", "5%-"];
        setProcess.running = true;
    }

    Component.onCompleted: {
        checkProcess.running = true;
    }

    Timer {
        id: pollTimer

        interval: 5000
        repeat: true
        running: false
        onTriggered: root.readBrightness()
    }

    Process {
        id: checkProcess

        command: ["which", "brightnessctl"]
        onExited: (exitCode) => {
            if (exitCode === 0) {
                root.available = true;
                pollTimer.running = true;
                root.readBrightness();
            }
        }
    }

    Process {
        id: readProcess

        command: ["brightnessctl", "-m"]

        stdout: StdioCollector {
            onStreamFinished: {
                let data = this.text.trim();
                let parts = data.split(",");
                if (parts.length >= 4) {
                    let pct = parts[3].replace("%", "");
                    root.level = parseInt(pct) || 0;
                }
            }
        }

    }

    Process {
        id: setProcess

        onExited: root.readBrightness()
    }

}
