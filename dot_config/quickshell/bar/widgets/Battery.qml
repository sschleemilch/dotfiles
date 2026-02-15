import QtQuick
import Quickshell.Services.UPower
import qs.components
import qs.common

Column {
    id: root
    anchors.horizontalCenter: parent.horizontalCenter

    visible: batteries.length > 0

    readonly property var batteries: {
        let devs = UPower.devices.values;
        let bats = [];
        for (let i = 0; i < devs.length; i++) {
            if (devs[i].isLaptopBattery) bats.push(devs[i]);
        }
        return bats;
    }

    readonly property var device: batteries.length > 0 ? batteries[0] : null
    readonly property int level: device ? Math.round(device.percentage * 100) : 0
    readonly property bool charging: device
        ? device.state === UPowerDeviceState.Charging
        : false
    readonly property bool pluggedIn: device
        ? device.state !== UPowerDeviceState.Discharging
        : false
    readonly property bool isLow: level <= 20 && !pluggedIn

    property color statusColor: {
        if (root.isLow) return Colors.danger;
        if (root.charging || root.pluggedIn) return Colors.accent;
        return Colors.fg;
    }

    Pie {
        value: root.level / 100
        icon: {
            if (root.charging) return "\u{f0084}";
            if (root.level > 75) return "\uf240";
            if (root.level > 50) return "\uf241";
            if (root.level > 25) return "\uf242";
            if (root.level > 5) return "\uf243";
            return "\uf244";
        }
        fg: root.statusColor
    }
}
