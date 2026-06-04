import QtQuick
import qs.services

Item {
    id: root
    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight
    anchors.verticalCenter: parent.verticalCenter

    property color col: Network.status === "connected" ? Colors.text : Colors.love

    Row {
        id: content

        spacing: 4

        Text {
            text: {
                if (Network.connectionType === "wifi")
                    return "wifi";

                if (Network.connectionType === "ethernet")
                    return "cable";

                return "signal_wifi_off";
            }
            font.family: Config.iconFont
            font.pixelSize: Config.iconSize
            color: root.col
        }

        Text {
            text: {
                if (Network.connectionType === "wifi")
                    return Network.ssid.length > 4 ? Network.ssid.slice(0, 4) + "…" : Network.ssid;

                if (Network.connectionType === "ethernet")
                    return "Ethernet";

                return "Offline";
            }
            font.family: Config.textFont
            font.pixelSize: Config.textSize
            color: root.col
        }

    }

}
