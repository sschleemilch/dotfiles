import QtQuick
import Quickshell.Services.Pipewire
import qs.common

Item {
    id: root

    width: Colors.barWidth
    height: content.height

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property bool muted: sink?.audio?.muted ?? false
    readonly property real volume: sink?.audio?.volume ?? 0
    readonly property int volumePercent: Math.round(volume * 100)

    PwObjectTracker {
        objects: [root.sink]
    }

    Column {
        id: content
        width: parent.width
        spacing: 1

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: root.muted ? "\uf026" : (root.volumePercent > 50 ? "\uf028" : "\uf027")
            font.family: Colors.iconFont
            font.pixelSize: Colors.iconSize
            color: root.muted ? Colors.dimmed : Colors.text
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: root.muted ? "M" : root.volumePercent + "%"
            font.family: Colors.textFont
            font.pixelSize: Colors.textSize
            color: root.muted ? Colors.dimmed : Colors.text
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton

        onClicked: {
            if (root.sink?.audio) {
                root.sink.audio.muted = !root.sink.audio.muted;
            }
        }

        onWheel: event => {
            if (!root.sink?.audio) return;
            let step = 0.05;
            if (event.angleDelta.y > 0) {
                root.sink.audio.volume = Math.min(1.0, root.volume + step);
            } else if (event.angleDelta.y < 0) {
                root.sink.audio.volume = Math.max(0.0, root.volume - step);
            }
        }
    }
}
