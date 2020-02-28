import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.12
import QtPositioning 5.14
import QtLocation 5.14
import QtQuick.Controls.Material 2.12

Page {
    width: parent.width
    height: parent.height
    title: qsTr("Géolocalisation")

    Map {
        id: map
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        center: QtPositioning.coordinate(48.087548, -0.7580602)
        zoomLevel: 15
        copyrightsVisible: false
        plugin: Plugin {
            id: mapPlugin
            locales: "fr_FR"
            name: "mapbox"
            /*
                PluginParameter { name: "osm.mapping.cache.texture.size"; value: "50" }
                PluginParameter { name: "osm.mapping.highdpi_tiles"; value: "true" }
                */
            PluginParameter { name: "mapbox.access_token" ; value: "pk.eyJ1Ijoib2xhZnNlcmdlbnQiLCJhIjoiY2s3NHkwNGVvMHFkMzNldDBpbnpveTZ3YiJ9.j7OYZt1ll7R_2kdUCqyOyg" }
            PluginParameter { name: "mapbox.mapping.highdpi_tiles" ; value: "true" }
            PluginParameter { name: "mapbox.mapping.cache.texture.size" ; value: "50" }
        }
    }

    ToolBar {
        id: toolBar
        contentHeight: button.implicitHeight * 2
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        background: Rectangle {
            color: "#2196F3"
            opacity: 0.2
        }

        RoundButton {
            id: button
            width: parent.height * 0.8
            height: parent.height * 0.8
            Material.background: Material.Blue
            anchors.centerIn: parent
            Image {
                source: "qrc:/images/track.png"
                anchors.centerIn: parent
                width: parent.height * 0.5
                height: parent.width * 0.5
            }
        }

    }
}
