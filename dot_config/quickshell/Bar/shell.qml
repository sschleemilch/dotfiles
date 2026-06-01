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
            property int spacing: 6

            screen: modelData
            implicitHeight: 52
            color: "transparent"

            anchors {
                top: true
                left: true
                right: true
            }

            margins {
                top: 5
                bottom: 0
                left: 5
                right: 5
            }

            Item {
                anchors.fill: parent

                // LEFT
                RowLayout {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: root.spacing

                    Group {
                        Layout.fillHeight: true

                        Workspaces {
                        }

                    }
                    Group {
                        Layout.fillHeight: true

                        ActiveWindow {
                        }

                    }

                }

                // CENTER
                RowLayout {
                    anchors.centerIn: parent
                    spacing: root.spacing

                    Group {
                        Layout.fillHeight: true

                        Clock {
                        }

                        Weather {
                        }
                    }

                }

                // RIGHT
                RowLayout {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: root.spacing

                    Group {
                        Layout.fillHeight: true

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

}
