import QtQuick
import Quickshell

Item {
    implicitWidth: data.implicitWidth
    implicitHeight: data.implicitHeight

    SystemClock {
        id: clock

        precision: SystemClock.Minutes
    }

    Row {
        id: data

        spacing: 4

        Text {
            id: timeText
            text: Qt.formatDateTime(clock.date, "hh:mm")
            font.pixelSize: Config.textSize
            font.bold: true
            color: Colors.text
        }

        Text {
            text: Qt.formatDateTime(clock.date, "ddd, MMM d")
            font.pixelSize: Config.textSizeSmall
            color: Colors.subtle
            anchors.baseline: timeText.baseline
        }

    }

}
