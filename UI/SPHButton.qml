import QtQuick
import QtQuick.Controls

Rectangle {
    id: cusButton
    implicitHeight: 30
    implicitWidth: 150

    //信号
    signal clicked(eventPoint point, int button)
    signal doubleClicked(eventPoint point, int button)
    //按下属性
    property bool down: handle.pressed
    //悬浮属性
    property bool hovered: false
    property bool hoverEnable: false
    //文本属性
    property string text: qsTr("按钮")
    property color textColor: "black"
    property font font
    property int elide: Text.ElideNone
    property int fontSizeMode: Text.FixedSize
    Label {
        id: buttonText
        anchors.centerIn: parent
        text: cusButton.text
        color: cusButton.textColor
        font: cusButton.font
        elide: cusButton.elide
        fontSizeMode: cusButton.fontSizeMode
    }
    HoverHandler {

        enabled: cusButton.hoverEnable
        onHoveredChanged: {
            cusButton.hovered = !cusButton.hovered
        }
    }
    TapHandler {
        id: handle
        onSingleTapped: (eventPoint, button) => {
                            cusButton.clicked(eventPoint, button)
                        }
        onDoubleTapped: (eventPoint, button) => {
                            cusButton.doubleClicked(eventPoint, button)
                        }
    }
}
