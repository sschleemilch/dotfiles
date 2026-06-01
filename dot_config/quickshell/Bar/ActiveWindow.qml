import QtQuick
import qs.services

Item {
    implicitWidth: data.implicitWidth
    implicitHeight: data.implicitHeight

    Column {
        id: data

        spacing: -4

        Text {
            text: ActiveWindow.appId || "Desktop"
            font.pixelSize: Config.textSize
            font.bold: true
            color: Colors.foam
            elide: Text.ElideRight
        }

        Text {
            readonly property int maxChars: 40

            text: ActiveWindow.windowTitle.length > maxChars ? ActiveWindow.windowTitle.slice(0, maxChars) + "…" : ActiveWindow.windowTitle
            font.pixelSize: Config.textSizeSmall
            color: Colors.subtle
        }

    }

}
