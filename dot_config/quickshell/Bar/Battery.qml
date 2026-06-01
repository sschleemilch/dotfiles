import QtQuick
import qs.services

Item {
    implicitWidth: pill.implicitWidth
    implicitHeight: pill.implicitHeight
    anchors.verticalCenter: parent.verticalCenter

    visible: Battery.available

    Group {
        id: pill

        padding: 6
        radius: 6
        spacing: 4
        borderWidth: 0
        color: Battery.low ? Colors.love : Battery.charging ? Colors.foam : Colors.rose
        colorOpacity: 1

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
            color: Colors.base
        }

        Text {
            text: Math.round(Battery.level) + "%" 
            font.family: Config.textFont
            font.pixelSize: Config.textSize
            color: Colors.base
        }

        Text {
            visible: !Battery.charging
            text: " " + Battery.timeToEmpty
            font.family: Config.textFont
            font.pixelSize: Config.textSize
            color: Colors.base
        }

        Text {
            visible: Battery.charging
            text: " " + Battery.timeToFull
            font.family: Config.textFont
            font.pixelSize: Config.textSize
            color: Colors.base
        }

    }

}
