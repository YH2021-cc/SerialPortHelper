import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls

//自定义消息框
T.Popup {

    id: cusMessageBox

    //消息框内容
    property string messageText: ""

    enum Type {
        Succes,
        Warning,
        Error,
        Info
    }

    //消息框类型
    property int type

    implicitHeight: 145
    implicitWidth: 400

    property int margin: 402

    //信号
    //确定按钮点击信号
    signal clicked

    //背景
    background: Rectangle {
        width: parent.width
        height: parent.height
        radius: 6
        color: "#FFFFFF"
        border.color: "#316def"
    }
    //图标
    Image {
        id: typeIcon
        source: getSource(cusMessageBox.type)
        fillMode: Image.PreserveAspectFit
        antialiasing: true
        sourceSize.width: 16
        sourceSize.height: 16
        anchors.top: parent.top
        anchors.topMargin: 24
        anchors.left: parent.left
        anchors.leftMargin: 24
        function getSource(type: int): url {
            switch (type) {
            case SPHMessageBox.Type.Succes:
                return "qrc:/Image/Message_Success.png"
            case SPHMessageBox.Type.Warning:
                return "qrc:/Image/Message_Warning.png"
            case SPHMessageBox.Type.Info:
                return "qrc:/Image/Message_Info.png"
            case SPHMessageBox.Type.Error:
                return "qrc:/Image/Message_Error.png"
            }
        }
    }
    //标题
    Text {
        id: title
        width: 278
        height: 24
        text: qsTr(getTitle(cusMessageBox.type))
        font.pixelSize: 20
        font.bold: true
        anchors.top: parent.top
        anchors.topMargin: 18
        anchors.left: parent.left
        anchors.leftMargin: 52
        color: "#000000"
        function getTitle(type: int): string {
            switch (type) {
            case SPHMessageBox.Type.Succes:
                return "成功"
            case SPHMessageBox.Type.Warning:
                return "警告"
            case SPHMessageBox.Type.Info:
                return "信息"
            case SPHMessageBox.Type.Error:
                return "错误"
            }
        }
    }
    //解释
    Text {
        id: describe
        width: 328
        height: 21
        text: qsTr(cusMessageBox.messageText)
        font.pixelSize: 18
        color: "#616161"

        anchors.top: parent.top
        anchors.topMargin: 52
        anchors.left: parent.left
        anchors.leftMargin: 52
    }

    //按钮1
    SPHButton {
        id: confirmButton
        width: 74
        height: 32
        radius: 8
        text: qsTr("确定")
        color: down ? Qt.lighter("#00BC70") : "#00BC70"
        opacity: down ? 0.7 : 1
        font.pixelSize: 18
        font.bold: true
        anchors.top: parent.top
        anchors.topMargin: 89
        anchors.left: parent.left
        anchors.leftMargin: cusMessageBox.margin
        onClicked: {
            cusMessageBox.clicked()
        }
    }

    // 动画
    enter: Transition {
        NumberAnimation {
            property: "opacity"
            from: 0.0
            to: 1.0
            duration: 200
        }
    }

    exit: Transition {
        NumberAnimation {
            property: "opacity"
            from: 1.0
            to: 0.0
            duration: 200
        }
    }
    // 设置居中
    anchors.centerIn: Overlay.overlay
    //背景遮罩
    Overlay.modal: Rectangle {
        radius: 6
        color: "#000000"
        opacity: 0.5
    }
}
