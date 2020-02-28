import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12

Page {
    title: qsTr("Là-haut")

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20
        Rectangle {
            id: rect1
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 10
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#7FE283" }
                GradientStop { position: 0.6; color: "#4CAF50" }
            }
            ToolButton {
                anchors.fill: parent
                onReleased: stackView.push("Temperature.qml")
            }
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "transparent"
                    Label {
                        text: "Température"
                        font.pixelSize: 20
                        color: "white"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.margins: 20
                    }
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "transparent"
                    Image {
                        source: "qrc:/images/temperature.png"
                        width: parent.height
                        height: parent.height
                    }
                    Label {
                        text: "_ _ °C"
                        anchors.right: parent.right
                        color: "white"
                        font.pixelSize: 20
                    }
                }
            }
        }
        Rectangle {
            id: rect2
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 10
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#33C4FF" }
                GradientStop { position: 0.6; color: "#0091ff" }
            }
            ToolButton {
                anchors.fill: parent
                onReleased: stackView.push("Pressure.qml")
            }
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "transparent"
                    Label {
                        text: "Pression atmosphérique"
                        font.pixelSize: 20
                        color: "white"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.margins: 20
                    }
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "transparent"
                    Image {
                        source: "qrc:/images/pressure.png"
                        width: parent.height
                        height: parent.height
                    }
                    Label {
                        text: "_ _ Pa"
                        anchors.right: parent.right
                        color: "white"
                        font.pixelSize: 20
                    }
                }
            }
        }
        Rectangle {
            id: rect3
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 10
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#4C81A9" }
                GradientStop { position: 0.6; color: "#194e76" }
            }
            ToolButton {
                anchors.fill: parent
                onReleased: stackView.push("Altitude.qml")
            }
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "transparent"
                    Label {
                        text: "Altitude"
                        font.pixelSize: 20
                        color: "white"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.margins: 20
                    }
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "transparent"
                    Image {
                        source: "qrc:/images/mountain.png"
                        width: parent.height
                        height: parent.height
                    }
                    Label {
                        text: "_ _ m"
                        anchors.right: parent.right
                        color: "white"
                        font.pixelSize: 20
                    }
                }
            }
        }
        Rectangle {
            id: rect4
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 10
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#FFDF43" }
                GradientStop { position: 0.6; color: "#eaac10" }
            }
            ToolButton {
                anchors.fill: parent
                onReleased: stackView.push("Map.qml")
            }
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "transparent"
                    Label {
                        text: "Géolocalisation"
                        font.pixelSize: 20
                        color: "white"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.margins: 20
                    }
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "transparent"
                    Image {
                        source: "qrc:/images/pin.png"
                        width: parent.height
                        height: parent.height
                    }
                }
            }
        }
    }

}
