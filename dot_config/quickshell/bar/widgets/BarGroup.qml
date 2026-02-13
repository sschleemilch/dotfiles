import QtQuick
import qs.common

Item {
    id: root

    anchors.horizontalCenter: parent.horizontalCenter

    property real padding: 6
    property real borderWidth: 1
    property color borderColor: Colors.dimmed
    property color backgroundColor: "transparent"
    property real radius: width / 2
    property real spacing: 10

    // Fixed width based on bar width with margin for border visibility
    implicitWidth: Colors.barWidth - 12
    implicitHeight: column.implicitHeight + padding * 2

    default property alias children: column.children

    Rectangle {
        anchors.fill: parent
        color: root.backgroundColor
        border.width: root.borderWidth
        border.color: root.borderColor
        radius: root.radius
    }

    Column {
        id: column
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing: root.spacing
    }
}
