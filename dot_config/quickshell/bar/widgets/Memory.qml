import QtQuick
import qs.common
import qs.services
import qs.components

Column {
    id: root
    anchors.horizontalCenter: parent.horizontalCenter

    visible: Dgop.available

    Pie {
        value: Dgop.memoryUsage / 100
        icon: "memory_alt"
    }
}
