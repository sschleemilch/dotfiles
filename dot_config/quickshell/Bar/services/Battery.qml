import QtQuick
import Quickshell
import Quickshell.Services.UPower
pragma Singleton

Singleton {

    function formatDuration(seconds) {
        const h = Math.floor(seconds / 3600)
        const m = Math.floor((seconds % 3600) / 60)
        return h + ":" + String(m).padStart(2, "0") + "h"
    }

    readonly property bool available: batteries.length > 0

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
    readonly property string timeToEmpty: device ? formatDuration(device.timeToEmpty) : ""
    readonly property string timeToFull: device ? formatDuration(device.timeToFull) : ""
}
