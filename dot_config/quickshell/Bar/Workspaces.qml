import QtQuick
import Quickshell.Hyprland
import qs.services

Item {
    readonly property int minCount: 5
    readonly property int maxOccupiedId: {
        let max = 0;
        for (let i = 0; i < HyprlandData.workspaces.length; i++) {
            const id = HyprlandData.workspaces[i].id;
            if (id > max)
                max = id;
        }
        return max;
    }
    readonly property int displayCount: Math.max(minCount, maxOccupiedId)

    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    Row {
        id: row
        spacing: 4

        Repeater {
            model: displayCount

            delegate: Item {
                required property int index

                width: 20
                height: 8

                readonly property int wsId: index + 1
                readonly property bool occupied: HyprlandData.workspaceById[wsId] !== undefined
                readonly property bool focused: HyprlandData.activeWorkspace !== null && HyprlandData.activeWorkspace.id === wsId

                Rectangle {
                    anchors.centerIn: parent
                    height: 8
                    width: focused ? 20 : 8
                    color: focused ? Colors.text : occupied ? Colors.text : Colors.muted
                    radius: height / 2

                    Behavior on width {
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
