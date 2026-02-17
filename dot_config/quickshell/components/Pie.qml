import QtQuick
import qs.common

Item {
    id: root

    anchors.horizontalCenter: parent.horizontalCenter

    property real value: 0.0
    property int size: 28
    property string icon: ""

    property color fg: Colors.fg
    property color bg: Colors.dimmed

    width: size
    height: size

    readonly property real clampedValue: Math.max(0, Math.min(1, value))

    onValueChanged: canvas.requestPaint()
    onFgChanged: canvas.requestPaint()
    onBgChanged: canvas.requestPaint()

    Canvas {
        id: canvas
        anchors.fill: parent
        antialiasing: true

        onPaint: {
            const ctx = getContext("2d")
            ctx.reset()

            const r = Math.floor(width / 2)
            const cx = r
            const cy = r

            // Background
            ctx.beginPath()
            ctx.arc(cx, cy, r, 0, Math.PI * 2)
            ctx.fillStyle = root.bg
            ctx.fill()

            // Pie
            if (root.clampedValue > 0) {
                ctx.beginPath()
                ctx.moveTo(cx, cy)
                ctx.arc(
                    cx,
                    cy,
                    r,
                    -Math.PI / 2,
                    -Math.PI / 2 + (Math.PI * 2 * root.clampedValue),
                    false
                )
                ctx.closePath()
                ctx.fillStyle = root.fg
                ctx.fill()
            }
        }
    }

    Text {
        anchors.centerIn: parent
        text: icon
        font.pixelSize: size * 0.65
        font.family: Config.iconFont
        color: Colors.bg
    }
}
