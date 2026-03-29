import QtQuick
import Quickshell
import qs.common

Column {
    id: root

    spacing: -2

    anchors.horizontalCenter: parent.horizontalCenter

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: Qt.locale().toString(clock.date, "hh:mm")
        font.family: Config.textFont
        font.pixelSize: Config.textSize
        color: Colors.fg
    }


    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: Qt.locale().toString(clock.date, "ddd")
        font.family: Config.textFont
        font.pixelSize: Config.textSize + 1
        font.bold: true
        color: Colors.fg
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: Qt.locale().toString(clock.date, "dd.MM")
        font.family: Config.textFont
        font.pixelSize: Config.textSize
        color: Colors.fg
    }
}
