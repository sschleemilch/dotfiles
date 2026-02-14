pragma Singleton

import QtQuick
import Quickshell

Singleton {
    id: root

    readonly property color bar: "#1a1b26"
    readonly property color text: "#c0caf5"
    readonly property color accent: "#7aa2f7"
    readonly property color dimmed: "#565f89"
    readonly property color warning: "#e0af68"
    readonly property color danger: "#f7768e"

    readonly property string iconFont: "CommitMono Nerd Font"
    readonly property string textFont: "CommitMono Nerd Font"

    readonly property int iconSize: 16
    readonly property int textSize: 11
}
