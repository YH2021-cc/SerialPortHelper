import QtQuick
import QtQuick.Controls

Rectangle {
    id: cusButton
    implicitHeight: 40
    implicitWidth: 40

    //信号
    signal clicked(eventPoint point, int button)
    signal doubleClicked(eventPoint point, int button)

    //悬浮属性
    property bool hovered: false
    property bool hoverEnable: false

    //按下属性
    property bool down: handle.pressed

    //图片属性
    property url source
    Image {
        id: buttonImage
        width: parent.width
        height: parent.height
        fillMode: Image.PreserveAspectFit
        source: parent.source
        cache: true
        anchors.centerIn: parent
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
