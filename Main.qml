import QtQuick
import "UI"
import QtQuick.Controls

Window {
    id: rootWindow
    width: 1024
    height: 748
    visible: true
    flags: Qt.FramelessWindowHint | Qt.Window
    color: "transparent"
    Rectangle {
        id: bgRect
        anchors.fill: parent
        color: "#FFFFFF"
        radius: 10
        SerialPortSettingUi {
            id: sPS
            anchors.top: parent.top
            anchors.topMargin: 45
            anchors.left: parent.left
            anchors.leftMargin: 15
            width: 326
            height: 390
        }
        SendAreaUi {
            id: sA
            width: 626
            height: 340
            anchors.top: parent.top
            anchors.topMargin: 397
            anchors.left: parent.left
            anchors.leftMargin: 383
        }
        RecvAreaUi {
            id: rA
            width: 626
            height: 340
            anchors.top: parent.top
            anchors.topMargin: 45
            anchors.left: parent.left
            anchors.leftMargin: 383
        }
    }
    SerialPortTitle {
        id: title
        width: 1024
        height: 34
        anchors.top: parent.top
        anchors.left: parent.left
        DragHandler {
            onActiveChanged: if (active) {
                                 rootWindow.startSystemMove()
                             }
        }
    }
}
