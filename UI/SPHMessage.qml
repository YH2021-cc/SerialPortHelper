import QtQuick

import QtQuick.Templates as T

//自定义类似element的消息提示控件
T.Popup {

    id: cusMessage

    //计算初始位置
    x: Math.round((parent.width - width) / 2)
    y: 0

    implicitWidth: 300
    implicitHeight: 40

    onOpened: {
        if (time.running === false)
            time.start()
    }

    //消息内容
    property string messageText: ""

    //定时,控件到该时间后自动退出(单位:毫秒)
    property int timeout: 2000

    //消息的类型
    enum Type {
        Succes,
        Warning,
        Error,
        Info
    }
    property int type

    background: Rectangle {
        id: bg
        radius: 4
        color: getColor(cusMessage.type)
        width: parent.width
        height: parent.height

        function getColor(type: int) {
            switch (type) {
            case CRRSMessage.Type.Succes:
                return "#E5FAE1"
            case CRRSMessage.Type.Warning:
                return "#FFFEE6"
            case CRRSMessage.Type.Error:
                return "#FFF2F0"
            case CRRSMessage.Type.Info:
                return "#E5F9FF"
            }
        }
    }
    Image {
        id: icon
        source: getSource(cusMessage.type)
        fillMode: Image.PreserveAspectFit
        height: 16
        width: 16
        anchors.top: parent.top
        anchors.topMargin: 12
        anchors.left: parent.left
        anchors.leftMargin: 25
        function getSource(type: int): url {
            switch (type) {
            case SPHMessage.Type.Succes:
                return "qrc:/Image/Message_Success.png"
            case SPHMessage.Type.Warning:
                return "qrc:/Image/Message_Warning.png"
            case SPHMessage.Type.Info:
                return "qrc:/Image/Message_Info.png"
            case SPHMessage.Type.Error:
                return "qrc:/Image/Message_Error.png"
            }
        }
    }
    Text {
        id: messageText
        text: qsTr(cusMessage.messageText)
        width: 168
        height: 22
        color: "#354052"
        font.pixelSize: 18
        font.bold: true
        anchors.top: parent.top
        anchors.topMargin: 9
        anchors.left: parent.left
        anchors.leftMargin: 49
    }
    // 动画
    enter: Transition {

        ParallelAnimation {
            NumberAnimation {
                property: "y"
                from: 0
                to: Math.round((parent.height - height) / 4)
                duration: 200
            }
            NumberAnimation {
                property: "opacity"
                from: 0.0
                to: 1.0
                duration: 200
            }
        }
    }

    exit: Transition {
        ParallelAnimation {
            NumberAnimation {
                property: "y"
                from: Math.round((parent.height - height) / 4)
                to: 0
                duration: 200
            }
            NumberAnimation {
                property: "opacity"
                from: 1.0
                to: 0.0
                duration: 200
            }
        }
    }
    //定时器
    Timer {
        id: time
        interval: cusMessage.timeout
        onTriggered: {
            cusMessage.close()
        }
    }
}
