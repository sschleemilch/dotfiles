import QtQuick
import qs.common
import qs.services

Column {
    id: root

    spacing: 0
    anchors.horizontalCenter: parent.horizontalCenter

    function shortenText(str, maxLen) {
        if (!str) return "";
        if (str.length <= maxLen) return str;
        return str.slice(0, maxLen - 3) + "…";
    }

    Text {
        id: appNameText
        anchors.horizontalCenter: parent.horizontalCenter
        text: {
            const w = Niri.focusedWindow;
            return shortenText(w?.app_id || "Desktop", 12);
        }
        font.family: Config.textFont
        font.pixelSize: Config.textSize - 2
        color: Colors.dimmed
        elide: Text.ElideRight
        horizontalAlignment: Text.AlignHCenter

        rotation: -90
        transformOrigin: Item.Center
    }

    Text {
        id: titleText
        anchors.horizontalCenter: parent.horizontalCenter
        text: {
            const w = Niri.focusedWindow;
            if (w?.title) return shortenText(w.title, 20);
            return `Workspace ${Niri.getCurrentWorkspaceNumber()}`;
        }
        font.family: Config.textFont
        font.pixelSize: Config.textSize
        color: Colors.fg
        elide: Text.ElideRight
        horizontalAlignment: Text.AlignHCenter

        rotation: -90
        transformOrigin: Item.Center
    }
}
