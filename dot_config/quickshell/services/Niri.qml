pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    readonly property string socketPath: Quickshell.env("NIRI_SOCKET")
    property var workspaces: []
    property int focusedWorkspaceId: -1

    function switchToWorkspace(idx) {
        requestSocket.write(JSON.stringify({
            "Action": {
                "FocusWorkspace": {
                    "reference": { "Index": idx }
                }
            }
        }) + "\n");
        requestSocket.flush();
    }

    Socket {
        id: eventSocket
        path: root.socketPath
        connected: root.socketPath !== ""

        parser: SplitParser {
            onRead: message => root._handleEvent(message)
        }

        onConnectedChanged: {
            if (connected) {
                eventSocket.write("\"EventStream\"\n");
                eventSocket.flush();
            }
        }
    }

    Socket {
        id: requestSocket
        path: root.socketPath
        connected: root.socketPath !== ""
    }

    Timer {
        id: reconnectTimer
        interval: 2000
        repeat: false
        onTriggered: {
            if (!eventSocket.connected) {
                eventSocket.connected = true;
            }
        }
    }

    function _handleEvent(message) {
        let event;
        try {
            event = JSON.parse(message);
        } catch (e) {
            return;
        }

        if (event.WorkspacesChanged) {
            _updateWorkspaces(event.WorkspacesChanged.workspaces);
        } else if (event.WorkspaceActivated) {
            root.focusedWorkspaceId = event.WorkspaceActivated.id;
        }
    }

    function _updateWorkspaces(wsList) {
        let sorted = wsList.slice().sort((a, b) => a.idx - b.idx);
        root.workspaces = sorted;

        let active = sorted.find(ws => ws.is_active);
        if (active) {
            root.focusedWorkspaceId = active.id;
        }
    }
}
