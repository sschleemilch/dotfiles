import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
    id: root

    property int ramPercent: 0
    property int diskPercent: 0

    function poll() {
        if (!ramProcess.running)
            ramProcess.running = true;
        if (!diskProcess.running)
            diskProcess.running = true;
    }

    function _parseRam(data) {
        // free -b output:
        //               total        used        free      shared  buff/cache   available
        // Mem:     XXXXXXXXX   XXXXXXXXX   XXXXXXXXX   XXXXXXXXX   XXXXXXXXX   XXXXXXXXX
        let lines = data.trim().split("\n");
        for (let i = 0; i < lines.length; i++) {
            if (lines[i].startsWith("Mem:")) {
                let parts = lines[i].trim().split(/\s+/);
                let total = parseInt(parts[1]);
                let used = parseInt(parts[2]);
                if (total > 0)
                    root.ramPercent = Math.round(used / total * 100);
                break;
            }
        }
    }

    function _parseDisk(data) {
        // df -B1 / output:
        // Filesystem     1B-blocks      Used  Available Use% Mounted on
        // /dev/sdX   XXXXXXXXX   XXXXXXXXX  XXXXXXXXX  XX% /
        let lines = data.trim().split("\n");
        for (let i = 1; i < lines.length; i++) {
            let parts = lines[i].trim().split(/\s+/);
            // Use% is the 5th field (index 4), strip the trailing %
            if (parts.length >= 5) {
                let useField = parts[4].replace("%", "");
                let pct = parseInt(useField);
                if (!isNaN(pct)) {
                    root.diskPercent = pct;
                    break;
                }
            }
        }
    }

    Component.onCompleted: poll()

    Timer {
        interval: 30000
        repeat: true
        running: true
        onTriggered: root.poll()
    }

    Process {
        id: ramProcess

        command: ["free", "-b"]

        stdout: StdioCollector {
            onStreamFinished: root._parseRam(this.text)
        }

    }

    Process {
        id: diskProcess

        command: ["df", "-B1", "/"]

        stdout: StdioCollector {
            onStreamFinished: root._parseDisk(this.text)
        }

    }

}
