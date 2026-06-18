import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
    id: root

    readonly property string home: Quickshell.env("HOME")

    property bool available: false

    property real temperature: 0
    property string weatherIcon: ""

    function poll() {
        if (weatherProcess.running)
            return ;

        weatherProcess.running = true;
    }


    Component.onCompleted: root.poll()

    Timer {
        interval: 60000
        repeat: true
        running: true
        onTriggered: root.poll()
    }

    Process {
        id: weatherProcess

        command: [home + "/.local/bin/weather.py"]

        stdout: StdioCollector {
            id: clientsCollector
            onStreamFinished: {
                try {
                    const w = JSON.parse(data)
                    temperature = w.temperature
                    weatherIcon = w.icon
                    root.available = true
                } catch (e) {
                    console.warn("Weather: failed to parse output:", e, "data:", data)
                }
            }
        }

    }

}
