import QtQuick
import qs.services

Row {
    spacing: 4
    height: parent.height

    visible: Weather.available

    Text {
        text: Weather.weatherIcon
        font.family: Config.iconFont
        font.pixelSize: Config.iconSize
        color: Colors.textPrimary
        anchors.verticalCenter: parent.verticalCenter
    }

    Text {
        text: Math.round(Weather.temperature) + "°"
        font.family: Config.textFont
        font.pixelSize: Config.textSize
        font.bold: true
        color: Weather.temperature >= 30 ? Colors.temperatureHot : Weather.temperature >= 20 ? Colors.temperatureWarm : Colors.temperatureCool
        anchors.verticalCenter: parent.verticalCenter
    }

}
