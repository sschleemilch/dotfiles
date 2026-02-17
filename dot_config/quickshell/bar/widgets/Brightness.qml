import QtQuick
import qs.components
import qs.common
import qs.services as Services

Column {
    id: root
    anchors.horizontalCenter: parent.horizontalCenter

    visible: Services.Brightness.available

    Pie {
        value: Services.Brightness.level / 100
        icon: "brightness_6"

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.NoButton

            onWheel: event => {
                if (event.angleDelta.y > 0) {
                    Services.Brightness.increase();
                } else if (event.angleDelta.y < 0) {
                    Services.Brightness.decrease();
                }
            }
        }
    }

}
