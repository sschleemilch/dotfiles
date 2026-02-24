import QtQuick
import qs.common
import qs.services
import qs.components

Column {
    id: root
    anchors.horizontalCenter: parent.horizontalCenter

    visible: Dgop.available

    Meter {
        value: Dgop.diskUsagePercent / 100
        icon: "hard_drive"
        color: Dgop.diskUsagePercent > 90 ? Colors.danger
             : Dgop.diskUsagePercent > 75 ? Colors.warning
             : Colors.fg
    }
}
