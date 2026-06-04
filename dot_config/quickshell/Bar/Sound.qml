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
            text: Sound.muted ? "volume_off" : (Sound.volumePercent > 50 ? "volume_up" : "volume_down")
            font.family: Config.iconFont
            font.pixelSize: Config.iconSize
            color: Colors.text
        }

        Text {
            text: Sound.muted ? "0%" : Sound.volumePercent + "%"
            font.family: Config.textFont
            font.pixelSize: Config.textSize
            color: Colors.text
        }

    }

    MouseArea {
        anchors.fill: pill
        acceptedButtons: Qt.LeftButton
        onClicked: Sound.toggleMute()
        onWheel: (event) => {
            Sound.adjustVolume(event.angleDelta.y > 0 ? 0.05 : -0.05);
        }
    }

}
