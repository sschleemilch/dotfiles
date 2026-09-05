import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
pragma Singleton

Singleton {
    id: root

    readonly property var source: Pipewire.defaultAudioSource
    readonly property bool available: source !== null
    readonly property bool muted: source?.audio?.muted ?? true
    readonly property var nodes: Pipewire.nodes ? Pipewire.nodes.values : []
    readonly property bool inUse: {
        if (root.muted)
            return false;

        for (const node of root.nodes) {
            if (node?.isStream && node.isSink === false && !node.audio?.muted)
                return true;
        }

        return false;
    }

    function toggleMute() {
        if (root.source?.audio)
            root.source.audio.muted = !root.source.audio.muted;
    }

    PwObjectTracker {
        objects: root.source ? [root.source] : []
    }
}
