import QtQuick
import Quickshell.Io

Item {
    id: root

    property int count: 0
    property bool checked: false

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

    anchors.verticalCenter: parent.verticalCenter
    implicitWidth: pill.implicitWidth
    implicitHeight: pill.implicitHeight

    Group {
        id: pill

        padding: 6
        radius: 8
        spacing: 4
        borderWidth: 0
        color: checked && count > 0 ? Colors.foam : Colors.subtle
        colorOpacity: 1

        Text {
            text: "package_2"
            font.family: Config.iconFont
            font.pixelSize: Config.iconSize
            color: Colors.base
        }

        Text {
            text: root.checked ? root.count : "-"
            font.family: Config.textFont
            font.pixelSize: Config.textSize
            color: Colors.base
        }

    }

    MouseArea {
        anchors.fill: pill
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
