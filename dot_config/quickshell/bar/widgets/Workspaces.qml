import QtQuick
import qs.common
import qs.services

Item {
    id: root

    property int dotSize: 6
    property int buttonSize: 24
    property int activeIndicatorPadding: 4

    width: buttonSize
    height: buttonSize * Niri.workspaces.length

    // Active workspace indicator (filled pill, round)
    Rectangle {
        id: activeIndicator
        width: buttonSize
        height: buttonSize
        radius: width / 2
        color: Colors.accent

        y: {
            let idx = Niri.workspaces.findIndex(ws => ws.id === Niri.focusedWorkspaceId)
            return idx >= 0 ? idx * buttonSize : 0
        }

        Behavior on y {
            NumberAnimation {
                duration: 150
                easing.type: Easing.OutCubic
            }
        }
    }

    // Workspace dots
    Column {
        anchors.fill: parent

        Repeater {
            model: Niri.workspaces

            Item {
                required property var modelData
                required property int index

                width: buttonSize
                height: buttonSize

                Rectangle {
                    anchors.centerIn: parent
                    width: dotSize
                    height: width
                    radius: width / 2
                    color: (modelData.id === Niri.focusedWorkspaceId || modelData.active_window_id)
                        ? Colors.text
                        : Colors.dimmed

                    Behavior on color {
                        ColorAnimation {
                            duration: 150
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: Niri.switchToWorkspace(modelData.idx)
                }
            }
        }
    }

    // Scroll to switch workspaces
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.NoButton

        onWheel: event => {
            let currentIdx = Niri.workspaces.findIndex(ws => ws.id === Niri.focusedWorkspaceId)
            if (event.angleDelta.y > 0 && currentIdx > 0) {
                Niri.switchToWorkspace(Niri.workspaces[currentIdx - 1].idx)
            } else if (event.angleDelta.y < 0 && currentIdx < Niri.workspaces.length - 1) {
                Niri.switchToWorkspace(Niri.workspaces[currentIdx + 1].idx)
            }
        }
    }
}
