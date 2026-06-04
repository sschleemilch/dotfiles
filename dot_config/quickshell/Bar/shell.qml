import QtQuick
import QtQuick.Layouts
import Quickshell

ShellRoot {
    Component.onCompleted: {
        Quickshell.watchFiles = true;
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: root

            required property var modelData

            screen: modelData
            implicitHeight: 35
            color: Colors.base

            anchors {
                top: true
                left: true
                right: true
            }

            margins {
                top: 0
                bottom: 0
                left: 0
                right: 0
            }

            Item {
                anchors.fill: parent
                anchors.leftMargin: 12
                anchors.rightMargin: 12

                // LEFT
                RowLayout {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 12


                    Workspaces {
                    }

                    ActiveWindow {
                    }


                }

                // CENTER
                RowLayout {
                    anchors.centerIn: parent
                    spacing: 12

                    Clock {
                    }

                    Weather {
                    }

                }

                // RIGHT
                RowLayout {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 16


                    Updates {
                    }

                    Brightness {
                    }

                    Sound {
                    }

                    Network {
                    }

                    Battery {
                    }


                }

            }

        }

    }

}
