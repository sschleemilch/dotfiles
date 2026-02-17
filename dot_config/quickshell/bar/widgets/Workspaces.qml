import QtQuick
import qs.common
import qs.services

Item {
    id: root

    anchors.horizontalCenter: parent.horizontalCenter

    property int hitSize: 28
    property int barWidth: 6
    property int activeHeight: 24
    property int dotSize: 6
    property int spacing: 4

    width: hitSize
    height: (hitSize + spacing) * Niri.workspaces.length - spacing

    property int activeIndex:
        Niri.workspaces.findIndex(ws => ws.id == Niri.focusedWorkspaceId)

    Column {
        anchors.fill: parent
        spacing: spacing

        Repeater {
            model: Niri.workspaces

            Item {
                required property var modelData
                required property int index

                width: hitSize
                height: hitSize

                Rectangle {
                    anchors.centerIn: parent
                    width: barWidth
                    height: index == root.activeIndex
                            ? activeHeight
                            : dotSize

                    radius: width / 2

                    color: index == root.activeIndex || modelData.active_window_id
                            ? Colors.fg
                            : Colors.dimmed

                    Behavior on height {
                        NumberAnimation {
                            duration: 100
                            easing.type: Easing.OutQuad
                        }
                    }

                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }
                }
            }
        }
    }
}
