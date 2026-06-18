import QtQuick
import qs.services

Item {
    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight
    anchors.verticalCenter: parent.verticalCenter

    Row {
        id: content

        spacing: 4

        Text {
            text: "hard_drive"
            font.family: Config.iconFont
            font.pixelSize: Config.iconSize
            color: SystemStats.diskPercent >= 90 ? Colors.love
                 : SystemStats.diskPercent >= 70 ? Colors.gold
                 : Colors.text
        }

        Text {
            text: SystemStats.diskPercent + "%"
            font.family: Config.textFont
            font.pixelSize: Config.textSize
            color: SystemStats.diskPercent >= 90 ? Colors.love
                 : SystemStats.diskPercent >= 70 ? Colors.gold
                 : Colors.text
        }

    }

}
