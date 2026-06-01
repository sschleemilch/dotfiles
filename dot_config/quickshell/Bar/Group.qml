import QtQuick

Item {
    id: root

    property int padding: 8
    property int radius: 10
    property int spacing: 6
    property color color: Colors.base
    property color borderColor: Colors.highlightMed
    property real colorOpacity: 0.8
    property int borderWidth: 2
    default property alias items: row.data

    implicitWidth: row.implicitWidth + padding * 2
    implicitHeight: row.implicitHeight + padding * 2

    Rectangle {
        anchors.fill: parent
        radius: root.radius
        opacity: root.colorOpacity
        border.color: root.borderColor

        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: root.color }
            GradientStop { position: 1.0; color: Qt.lighter(root.color, 1.3) }
        }

        border.width: root.borderWidth
    }

    Row {
        id: row

        spacing: root.spacing
        x: root.padding
        anchors.verticalCenter: parent.verticalCenter
    }

}
