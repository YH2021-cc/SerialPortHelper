import QtQuick
import QtQuick.Controls

Item {
    id: cusCheckBox
    implicitHeight: 36
    implicitWidth: 80

    property bool checked: false
    property string text: ""
    property font textFont
    property int iconSize: 0

    //悬浮
    property bool hovered: false
    property bool hoveredEnabled: false

    //信号
    signal clicked(eventPoint point, int button)

    Image {
        id: checkboxImage
        width: iconSize
        height: iconSize
        cache: true
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: cusCheckBox.verticalCenter
        source: cusCheckBox.checked ? "qrc:/Image/CheckBox_ON.png" : "qrc:/Image/CheckBox_OFF.png"
    }
    Label {
        id: cusCheckBoxText
        text: cusCheckBox.text
        font: cusCheckBox.textFont
        anchors.left: checkboxImage.right
        elide: Text.ElideRight
        anchors.leftMargin: 2
        anchors.verticalCenter: checkboxImage.verticalCenter
        color: cusCheckBox.checked ? "#3f51b5" : "#000000"
    }
    TapHandler {

        onSingleTapped: (point, button) => {
                            cusCheckBox.clicked(point, button)
                            cusCheckBox.checked = !cusCheckBox.checked
                        }
    }
    HoverHandler {
        enabled: cusCheckBox.hoveredEnabled
        onHoveredChanged: {
            cusCheckBox.hovered = !cusCheckBox.hovered
        }
    }
}
