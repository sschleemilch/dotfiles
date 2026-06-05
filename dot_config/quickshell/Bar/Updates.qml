import QtQuick
import Quickshell.Io

Item {
    id: root

    property int count: 0
    property bool checked: false
    property color col: checked && count > 0 ? Colors.foam : Colors.subtle

    function pollUpdates() {
        if (checkupdatesProcess.running)
            return ;

        checked = false
        checkupdatesProcess.running = true;
    }

    function _parseUpdates(data) {
        let lines = data.trim().split("\n");
        let updateCount = lines[0] === "" ? 0 : lines.length;
        root.count = updateCount;
        root.checked = true;
    }

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    Row {
        id: content
        spacing: 4

        Text {
            text: "package_2"
            font.family: Config.iconFont
            font.pixelSize: Config.iconSize
            color: root.col
        }

        Text {
            text: root.checked ? root.count : "-"
            font.family: Config.textFont
            font.pixelSize: Config.textSize
            color: root.col
        }

    }

    MouseArea {
        anchors.fill: content
        onClicked: root.pollUpdates()
    }

    Timer {
        interval: 10000
        running: true
        onTriggered: root.pollUpdates()
    }

    Process {
        id: checkupdatesProcess

        command: ["checkupdates"]

        stdout: StdioCollector {
            onStreamFinished: root._parseUpdates(this.text)
        }

    }

}
