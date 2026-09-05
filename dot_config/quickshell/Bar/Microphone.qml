import QtQuick
import qs.services

Item {
    id: root

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight
    anchors.verticalCenter: parent.verticalCenter
    visible: MicrophoneService.available

    Row {
        id: content

        Text {
            text: MicrophoneService.muted ? "mic_off" : "mic"
            font.family: Config.iconFont
            font.pixelSize: Config.iconSize
            color: MicrophoneService.muted
                ? Colors.textMuted
                : (MicrophoneService.inUse ? Colors.statusPositive : Colors.textPrimary)
        }
    }

    MouseArea {
        anchors.fill: content
        acceptedButtons: Qt.LeftButton
        onClicked: MicrophoneService.toggleMute()
    }
}
