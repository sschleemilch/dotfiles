pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property int cpuUsage: 0
    property int memoryUsage: 0
    property int diskUsagePercent: 0
    property bool available: false

    property string _cpuCursor: ""
    property var _currentCommand: []
    property string _accumulatedOutput: ""


    Component.onCompleted: {
        dgopCheckProcess.running = true
    }

    Process {
        id: dgopCheckProcess
        command: ["which", "dgop"]
        running: false
        onExited: exitCode => {
            available = (exitCode === 0);
            pollTimer.running = true
        }
    }

    Timer {
        id: pollTimer
        interval: 3000
        repeat: true
        running: false
        onTriggered: {
            if (dgopProcess.running) return

            let cmd = ["dgop", "meta", "--json", "--modules", "cpu,memory,diskmounts"]
            if (root._cpuCursor !== "") {
                cmd.push("--cpu-cursor")
                cmd.push(root._cpuCursor)
            }
            root._currentCommand = cmd
            dgopProcess.running = true
        }
    }

    Process {
        id: dgopProcess
        command: root._currentCommand
        running: false
        onExited: exitCode => {
            if (exitCode !== 0) {
                console.warn("Dgop process failed with exit code:", exitCode);
            }
        }
        stdout: StdioCollector {
            onStreamFinished: {
                if (text.trim()) {
                    try {
                        const data = JSON.parse(text.trim());
                        parseData(data);
                    } catch (e) {
                        console.warn("Failed to parse dgop JSON:", e);
                        console.warn("Raw text was:", text.substring(0, 200));
                        isUpdating = false;
                    }
                }
            }
        }
    }

    function parseData(parsed) {
        if (parsed.cpu) {
            root.cpuUsage = Math.round(parsed.cpu.usage || parsed.cpu.usage_percent || 0)
            if (parsed.cpu.cursor) {
                root._cpuCursor = parsed.cpu.cursor
            }
        }

        if (parsed.memory) {
            let total = parsed.memory.total || parsed.memory.total_kb || 1
            let available = parsed.memory.available || parsed.memory.available_kb || 0
            root.memoryUsage = Math.round(((total - available) / total) * 100)
        }

        if (parsed.diskmounts && Array.isArray(parsed.diskmounts)) {
            let rootMount = parsed.diskmounts.find(m => m.mount === "/")
            if (rootMount) {
                let pct = rootMount.percent || "0%"
                root.diskUsagePercent = parseInt(pct.replace("%", "")) || 0
            }
        }
    }
}
