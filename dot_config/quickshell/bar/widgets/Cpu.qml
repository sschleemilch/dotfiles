import QtQuick
import qs.common
import qs.services
import qs.components

Column {
    id: root

    width: Colors.barWidth
    anchors.horizontalCenter: parent.horizontalCenter
    visible: Dgop.available

    FilledBar {
        value: Dgop.cpuUsage
        icon: ""
    }
}
