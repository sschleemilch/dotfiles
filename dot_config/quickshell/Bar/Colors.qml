import QtQuick
import Quickshell
pragma Singleton

Singleton {
    readonly property color surface: "#1f1d2e"
    readonly property color textMuted: "#6e6a86"
    readonly property color textSecondary: "#908caa"
    readonly property color textPrimary: "#e0def4"
    readonly property color statusCritical: "#eb6f92"
    readonly property color statusWarning: "#f6c177"
    readonly property color statusPositive: "#9ccfd8"
    readonly property color batteryNormal: "#ebbcba"
    readonly property color batteryCharging: "#9ccfd8"
    readonly property color batteryCritical: "#eb6f92"
    readonly property color temperatureCool: "#c4a7e7"
    readonly property color temperatureWarm: "#f6c177"
    readonly property color temperatureHot: "#eb6f92"
    readonly property color updatesAvailable: "#9ccfd8"
    readonly property color networkDisconnected: "#eb6f92"
}
