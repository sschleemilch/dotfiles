import QtQuick
import qs.services

Row {
    spacing: 4
    height: parent.height

    Text {
        text: Weather.weatherIcon
        font.family: Config.iconFont
        font.pixelSize: Config.textSizeLarge
        color: Colors.text
        anchors.verticalCenter: parent.verticalCenter
    }

    Text {
        text: Math.round(Weather.temperature) + "°"
        font.family: Config.textFont
        font.pixelSize: Config.textSize
        font.bold: true
        color: Weather.temperature >= 30 ? Colors.love : Weather.temperature >= 20 ? Colors.gold : Colors.foam
        anchors.verticalCenter: parent.verticalCenter
    }

}
