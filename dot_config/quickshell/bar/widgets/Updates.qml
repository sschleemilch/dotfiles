import QtQuick
import Quickshell.Io
import qs.common

Column {
    id: root

    spacing: 1

    anchors.horizontalCenter: parent.horizontalCenter

    property int count: 0
    property bool checked: false

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: "package_2"
        font.family: Config.iconFont
        font.pixelSize: Config.iconSize
        color: root.count > 0 ? Colors.ok : Colors.dimmed

        MouseArea {
            anchors.fill: parent
            onClicked: root.pollUpdates()
        }
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: root.checked ? (root.count > 0 ? root.count : "") : "?"
        font.family: Config.textFont
        font.pixelSize: Config.textSize
        color: root.count > 0 ? Colors.ok : Colors.dimmed
    }

    Timer {
        interval: 60000
        running: true
        onTriggered: root.pollUpdates()
    }

    function pollUpdates() {
        if (checkupdatesProcess.running)
            return;
        checkupdatesProcess.running = true;
    }

    Process {
        id: checkupdatesProcess
        command: ["checkupdates"]
        stdout: StdioCollector {
            onStreamFinished: root._parseUpdates(this.text)
        }
    }

    function _parseUpdates(data) {
        let lines = data.trim().split("\n");
        let updateCount = lines[0] === "" ? 0 : lines.length;
        root.count = updateCount;
        root.checked = true;
    }
}
