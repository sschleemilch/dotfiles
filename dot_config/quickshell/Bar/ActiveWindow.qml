import QtQuick
import qs.services

Item {
    implicitWidth: data.implicitWidth
    implicitHeight: data.implicitHeight

    Row {
        id: data

        spacing: 4

        Text {
            id: appId
            text: ActiveWindow.appId || "Desktop"
            font.pixelSize: Config.textSize
            font.bold: true
            color: Colors.text
        }

        Text {
            readonly property int maxChars: 40

            text: ActiveWindow.windowTitle.length > maxChars ? ActiveWindow.windowTitle.slice(0, maxChars) + "…" : ActiveWindow.windowTitle
            font.pixelSize: Config.textSizeSmall
            color: Colors.subtle
            anchors.baseline: appId.baseline
        }

    }

}
