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
        color: Network.status === "connected" ? Colors.subtle : Colors.gold
        colorOpacity: 1

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
            color: Colors.background
        }

        Text {
            text: {
                if (Network.connectionType === "wifi")
                    return Network.ssid || "WiFi";

                if (Network.connectionType === "ethernet")
                    return "Ethernet";

                return "Offline";
            }
            font.family: Config.textFont
            font.pixelSize: Config.textSize
            color: Colors.background
        }

    }

}
