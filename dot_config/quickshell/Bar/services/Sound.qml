pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property bool muted: sink?.audio?.muted ?? false
    readonly property real volume: sink?.audio?.volume ?? 0
    readonly property int volumePercent: Math.round(volume * 100)

    function toggleMute() {
        if (root.sink?.audio)
            root.sink.audio.muted = !root.sink.audio.muted;
    }

    function adjustVolume(delta) {
        if (!root.sink?.audio) return;
        root.sink.audio.volume = Math.max(0.0, Math.min(1.0, root.volume + delta));
    }

    PwObjectTracker {
        objects: [root.sink]
    }
}
