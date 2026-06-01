import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.services


Row {
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

    spacing: 4

    Repeater {
        model: displayCount

        delegate: Item {
            required property int index
            readonly property int wsId: index + 1
            readonly property bool occupied: HyprlandData.workspaceById[wsId] !== undefined
            readonly property bool focused: HyprlandData.activeWorkspace !== null && HyprlandData.activeWorkspace.id === wsId

            implicitWidth: 35
            implicitHeight: 30

            Rectangle {
                anchors.fill: parent
                radius: 8
                color: focused ? Colors.foam : occupied ? Colors.muted : "transparent"
                opacity: focused ? 1 : 0.8

                Rectangle {
                    anchors.fill: parent
                    radius: parent.radius
                    visible: focused
                    gradient: Gradient {
                        orientation: Gradient.Horizontal
                        GradientStop { position: 0.0; color: Colors.foam }
                        GradientStop { position: 1.0; color: Qt.lighter(Colors.foam, 1.3) }
                    }
                }

                Text {
                    anchors.centerIn: parent
                    text: wsId
                    font.pixelSize: Config.textSize
                    font.family: Config.textFont
                    font.bold: focused
                    color: focused ? Colors.base : Colors.text
                }

            }
            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch("workspace " + wsId)
            }


        }

    }

}
