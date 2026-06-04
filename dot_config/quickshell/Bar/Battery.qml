import QtQuick
import qs.services

Item {
    id: root
    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight
    anchors.verticalCenter: parent.verticalCenter

    visible: Battery.available

    property color c: Battery.isLow ? Colors.love : Battery.charging ? Colors.foam : Colors.rose

    Row {
        id: content

        spacing: 4

        Text {
            text: {
                if (Battery.charging)
                    return "battery_charging_full";

                if (Battery.level > 75)
                    return "battery_full";

                if (Battery.level > 50)
                    return "battery_3_bar";

                if (Battery.level > 25)
                    return "battery_2_bar";

                if (Battery.level > 10)
                    return "battery_1_bar";

                return "battery_0_bar";
            }
            font.family: Config.iconFont
            font.pixelSize: Config.iconSize
            color: root.c
        }

        Text {
            text: Math.round(Battery.level) + "%" 
            font.family: Config.textFont
            font.pixelSize: Config.textSize
            color: root.c
        }

        Text {
            visible: !Battery.charging
            text: "(" + Battery.timeToEmpty + ")"
            font.family: Config.textFont
            font.pixelSize: Config.textSize
            color: Colors.subtle
        }

        Text {
            visible: Battery.charging
            text: "(" + Battery.timeToFull + ")"
            font.family: Config.textFont
            font.pixelSize: Config.textSize
            color: Colors.subtle
        }

    }

}
