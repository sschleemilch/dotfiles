import QtQuick
import qs.services

Item {
    implicitWidth: pill.implicitWidth
    implicitHeight: pill.implicitHeight
    anchors.verticalCenter: parent.verticalCenter

    Group {
        id: pill

        padding: 6
        radius: 8
        spacing: 4
        borderWidth: 0
        color: Colors.subtle
        colorOpacity: 1

        Text {
            text: Sound.muted ? "volume_off" : (Sound.volumePercent > 50 ? "volume_up" : "volume_down")
            font.family: Config.iconFont
            font.pixelSize: Config.iconSize
            color: Colors.base
        }

        Text {
            text: Sound.muted ? "0%" : Sound.volumePercent + "%"
            font.family: Config.textFont
            font.pixelSize: Config.textSize
            color: Colors.base
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
