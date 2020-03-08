import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

Page {
    title: qsTr("Accès API")

    property bool switchPwdMode: false

    Timer {
        id: timer
        interval: 10000
        repeat: true
        running: true
        triggeredOnStart: {
                device.text = sigfox.getDevice();
                seqNumber.text = sigfox.getSeqNumber();
        }
        onTriggered: {
            if(sigfox.getAPIaccessStatus())
            {
                device.text = sigfox.getDevice();
                seqNumber.text = sigfox.getSeqNumber();
                sigfox.httpRequest();
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        Rectangle {
            id: login
            Layout.fillWidth: true
            Layout.fillHeight: true
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 20
                Rectangle {
                    id: img
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Image {
                        id: sigfoxLogo
                        source: "qrc:/images/sigfox_logo.png"
                        anchors.centerIn: parent
                        width: parent.width > parent.height ? parent.height * 2.83 : parent.width
                        height: parent.width > parent.height ? parent.height : parent.width / 2.83
                    }
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Rectangle {
                        id: borderUser
                        anchors.centerIn: parent
                        color: "#EEEEEE"
                        border.width: 1
                        border.color: "#EEEEEE"
                        radius: height / 2
                        width: pwd.width * 1.3
                        height: pwd.height * 1.3
                        TextField {
                            id: user
                            anchors.centerIn: parent
                            placeholderText: qsTr("Utilisateur")
                            width: sigfoxLogo.width
                            //background: Rectangle { color: "#EEEEEE" }
                        }
                    }
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Rectangle {
                        id: borderPwd
                        anchors.centerIn: parent
                        color: "#EEEEEE"
                        border.width: 1
                        border.color: "#EEEEEE"
                        radius: height / 2
                        width: pwd.width * 1.3
                        height: pwd.height * 1.3
                        TextField {
                            id: pwd
                            anchors.centerIn: parent
                            placeholderText: qsTr("Mot de passe")
                            width: sigfoxLogo.width
                            echoMode: switchPwdMode ? TextField.Normal : TextField.Password
                            //background: Rectangle { color: "#EEEEEE" }
                        }
                        ToolButton {
                            anchors.right: parent.right
                            anchors.verticalCenter: pwd.verticalCenter
                            Image {
                                id: hidePwd
                                source: "qrc:/images/hide.png"
                                anchors.centerIn: parent
                                width: parent.height * 0.5
                                height: parent.height * 0.5
                            }
                            onClicked: {
                                switchPwdMode = !switchPwdMode;
                            }
                        }
                    }
                }
            }

        }
        Rectangle {
            id: status
            Layout.fillWidth: true
            Layout.fillHeight: true
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 0
                spacing: 0
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Button {
                        id: connect
                        anchors.centerIn: parent
                        width: sigfoxLogo.width
                        height: 70
                        text: qsTr("Connexion")
                        enabled: !user.text && !pwd.text ? false : true
                        onReleased: {
                            sigfox.setCredentials(user.text, pwd.text);
                        }
                        //background: Rectangle {color: "#2196F3" }
                    }
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "#230066"
                    Image {
                        id: deviceIcon
                        source: "qrc:/images/radio.png"
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height / 4
                        width: parent.height / 4
                        x: 20
                    }
                    Text {
                        anchors.left: deviceIcon.right
                        anchors.leftMargin: 20
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("Appareil :")
                        color: "white"
                        font.pixelSize: Qt.application.font.pixelSize
                    }
                    Text {
                        id: device
                        anchors.right: parent.right
                        anchors.rightMargin: 50
                        anchors.verticalCenter: parent.verticalCenter
                        color: "white"
                        font.pixelSize: Qt.application.font.pixelSize
                    }
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "#230066"
                    Image {
                        id: seqNumberIcon
                        source: "qrc:/images/seqNumber.png"
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height / 4
                        width: parent.height / 4
                        x: 20
                    }
                    Text {
                        anchors.left: seqNumberIcon.right
                        anchors.leftMargin: 20
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("N° séquence :")
                        color: "white"
                        font.pixelSize: Qt.application.font.pixelSize
                    }
                    Text {
                        id: seqNumber
                        anchors.right: parent.right
                        anchors.rightMargin: 50
                        anchors.verticalCenter: parent.verticalCenter
                        color: "white"
                        font.pixelSize: Qt.application.font.pixelSize
                    }
                }
            }
        }
    }
}
