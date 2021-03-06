import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.12
import QtPositioning 5.14
import QtLocation 5.14
import Qt.labs.location 1.0
import QtQuick.Controls.Material 2.12

Page {
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
        // Itinerary
        MapPolyline {
            line.width: 4
            line.color: "#673AB7"
            path: [
                { latitude: 48.08774, longitude: -0.75590 },
                { latitude: 48.08522, longitude: -0.75163 },
                { latitude: 48.08680, longitude: -0.74795 },
                { latitude: 48.08336, longitude: -0.74605 }
            ]
        }
        // Starting
        MapCircle {
            center {
                latitude: 48.08774
                longitude: -0.75590
            }
            radius: 30
            color: "white"
            border.width: 3
            border.color: "#673AB7"
        }
        MapQuickItem {
            id: markerStarting
            coordinate: QtPositioning.coordinate(48.08774, -0.75590)
            anchorPoint.x: col1.width / 2
            anchorPoint.y: col1.height
            sourceItem: Column {
                id: col1
                Text {
                    text: "Départ"
                    anchors.horizontalCenter: parent.horizontalCenter
                    style: Text.Outline; styleColor: "white"
                    font.pointSize: 24
                }
                Image {
                    source: "qrc:/images/place.png"
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: 60
                    width: 60
                }
            }
        }
        // Ending
        MapCircle {
            center {
                latitude: 48.08336
                longitude: -0.74605
            }
            radius: 30
            color: "white"
            border.width: 3
            border.color: "#673AB7"
        }
        MapQuickItem {
            id: markerEnding
            coordinate: QtPositioning.coordinate(48.08336, -0.74605)
            anchorPoint.x: col2.width / 2
            anchorPoint.y: col2.height
            sourceItem: Column {
                id: col2
                Text {
                    text: "Ballon-sonde"
                    anchors.horizontalCenter: parent.horizontalCenter
                    style: Text.Outline; styleColor: "white"
                    font.pointSize: 20
                }
                Image {
                    source: "qrc:/images/place.png"
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: 60
                    width: 60
                }
            }
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
