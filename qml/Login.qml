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
                user.text = sigfox.getUser();
                pwd.text = sigfox.getPwd();
                device.text = sigfox.getDevice();
                seqNumber.text = sigfox.getSeqNumber();
        }
        onTriggered: {
            if(sigfox.getAPIaccessStatus())
            {
                device.text = sigfox.getDevice();
                seqNumber.text = sigfox.getSeqNumber();
                //sigfox.httpRequest();
            }
        }
    }


    Rectangle {
        id: login
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: status.top
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
                TextField {
                    id: user
                    anchors.centerIn: parent
                    placeholderText: qsTr("Utilisateur")
                    width: sigfoxLogo.width
                    //background: Rectangle { color: "#EEEEEE" }
                }
            }
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                TextField {
                    id: pwd
                    anchors.centerIn: parent
                    placeholderText: qsTr("Mot de passe")
                    width: sigfoxLogo.width
                    echoMode: switchPwdMode ? TextField.Normal : TextField.Password
                    //background: Rectangle { color: "#EEEEEE" }
                }
                ToolButton {
                    anchors.left: pwd.right
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
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                RoundButton {
                    id: connect
                    anchors.centerIn: parent
                    width: sigfoxLogo.width
                    height: 70
                    text: qsTr("Connexion")
                    enabled: !user.text && !pwd.text ? false : true
                    onReleased: {
                        sigfox.setCredentials(user.text, pwd.text);
                    }
                }
            }
        }
    }

    Rectangle {
        id: status
        radius: 10
        width: parent.width
        height: parent.height / 4
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 20
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#704DB3" }
            GradientStop { position: 0.6; color: "#230066" }
        }
        ToolButton {
            anchors.fill: parent
        }
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "transparent"
                Image {
                    id: deviceIcon
                    source: "qrc:/images/radio.png"
                    anchors.verticalCenter: parent.verticalCenter
                    height: parent.height / 2
                    width: parent.height / 2
                }
                Label {
                    text: qsTr("Appareil")
                    font.pixelSize: 20
                    color: "white"
                    anchors.left: deviceIcon.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.margins: 20
                }
                Text {
                    id: device
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    color: "white"
                    font.pixelSize: Qt.application.font.pixelSize
                }
            }
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "transparent"
                Image {
                    id: seqNumberIcon
                    source: "qrc:/images/seqNumber.png"
                    anchors.verticalCenter: parent.verticalCenter
                    height: parent.height / 2
                    width: parent.height / 2
                }
                Label {
                    text: qsTr("N° séquence")
                    font.pixelSize: 20
                    color: "white"
                    anchors.left: seqNumberIcon.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.margins: 20
                }
                Label {
                    id: seqNumber
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    color: "white"
                    font.pixelSize: 20
                }
            }
        }
    }
}
