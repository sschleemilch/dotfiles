import QtQuick
import qs.common
import qs.services
import qs.components

Column {
    id: root

    visible: Dgop.available

    CircularProgress {
        value: Dgop.diskUsagePercent / 100
        icon: "󰋊"
    }
    // One {
    //     value: Dgop.diskUsagePercent / 100
    //     // icon: "󰋊"
    // }
    // Two {
    //     value: Dgop.diskUsagePercent / 100
    //     // icon: "󰋊"
    // }
    // Three {
    //     value: Dgop.diskUsagePercent / 100
    //     // icon: "󰋊"
    // }
    // Four {
    //     value: Dgop.diskUsagePercent / 100
    //     // icon: "󰋊"
    // }
    // Five {
    //     value: Dgop.diskUsagePercent / 100
    //     // icon: "󰋊"
    // }
}
