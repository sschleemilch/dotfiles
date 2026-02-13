import QtQuick
import Quickshell
import qs.common

Column {
    id: root

    spacing: 0

    anchors.horizontalCenter: parent.horizontalCenter

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: {
            let h = clock.hours;
            return (h < 10 ? "0" : "") + h;
        }
        font.family: Colors.textFont
        font.pixelSize: Colors.textSize + 4
        font.bold: true
        color: Colors.text
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: {
            let m = clock.minutes;
            return (m < 10 ? "0" : "") + m;
        }
        font.family: Colors.textFont
        font.pixelSize: Colors.textSize + 4
        font.bold: true
        color: Colors.dimmed
    }
}
