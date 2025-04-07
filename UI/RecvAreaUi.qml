import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Dialogs

Item {
    id: recvArea
    implicitHeight: 340
    implicitWidth: 626
    Rectangle {
        id: bg
        anchors.fill: parent
        radius: 10
        color: "#318DEF"
        opacity: 0.2 // 仅背景透明
    }

    Image {
        id: recvAreaIcon
        source: "qrc:/Image/recvAreaDownIcon.png"
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
        id: recvAreaTitleText
        text: qsTr("接收区")
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
            serialPortEngine.rectArea.dataFormat = displayText
            if (encodeComboBox.displayText === "UTF-8") {
                if (dataFormatComboBox.displayText === "文本")
                    recvMsgArea.text = serialPortEngine.rectArea.utf8FromHex(
                                recvMsgArea.text)
                else if (dataFormatComboBox.displayText === "十六进制")
                    recvMsgArea.text = serialPortEngine.rectArea.utf8ToHex(
                                recvMsgArea.text)
                else
                    ;
            } else {
                if (dataFormatComboBox.displayText === "文本")
                    recvMsgArea.text = serialPortEngine.rectArea.gbkFromHex(
                                recvMsgArea.text)
                else if (dataFormatComboBox.displayText === "十六进制")
                    recvMsgArea.text = serialPortEngine.rectArea.gbkToHex(
                                recvMsgArea.text)
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
            serialPortEngine.rectArea.encode = displayText
            if (encodeComboBox.displayText === "UTF-8") {
                if (dataFormatComboBox.displayText === "文本")
                    recvMsgArea.text = serialPortEngine.rectArea.gbkToUtf8(
                                recvMsgArea.text)
                else if (dataFormatComboBox.displayText === "十六进制") {
                    recvMsgArea.text = serialPortEngine.rectArea.gbkHexToUtf8Hex(
                                recvMsgArea.text)
                } else
                    ;
            } else {
                if (dataFormatComboBox.displayText === "文本")
                    recvMsgArea.text = serialPortEngine.rectArea.utf8ToGbk(
                                recvMsgArea.text)
                else if (dataFormatComboBox.displayText === "十六进制") {
                    recvMsgArea.text = serialPortEngine.rectArea.utf8HexToGbkHex(
                                recvMsgArea.text)
                } else
                    ;
            }
        }
    }
    Rectangle {
        id: functionArea2
        width: 604
        height: 46
        radius: 10
        anchors.top: parent.top
        anchors.topMargin: 91
        anchors.left: parent.left
        anchors.leftMargin: 11
        color: "#318DEF"
        opacity: 0.2
    }
    Row {
        id: toolBar
        anchors.fill: functionArea2
        padding: 11
        spacing: 10
        SPHIconButton {
            id: saveButton
            width: 24
            height: 24
            color: "transparent"
            border.width: 0
            hoverEnable: true
            source: "qrc:/Image/recvAreaSaveIcon.png"
            property url filePath: chooseFile.selectedFile

            SPHToolTip {
                id: saveButtonTip
                text: "保存数据到文件"
                width: 130
                font.bold: true
                font.pixelSize: 16
                font.family: "Source Han Serif CN Regular"
                visible: saveButton.hovered
                backgroundColor: "black"
                radius: 5
            }
            FileDialog {
                id: chooseFile
                nameFilters: [//只显示.txt文件
                    "Text files (*.txt)"]
                onAccepted: {
                    serialPortEngine.rectArea.writeDataToFile(
                                saveButton.filePath, recvMsgArea.text)
                }
            }

            onClicked: {
                chooseFile.open()
            }
            onHoveredChanged: {
                if (hovered)
                    saveButton.y -= 2
                else
                    saveButton.y += 2
            }
        }
        SPHIconButton {
            id: timeButton
            width: 24
            height: 24
            color: "transparent"
            border.width: 0
            hoverEnable: true
            source: "qrc:/Image/recvAreaTimeIcon_OFF.png"
            SPHToolTip {
                id: timeButtonTip
                text: "添加时间戳"
                width: 110
                font.bold: true
                font.pixelSize: 16
                font.family: "Source Han Serif CN Regular"
                textColor: "#FFFFFF"
                visible: timeButton.hovered
                backgroundColor: "black"
                radius: 5
            }
            onClicked: {
                timeButton.source = (timeButton.source === Qt.resolvedUrl(
                                         "qrc:/Image/recvAreaTimeIcon_OFF.png") ? "qrc:/Image/recvAreaTimeIcon_ON.png" : "qrc:/Image/recvAreaTimeIcon_OFF.png")
                //其他操作
                serialPortEngine.rectArea.isAddDateTime = !serialPortEngine.rectArea.isAddDateTime
            }
            onHoveredChanged: {
                if (hovered)
                    timeButton.y -= 2
                else
                    timeButton.y += 2
            }
        }
        SPHIconButton {
            id: clearButton
            width: 24
            height: 24
            color: "transparent"
            border.width: 0
            hoverEnable: true
            source: "qrc:/Image/recvAreaClearIcon.png"
            SPHToolTip {
                id: clearButtonTip
                text: "清空数据区域"
                width: 130
                font.bold: true
                font.pixelSize: 16
                font.family: "Source Han Serif CN Regular"
                textColor: "#FFFFFF"
                visible: clearButton.hovered
                backgroundColor: "black"
                radius: 5
            }
            onClicked: {
                recvMsgArea.clear()
                //其他操作
            }
            onHoveredChanged: {
                if (hovered)
                    clearButton.y -= 2
                else
                    clearButton.y += 2
            }
        }
    }
    ScrollView {
        id: scrollView
        clip: true
        implicitWidth: 604
        implicitHeight: 186
        // 确保滚动条不显示
        ScrollBar.vertical.policy: getPolicy()

        function getPolicy() {
            if (dataFormatComboBox.displayText === "文本") {
                if (recvMsgArea.lineCount > 8)
                    return ScrollBar.AlwaysOn
            } else {
                if (recvMsgArea.lineCount > 9)
                    return ScrollBar.AlwaysOn
            }

            return ScrollBar.AlwaysOff
        }
        ScrollBar.horizontal.policy: ScrollBar.AsNeeded
        anchors.top: parent.top
        anchors.topMargin: 148
        anchors.left: parent.left
        anchors.leftMargin: 11
        TextArea {
            id: recvMsgArea
            background: Rectangle {
                color: "#FFFFFF"
                border.width: 0
                radius: 10
            }
            wrapMode: TextArea.WordWrap // 确保文本换行
            padding: 5
            font.pixelSize: 16
            readOnly: true
            Connections {
                id: serialPortInfoConnection
                target: serialPortEngine.rectArea
                function onSerialPortInfoChanged() {
                    recvMsgArea.insert(recvMsgArea.length,
                                       serialPortEngine.rectArea.serialPortInfo)
                    recvMsgArea.cursorPosition = recvMsgArea.length
                }
            }
        }
        Connections {
            id: errorInfohandle
            target: serialPortEngine.rectArea
            function onErrorMessage(errorInfo) {
                msg.messageText = errorInfo
                msg.open()
            }
        }
        Connections {
            id: dataWriteFinish
            target: serialPortEngine.rectArea
            function onDataWriteToFileFinish() {
                msg.messageText = "数据写入文件已完成!"
                msg.type = SPHMessageBox.Type.Succes
                msg.open()
            }
        }
        SPHMessageBox {
            id: msg
            type: SPHMessageBox.Type.Error
            width: 700
            margin: 602
            onClicked: {
                msg.close()
            }
            modal: true
            closePolicy: Popup.NoAutoClose
        }
    }
}
