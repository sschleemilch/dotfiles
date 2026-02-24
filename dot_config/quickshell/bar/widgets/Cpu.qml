import QtQuick
import qs.common
import qs.services
import qs.components

Column {
    id: root

    anchors.horizontalCenter: parent.horizontalCenter

    visible: Dgop.available

    Meter {
        value: Dgop.cpuUsage / 100
        icon: "memory"
        color: Dgop.cpuUsage > 90 ? Colors.danger
             : Dgop.cpuUsage > 75 ? Colors.warning
             : Colors.fg
    }
}
