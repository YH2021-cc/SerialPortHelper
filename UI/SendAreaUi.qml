import QtQuick
import QtQuick.Controls.Basic

Item {
    id: sendArea
    implicitHeight: 340
    implicitWidth: 626
    Rectangle {
        id: bg
        anchors.fill: parent
        radius: 10
        color: "#318DEF"
        opacity: 0.2
    }
    Image {
        id: sendAreaIcon
        source: "qrc:/Image/sendAreaUpIcon.png"
        cache: true
        width: 32
        height: 32
        fillMode: Image.PreserveAspectFit
        anchors.top: parent.top
        anchors.topMargin: 7
        anchors.left: parent.left
        anchors.leftMargin: 10
    }

    Label {
        id: sendAreaTitleText
        text: qsTr("发送区")
        width: 66
        height: 29
        color: "#3F51B5"
        anchors.top: parent.top
        anchors.topMargin: 7
        anchors.left: parent.left
        anchors.leftMargin: 46
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 20
        font.family: "Source Han Serif CN Regular" // 思源宋体的英文名称
    }
    Rectangle {
        id: functionArea1
        width: 604
        height: 46
        radius: 10
        anchors.top: parent.top
        anchors.topMargin: 42
        anchors.left: parent.left
        anchors.leftMargin: 11
        color: "#318DEF"
        opacity: 0.2
    }
    Label {
        id: dataFormatText
        text: qsTr("数据格式")
        width: 72
        height: 26
        color: "#3F51B5"
        anchors.top: functionArea1.top
        anchors.topMargin: 10
        anchors.left: functionArea1.left
        anchors.leftMargin: 14
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 18
        font.family: "Source Han Serif CN Regular" // 思源宋体的英文名称
    }
    SPHComboBox {
        id: dataFormatComboBox
        width: 119
        height: 28
        defaultText: "文本"
        model: ["文本", "十六进制"]
        anchors.top: functionArea1.top
        anchors.topMargin: 9
        anchors.left: functionArea1.left
        anchors.leftMargin: 102
        onDisplayTextChanged: {
            serialPortEngine.sendArea.dataFormat = displayText
            if (encodeComboBox.displayText === "UTF-8") {
                if (dataFormatComboBox.displayText === "文本")
                    sendMsgArea.text = serialPortEngine.rectArea.utf8FromHex(
                                sendMsgArea.text)
                else if (dataFormatComboBox.displayText === "十六进制")
                    sendMsgArea.text = serialPortEngine.rectArea.utf8ToHex(
                                sendMsgArea.text)
                else
                    ;
            } else {
                if (dataFormatComboBox.displayText === "文本")
                    sendMsgArea.text = serialPortEngine.rectArea.gbkFromHex(
                                sendMsgArea.text)
                else if (dataFormatComboBox.displayText === "十六进制")
                    sendMsgArea.text = serialPortEngine.rectArea.gbkToHex(
                                sendMsgArea.text)
                else
                    ;
            }
        }
    }
    Label {
        id: encodeText
        text: qsTr("编码")
        width: 40
        height: 26
        color: "#3F51B5"
        anchors.top: functionArea1.top
        anchors.topMargin: 10
        anchors.left: functionArea1.left
        anchors.leftMargin: 271
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 18
        font.family: "Source Han Serif CN Regular" // 思源宋体的英文名称
    }
    SPHComboBox {
        id: encodeComboBox
        width: 119
        height: 28
        defaultText: "GBK"
        model: ["UTF-8", "GBK"]
        anchors.top: functionArea1.top
        anchors.topMargin: 9
        anchors.left: functionArea1.left
        anchors.leftMargin: 327
        onDisplayTextChanged: {
            serialPortEngine.sendArea.encode = displayText
            if (encodeComboBox.displayText === "UTF-8") {
                if (dataFormatComboBox.displayText === "文本")
                    sendMsgArea.text = serialPortEngine.rectArea.gbkToUtf8(
                                sendMsgArea.text)
                else if (dataFormatComboBox.displayText === "十六进制") {
                    sendMsgArea.text = serialPortEngine.rectArea.gbkHexToUtf8Hex(
                                sendMsgArea.text)
                } else
                    ;
            } else {
                if (dataFormatComboBox.displayText === "文本")
                    sendMsgArea.text = serialPortEngine.rectArea.utf8ToGbk(
                                sendMsgArea.text)
                else if (dataFormatComboBox.displayText === "十六进制") {
                    sendMsgArea.text = serialPortEngine.rectArea.utf8HexToGbkHex(
                                sendMsgArea.text)
                } else
                    ;
            }
        }
    }
    ScrollView {
        id: scrollView
        clip: true
        implicitWidth: 604
        implicitHeight: 123

        // 确保滚动条不显示
        ScrollBar.vertical.policy: getPolicy()

        function getPolicy() {
            if (dataFormatComboBox.displayText === "文本") {
                if (sendMsgArea.lineCount > 5)
                    return ScrollBar.AlwaysOn
            } else {
                if (sendMsgArea.lineCount > 6)
                    return ScrollBar.AlwaysOn
            }

            return ScrollBar.AlwaysOff
        }

        ScrollBar.horizontal.policy: ScrollBar.AsNeeded
        anchors.top: parent.top
        anchors.topMargin: 99
        anchors.left: parent.left
        anchors.leftMargin: 11
        TextArea {
            id: sendMsgArea
            background: Rectangle {
                color: "#FFFFFF"
                border.width: 0
                radius: 10
            }
            wrapMode: Text.WordWrap
            padding: 5
            font.pixelSize: 16
        }
    }

    SPHCheckBox {
        id: sendNewLine
        width: 80
        iconSize: 16
        text: qsTr("发送新行")
        textFont.pixelSize: 14
        textFont.family: "Source Han Serif CN Regular"
        anchors.top: parent.top
        anchors.topMargin: 224
        anchors.left: parent.left
        anchors.leftMargin: 11
        onClicked: {
            serialPortEngine.sendArea.isAddLineFeed = !serialPortEngine.sendArea.isAddLineFeed
        }
    }

    SPHCheckBox {
        id: autoSend
        width: 80
        iconSize: 16
        text: qsTr("定时发送")
        textFont.pixelSize: 14
        textFont.family: "Source Han Serif CN Regular"
        anchors.top: parent.top
        anchors.topMargin: 224
        anchors.left: sendNewLine.right
        anchors.leftMargin: 8

        onClicked: {
            //设置间隔输入框是否可用
            inputSendInterVal.enabled = !inputSendInterVal.enabled
            //开始发送
            serialPortEngine.sendArea.isTimingSend = !serialPortEngine.sendArea.isTimingSend
            serialPortEngine.sendArea.data = sendMsgArea.text
            serialPortEngine.sendArea.timeSend()
        }
    }
    TextField {
        id: inputSendInterVal
        width: 80
        height: 20
        background: Rectangle {
            color: "#FFFFFF"
            border.width: 0
            radius: 10
        }
        onEnabledChanged: {
            if (enabled)
                inputSendInterVal.color = "black"
            else
                inputSendInterVal.color = "#DCDCDC"
        }
        text: qsTr("1000")
        anchors.top: parent.top
        anchors.topMargin: 231
        anchors.left: autoSend.right
        anchors.leftMargin: 5
        padding: 3
        font.family: "Source Han Serif CN Regular"
        onEditingFinished: {
            if (Number.parseInt(displayText, 10) < 1 || Number.parseInt(
                        displayText, 10) > 1000000 || displayText === "") {
                msg.messageText = "请输入1-1000000数字"
                msg.open()
                text = "1000"
                forceActiveFocus()
            } else {
                serialPortEngine.sendArea.sendTime = text
            }
        }
    }
    Label {
        id: timeInterVal
        text: qsTr("间隔/ms")
        width: 40
        height: 26
        color: "#3F51B5"
        anchors.top: parent.top
        anchors.topMargin: 227
        anchors.left: inputSendInterVal.right
        anchors.leftMargin: 10
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 16
        font.family: "Source Han Serif CN Regular" // 思源宋体的英文名称
    }
    SPHButton {
        id: sendButton
        text: "发送"
        width: 106
        height: 36
        radius: 10
        opacity: down ? 0.7 : 1.0
        color: "#165DFF"
        textColor: "#FFFFFF"
        font.pixelSize: 20
        font.family: "Source Han Serif CN Medium"
        anchors.top: parent.top
        anchors.topMargin: 288
        anchors.left: parent.left
        anchors.leftMargin: 11
        enabled: serialPortEngine.sps.isOpened
        hoverEnable: serialPortEngine.sps.isOpened
        onClicked: {
            serialPortEngine.sendArea.sendData(sendMsgArea.text)
        }
        onHoveredChanged: {
            if (hovered)
                anchors.topMargin = anchors.topMargin - 2
            else
                anchors.topMargin = anchors.topMargin + 2
        }
    }
    SPHButton {
        id: clearButton
        text: "清空"
        width: 106
        height: 36
        radius: 10
        opacity: down ? 0.7 : 1.0
        color: "#FF7256"
        textColor: "#FFFFFF"
        font.pixelSize: 20
        font.family: "Source Han Serif CN Medium"
        anchors.top: parent.top
        anchors.topMargin: 288
        anchors.left: sendButton.right
        anchors.leftMargin: 10
        enabled: sendMsgArea.length !== 0
        hoverEnable: sendMsgArea.length !== 0
        SPHToolTip {
            id: clearButtonTip
            text: "清空发送区数据"
            width: 150
            font.bold: true
            font.pixelSize: 16
            font.family: "Source Han Serif CN Regular"
            textColor: "#FFFFFF"
            visible: clearButton.hovered
            backgroundColor: "black"
            radius: 5
            delay: 1000
        }
        onClicked: {
            sendMsgArea.clear()
        }
        onHoveredChanged: {
            if (hovered)
                anchors.topMargin = anchors.topMargin - 2
            else
                anchors.topMargin = anchors.topMargin + 2
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
