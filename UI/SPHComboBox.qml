import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls

T.ComboBox {
    id: sPHComboBox

    property string role
    property string defaultText: "None"
    textRole: role
    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (!sPHComboBox.popup.opened) {
                sPHComboBox.popup.open()
                downSymbol.isOpen = true
                openAnimation.start()
            } else {
                sPHComboBox.popup.close()
                downSymbol.isOpen = false
                closeAnimation.start()
            }
        }
    }
    //自定义背景
    background: Rectangle {
        id: bg
        implicitHeight: parent.height
        implicitWidth: parent.width
        color: "#318DEF"
        opacity: 0.2
        radius: 10
    }
    //自定义下拉指示符
    indicator: Image {
        id: downSymbol
        source: "qrc:/Image/ComboBox_indicator.png"
        width: 24
        height: 24
        fillMode: Image.PreserveAspectFit
        cache: true
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        property bool isOpen: false
        RotationAnimator {
            id: openAnimation
            target: downSymbol
            direction: RotationAnimator.Counterclockwise
            from: 0
            to: 180
            duration: 300
        }
        RotationAnimator {
            id: closeAnimation
            target: downSymbol
            direction: RotationAnimator.Clockwise
            from: 180
            to: 0
            duration: 300
        }
    }
    //自定义文本显示
    contentItem: Text {
        id: cusComboBoxText
        text: qsTr(sPHComboBox.defaultText)
        font.pixelSize: 16
        font.bold: true
        elide: Text.ElideRight
        color: "black"
        font.family: "Source Han Serif CN Medium"
        verticalAlignment: Text.AlignVCenter
        leftPadding: 10
        rightPadding: sPHComboBox.indicator.width + sPHComboBox.spacing
        topPadding: 5
        bottomPadding: 5
    }
    //自定义combobox的popup
    popup: Popup {
        id: cusComboBoxPopup
        y: sPHComboBox.height
        width: sPHComboBox.width
        // 设置最大高度(这样就不会导致popup界面覆盖combobox上)
        height: Math.min(contentItem.implicitHeight, 200) // 限制最大高度为200
        padding: 1 //设置popup的内容项距离popup边距1像素
        contentItem: ListView {
            id: listView
            clip: true
            implicitHeight: contentHeight
            boundsBehavior: Flickable.StopAtBounds
            model: sPHComboBox.model
            currentIndex: sPHComboBox.highlightedIndex
            // 添加滚动条
            ScrollBar.vertical: ScrollBar {
                //滚动条不显示但是可用
                visible: false
                policy: ScrollBar.AsNeeded
            }
            delegate: ItemDelegate {
                width: cusComboBoxPopup.width
                height: 40
                highlighted: sPHComboBox.highlightedIndex === index
                //委托内容
                contentItem: Text {
                    text: role === "display" ? model.display : modelData
                    color: parent.hovered ? "white" : "#606266"
                    font.pixelSize: 14
                    font.family: "Source Han Serif CN Medium"
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 10
                }
                //委托背景
                background: Rectangle {
                    color: parent.hovered ? "#318DEF" : "white"
                    opacity: parent.hovered ? 0.4 : 1.0
                    radius: 10
                }
                onClicked: {
                    //更新自定义combobox的文本(contentItem)
                    cusComboBoxText.text = role === "display" ? model.display : modelData
                    sPHComboBox.displayText = role === "display" ? model.display : modelData
                    //更新自定义combobox当前项的索引
                    sPHComboBox.currentIndex = index
                    //关闭popup
                    cusComboBoxPopup.close()
                }
            }
        }
        //popup背景项
        background: Rectangle {
            color: "white"
            border.width: 1
            border.color: "#DCDFE6"
            radius: 10
        }
        // 添加 popup 关闭时的处理
        onClosed: {
            downSymbol.isOpen = false
            closeAnimation.start()
        }
        //进入动画
        enter: Transition {
            NumberAnimation {
                property: "opacity"
                from: 0.0
                to: 1.0
                duration: 150
            }
        }
        //关闭动画
        exit: Transition {
            NumberAnimation {
                property: "opacity"
                from: 1.0
                to: 0.0
                duration: 150
            }
        }
    }
}
