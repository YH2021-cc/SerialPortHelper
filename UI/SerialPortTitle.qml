import QtQuick
import QtQuick.Controls

Item {
    id: serialPortTitleArea
    implicitHeight: 34
    implicitWidth: 1024

    Rectangle {
        id: bg
        color: "#1782F0"
        opacity: 0.2
        topLeftRadius: 10
        topRightRadius: 10
        anchors.fill: parent
    }
    Image {
        id: serialPortTitleIcon
        width: 24
        height: 24
        fillMode: Image.PreserveAspectFit
        cache: true
        source: "qrc:/Image/serialPortTitleIcon.png"
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 26
    }
    Label {
        id: serialPortTitle
        text: qsTr("串口助手")
        width: 80
        height: 28
        color: "#3F51B5"
        anchors.top: parent.top
        anchors.topMargin: 3
        anchors.left: parent.left
        anchors.leftMargin: 59
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 20
        font.family: "Source Han Serif CN Regular" // 思源宋体的英文名称
    }
    SPHIconButton {
        id: minimizedButton
        width: 24
        height: 24
        color: "transparent"
        hoverEnable: true
        source: hovered ? "qrc:/Image/serialPortTitleMinimizedIcon_ON.png" : "qrc:/Image/serialPortTitleMinimizedIcon_OFF.png"
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 953
        onClicked: {
            Window.window.showMinimized()
        }
    }
    SPHIconButton {
        id: closeButton
        width: 24
        height: 24
        color: "transparent"
        hoverEnable: true
        source: hovered ? "qrc:/Image/serialPortTitleCloseIcon_ON.png" : "qrc:/Image/serialPortTitleCloseIcon_OFF.png"
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 991
        onClicked: {
            Window.window.close()
        }
    }
}
