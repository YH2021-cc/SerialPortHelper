import QtQuick
import QtQuick.Controls

Item {
    implicitHeight: 390
    implicitWidth: 326

    Rectangle {
        id: bg
        anchors.fill: parent
        radius: 10
        color: "#318DEF"
        opacity: 0.1 // 仅背景透明
    }

    Image {
        id: serialPortIcon
        source: "qrc:/Image/serialPortIcon.png"
        cache: true
        width: 32
        height: 32
        fillMode: Image.PreserveAspectFit
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 17
    }

    Label {
        id: serialPortTitleText
        text: qsTr("串口配置")
        width: 80
        height: 29
        color: "#3F51B5"
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 53
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 20
        font.family: "Source Han Serif CN Regular" // 思源宋体的英文名称
    }
    Label {
        id: serialPortText
        text: qsTr("串口")
        width: 36
        height: 26
        color: "#3F51B5"
        anchors.top: parent.top
        anchors.topMargin: 60
        anchors.left: parent.left
        anchors.leftMargin: 17
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 18
        font.family: "Source Han Serif CN Medium" // 思源宋体的英文名称
    }
    Label {
        id: baudRateText
        text: qsTr("波特率")
        width: 54
        height: 26
        color: "#3F51B5"
        anchors.top: parent.top
        anchors.topMargin: 104
        anchors.left: parent.left
        anchors.leftMargin: 17
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 18
        font.family: "Source Han Serif CN Medium" // 思源宋体的英文名称
    }
    Label {
        id: dataBitText
        text: qsTr("数据位")
        width: 54
        height: 26
        color: "#3F51B5"
        anchors.top: parent.top
        anchors.topMargin: 148
        anchors.left: parent.left
        anchors.leftMargin: 17
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 18
        font.family: "Source Han Serif CN Medium" // 思源宋体的英文名称
    }
    Label {
        id: stopBitText
        text: qsTr("停止位")
        width: 54
        height: 26
        color: "#3F51B5"
        anchors.top: parent.top
        anchors.topMargin: 192
        anchors.left: parent.left
        anchors.leftMargin: 17
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 18
        font.family: "Source Han Serif CN Medium" // 思源宋体的英文名称
    }
    Label {
        id: checkoutBitText
        text: qsTr("校验位")
        width: 54
        height: 26
        color: "#3F51B5"
        anchors.top: parent.top
        anchors.topMargin: 236
        anchors.left: parent.left
        anchors.leftMargin: 17
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 18
        font.family: "Source Han Serif CN Medium" // 思源宋体的英文名称
    }
    Label {
        id: streamCtrlText
        text: qsTr("流控制")
        width: 54
        height: 26
        color: "#3F51B5"
        anchors.top: parent.top
        anchors.topMargin: 280
        anchors.left: parent.left
        anchors.leftMargin: 17
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 18
        font.family: "Source Han Serif CN Medium" // 思源宋体的英文名称
    }
    SPHComboBox {
        id: serialPortComboBox
        width: 150
        height: 36
        anchors.top: parent.top
        anchors.topMargin: 55
        anchors.left: parent.left
        anchors.leftMargin: 108
        model: serialPortEngine.sps.portInfo
        role: "display"
        onCurrentIndexChanged: {
            serialPortEngine.sps.setPort(displayText)
        }
    }
    Image {
        id: seriPortUpdate
        source: "qrc:/Image/serialPortUpdateIcon.png"
        width: 28
        height: 28
        fillMode: Image.PreserveAspectFit
        cache: true
        anchors.top: parent.top
        anchors.topMargin: 59
        anchors.left: parent.left
        anchors.leftMargin: 278
        TapHandler {
            onTapped: {
                rotationAnimation.start()
                serialPortEngine.sps.updatePort()
            }
        }
        RotationAnimator {
            id: rotationAnimation
            target: seriPortUpdate
            direction: RotationAnimator.Clockwise
            from: 0
            to: 360
            duration: 500
        }
    }
    SPHComboBox {
        id: baudRateComboBox
        width: 198
        height: 36
        anchors.top: parent.top
        anchors.topMargin: 99
        anchors.left: parent.left
        anchors.leftMargin: 108
        model: [1200, 2400, 4800, 9600, 19200, 38400, 57600, 115200]
        role: "modelData"
        onCurrentIndexChanged: {
            serialPortEngine.sps.setBaudRate(model[currentIndex])
        }
    }
    SPHComboBox {
        id: dataBitComboBox
        width: 198
        height: 36
        anchors.top: parent.top
        anchors.topMargin: 143
        anchors.left: parent.left
        anchors.leftMargin: 108
        model: [5, 6, 7, 8]
        role: "modelData"
        onCurrentIndexChanged: {
            serialPortEngine.sps.setDataBits(model[currentIndex])
        }
    }
    SPHComboBox {
        id: stopBitComboBox
        width: 198
        height: 36
        anchors.top: parent.top
        anchors.topMargin: 187
        anchors.left: parent.left
        anchors.leftMargin: 108
        model: ["1", "1.5", "2"]
        role: "modelData"
        onCurrentIndexChanged: {
            serialPortEngine.sps.setStopBits(model[currentIndex])
        }
    }
    SPHComboBox {
        id: checkoutBitComboBox
        width: 198
        height: 36
        anchors.top: parent.top
        anchors.topMargin: 231
        anchors.left: parent.left
        anchors.leftMargin: 108
        model: [0, 2, 3, 4, 5]
        role: "modelData"
        onCurrentIndexChanged: {
            serialPortEngine.sps.setParity(model[currentIndex])
        }
    }
    SPHComboBox {
        id: streamCtrlComboBox
        width: 198
        height: 36
        anchors.top: parent.top
        anchors.topMargin: 275
        anchors.left: parent.left
        anchors.leftMargin: 108
        model: [0, 1, 2]
        role: "modelData"
        onCurrentIndexChanged: {
            serialPortEngine.sps.setFlowControl(model[currentIndex])
        }
    }
    SPHButton {
        id: button
        width: 306
        height: 40
        color: "#3F51B5"
        text: serialPortEngine.sps.isOpened ? "关闭串口" : "打开串口"
        textColor: "#FFFFFF"
        font.pixelSize: 20
        font.family: "Source Han Serif CN Medium"
        anchors.top: parent.top
        anchors.topMargin: 339
        anchors.left: parent.left
        anchors.leftMargin: 10
        radius: 10
        opacity: down ? 0.7 : 1.0
        hoverEnable: true
        onClicked: {
            //如果串口未打开
            if (!serialPortEngine.sps.isOpened)
                serialPortEngine.sps.openSerialPort() //打开串口
            else {
                //如果串口已打开
                serialPortEngine.sps.closeSerialPort() //关闭串口
            }
        }
        onHoveredChanged: {
            if (hovered)
                anchors.topMargin = anchors.topMargin - 2
            else
                anchors.topMargin = anchors.topMargin + 2
        }
    }
    Connections {
        id: errorInfohandle
        target: serialPortEngine.sps
        function onSettingError(errorInfo) {
            msg.messageText = errorInfo
            msg.open()
        }
    }

    SPHMessageBox {
        id: msg
        type: SPHMessageBox.Type.Error
        width: 500
        onClicked: {
            msg.close()
        }
        modal: true
        closePolicy: Popup.NoAutoClose
    }
}
