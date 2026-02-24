import QtQuick
import qs.common
import qs.services
import qs.components

Column {
    id: root
    anchors.horizontalCenter: parent.horizontalCenter

    visible: Dgop.available

    Meter {
        value: Dgop.memoryUsage / 100
        icon: "memory_alt"
        color: Dgop.memoryUsage > 90 ? Colors.danger
             : Dgop.memoryUsage > 75 ? Colors.warning
             : Colors.fg
    }
}
