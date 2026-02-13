import QtQuick
import qs.common

Item {
    id: root

    anchors.horizontalCenter: parent.horizontalCenter

    property real value: 0.0
    property int size: 24
    property string icon: ""

    property color colPrimary: Colors.text
    property color colSecondary: Colors.dimmed

    width: size
    height: size

    readonly property real clampedValue: Math.max(0, Math.min(1, value))

    Canvas {
        id: canvas
        anchors.fill: parent
        antialiasing: true

        onPaint: {
            const ctx = getContext("2d")
            ctx.reset()

            const w = width
            const h = height
            const r = Math.floor(w / 2)
            const cx = r
            const cy = r

            // ---- Background circle ----
            ctx.beginPath()
            ctx.arc(cx, cy, r, 0, Math.PI * 2)
            ctx.fillStyle = root.colSecondary
            ctx.fill()

            // ---- Filled pie ----
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
                ctx.fillStyle = root.colPrimary
                ctx.fill()
            }
        }

        Connections {
            target: root
            function onValueChanged() { canvas.requestPaint() }
            function onColPrimaryChanged() { canvas.requestPaint() }
            function onColSecondaryChanged() { canvas.requestPaint() }
        }
    }

    // ===== Center Icon / Text =====
    Text {
        anchors.centerIn: parent
        text: icon
        font.pixelSize: size * 0.55
        color: Colors.bar
    }
}
