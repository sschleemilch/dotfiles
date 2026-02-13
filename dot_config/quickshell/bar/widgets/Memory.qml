import QtQuick
import qs.common
import qs.services
import qs.components

Column {
    id: root

    visible: Dgop.available

    CircularProgress {
        value: Dgop.memoryUsage / 100
        icon: ""
    }
}
