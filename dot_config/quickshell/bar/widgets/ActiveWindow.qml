import qs.services
import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.common

Column {
    id: root
    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(root.QsWindow.window?.screen)
    readonly property Toplevel activeWindow: ToplevelManager.activeToplevel

    property string activeWindowAddress: `0x${activeWindow?.HyprlandToplevel?.address}`
    property bool focusingThisMonitor: HyprlandData.activeWorkspace?.monitor == monitor?.name
    property var biggestWindow: HyprlandData.biggestWindowForWorkspace(HyprlandData.monitors[root.monitor?.id]?.activeWorkspace.id)

    anchors.horizontalCenter: parent.horizontalCenter


    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 2

        // App class
        Item {
            width: Config.textSize + 4
            height: 300

            Text {
                width: parent.height
                anchors.centerIn: parent
                rotation: -90
                text: root.focusingThisMonitor && root.activeWindow?.activated && root.biggestWindow ?
                    root.activeWindow?.appId :
                    (root.biggestWindow?.class) ?? "Desktop"
                font.family: Config.textFont
                font.pixelSize: Config.textSize
                color: Colors.dimmed
                elide: Text.ElideRight
                horizontalAlignment: Text.AlignHCenter
            }
        }

        // Window title
        Item {
            width: Config.textSize + 4
            height: 300

            Text {
                width: parent.height
                anchors.centerIn: parent
                rotation: -90
                text: root.focusingThisMonitor && root.activeWindow?.activated && root.biggestWindow ?
                    root.activeWindow?.title :
                    (root.biggestWindow?.title) ?? `Workspace ${monitor?.activeWorkspace?.id ?? 1}`
                font.family: Config.textFont
                font.pixelSize: Config.textSize
                color: Colors.fg
                elide: Text.ElideRight
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }
}
