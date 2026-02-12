import QtQuick
import qs.common
import qs.services

Item {
    id: root

    width: Colors.barWidth
    height: wsColumn.height

    Column {
        id: wsColumn
        width: parent.width
        spacing: 2

        Repeater {
            model: Niri.workspaces

            Rectangle {
                required property var modelData

                width: Colors.barWidth - 10
                height: Colors.barWidth - 10

                anchors.horizontalCenter: parent.horizontalCenter
                color: modelData.id === Niri.focusedWorkspaceId ? Colors.accent : "transparent"

                Text {
                    anchors.centerIn: parent
                    text: modelData.idx
                    font.family: Colors.textFont
                    font.pixelSize: Colors.textSize + 2
                    font.bold: modelData.id === Niri.focusedWorkspaceId
                    color: modelData.id === Niri.focusedWorkspaceId ? Colors.bar : (modelData.active_window_id ? Colors.text : Colors.dimmed)
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: Niri.switchToWorkspace(modelData.idx)
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.NoButton

        onWheel: event => {
            if (event.angleDelta.y > 0) {
                let currentIdx = Niri.workspaces.findIndex(ws => ws.id === Niri.focusedWorkspaceId);
                if (currentIdx > 0) {
                    Niri.switchToWorkspace(Niri.workspaces[currentIdx - 1].idx);
                }
            } else if (event.angleDelta.y < 0) {
                let currentIdx = Niri.workspaces.findIndex(ws => ws.id === Niri.focusedWorkspaceId);
                if (currentIdx < Niri.workspaces.length - 1) {
                    Niri.switchToWorkspace(Niri.workspaces[currentIdx + 1].idx);
                }
            }
        }
    }
}
