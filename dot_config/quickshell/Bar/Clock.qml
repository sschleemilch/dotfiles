import QtQuick
import Quickshell

Item {
    implicitWidth: data.implicitWidth
    implicitHeight: data.implicitHeight

    SystemClock {
        id: clock

        precision: SystemClock.Minutes
    }

    Column {
        id: data

        spacing: -4

        Text {
            text: Qt.formatDateTime(clock.date, "hh:mm")
            font.pixelSize: Config.textSize
            font.bold: true
            color: Colors.foam
        }

        Text {
            text: Qt.formatDateTime(clock.date, "ddd, MMM d")
            font.pixelSize: Config.textSizeSmall
            color: Colors.subtle
        }

    }

}
