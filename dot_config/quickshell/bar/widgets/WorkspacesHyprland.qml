import QtQuick
import Quickshell.Hyprland
import qs.common

Item {
    id: root

    anchors.horizontalCenter: parent.horizontalCenter

    property int hitSize: 28
    property int barWidth: 6
    property int activeHeight: 24
    property int dotSize: 6
    property int spacing: 4

    width: hitSize
    height: (hitSize + spacing) * Math.max(1, Hyprland.workspaces.count) - spacing

    Column {
        anchors.fill: parent
        spacing: spacing

        Repeater {
            model: Hyprland.workspaces

            Item {
                required property HyprlandWorkspace modelData
                required property int index

                width: hitSize
                height: hitSize

                Rectangle {
                    anchors.centerIn: parent
                    width: barWidth
                    height: modelData.focused
                            ? activeHeight
                            : dotSize

                    radius: width / 2

                    color: modelData.focused || modelData.toplevels.count > 0
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

                MouseArea {
                    anchors.fill: parent
                    onClicked: modelData.activate()
                }
            }
        }
    }
}
