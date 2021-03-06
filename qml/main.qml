import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.12
import StatusBar 0.1
//#2196F3

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Là-haut")
    color: "#2196F3"

    Timer {
        id: timer
        interval: 1000
        repeat: true
        running: true
        /*triggeredOnStart: {
        }*/
        onTriggered: {
            if(sigfox.getStatus())
            {
                sigfoxButtonImg.source = "qrc:/images/sigfox_cloud_on.png";

            }
            else
            {
                sigfoxButtonImg.source = "qrc:/images/sigfox_cloud_off.png";
            }
        }
    }


    StatusBar {
        theme: StatusBar.Dark
        color: "#087DDA"
    }

    flags: Qt.platform.os === "ios"? Qt.Window | Qt.MaximizeUsingFullscreenGeometryHint : Qt.Window

    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            Image {
                source: stackView.depth > 1 ? "qrc:/images/white/baseline_arrow_back_ios_white_18dp.png"
                                            : "qrc:/images/white/baseline_menu_white_18dp.png"
                anchors.centerIn: parent
                width: parent.height * 0.6
                height: parent.width * 0.6
            }
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1)
                {
                    stackView.pop();
                }
                else
                {
                    drawer.open();
                }
            }
        }

        Label {
            text: stackView.currentItem.title
            font.pixelSize: 20
            color: "white"
            anchors.centerIn: parent
        }

        ToolButton {
            id: sigfoxButton
            anchors.right: parent.right
            anchors.rightMargin: 5
            Image {
                id: sigfoxButtonImg
                source: "qrc:/images/sigfox_cloud_off.png"
                anchors.centerIn: parent
                width: parent.height * 0.8
                height: parent.width * 0.8
            }
            onClicked: {
                stackView.push("Login.qml");
            }
        }
    }

    Drawer {
        id: drawer
        width: window.width * 0.66
        height: window.height

        Column {
            anchors.fill: parent

            ItemDelegate {
                text: qsTr("Température")
                width: parent.width
                onClicked: {
                    stackView.push("Temperature.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Pression")
                width: parent.width
                onClicked: {
                    stackView.push("Pressure.qml");
                    drawer.close();
                }
            }
            ItemDelegate {
                text: qsTr("Altitude")
                width: parent.width
                onClicked: {
                    stackView.push("Altitude.qml");
                    drawer.close();
                }
            }
            ItemDelegate {
                text: qsTr("Géolocalisation")
                width: parent.width
                onClicked: {
                    stackView.push("Map.qml");
                    drawer.close();
                }
            }
        }
    }

    StackView {
        id: stackView
        initialItem: "Home.qml"
        anchors.fill: parent
    }
}
