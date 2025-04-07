import QtQuick
import QtQuick.Controls

ToolTip {
    id: cusToolTip
    implicitHeight: 30
    implicitWidth: 100
    property color backgroundColor: "black"
    property int radius: 0
    property color textColor: "white"
    background: Rectangle {
        id: bg
        radius: cusToolTip.radius
        color: cusToolTip.backgroundColor
        opacity: cusToolTip.opacity
    }
    contentItem: Label {
        id: cusToolTipText
        text: qsTr(cusToolTip.text)
        color: cusToolTip.textColor
        font: cusToolTip.font
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
}
