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
            text: "memory"
            font.family: Config.iconFont
            font.pixelSize: Config.iconSize
            color: SystemStats.ramPercent >= 90 ? Colors.love
                 : SystemStats.ramPercent >= 70 ? Colors.gold
                 : Colors.text
        }

        Text {
            text: SystemStats.ramPercent + "%"
            font.family: Config.textFont
            font.pixelSize: Config.textSize
            color: SystemStats.ramPercent >= 90 ? Colors.love
                 : SystemStats.ramPercent >= 70 ? Colors.gold
                 : Colors.text
        }

    }

}
