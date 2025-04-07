#include "SerialPortSendArea.h"

SerialPortSendArea::SerialPortSendArea(QObject *parent)
    : QObject{parent},timer(new QTimer(this))
{

    //初始化定时器
    timer->setTimerType(Qt::PreciseTimer);
    timer->setInterval(sendTime);
    //定时器信号触发发送数据
    connect(timer,&QTimer::timeout,this,[this](){
        this->sendData(this->data);
    });
    //更新定时器间隔
    connect(this,&SerialPortSendArea::sendTimeChanged,this,[this](){
        this->timer->setInterval(sendTime);
    });
}


QString SerialPortSendArea::getEncode() const
{
    return encode;
}

void SerialPortSendArea::setEncode(const QString &newEncode)
{
    if (encode == newEncode)
        return;
    encode = newEncode;
    Q_EMIT encodeChanged();
}

QString SerialPortSendArea::getDataFormat() const
{
    return dataFormat;
}

void SerialPortSendArea::setDataFormat(const QString &newDataFormat)
{
    if (dataFormat == newDataFormat)
        return;
    dataFormat = newDataFormat;
    Q_EMIT dataFormatChanged();
}

bool SerialPortSendArea::getIsAddLineFeed() const
{
    return isAddLineFeed;
}

void SerialPortSendArea::setIsAddLineFeed(bool newIsAddLineFeed)
{
    if (isAddLineFeed == newIsAddLineFeed)
        return;
    isAddLineFeed = newIsAddLineFeed;
    Q_EMIT isAddLineFeedChanged();
}

int SerialPortSendArea::getSendTime() const
{
    return sendTime;
}

void SerialPortSendArea::setSendTime(int newSendTime)
{
    if (sendTime == newSendTime)
        return;
    sendTime = newSendTime;
    Q_EMIT sendTimeChanged();
}

bool SerialPortSendArea::getIsTimingSend() const
{
    return isTimingSend;
}

void SerialPortSendArea::setIsTimingSend(bool newIsTimingSend)
{
    if (isTimingSend == newIsTimingSend)
        return;
    isTimingSend = newIsTimingSend;
    Q_EMIT isTimingSendChanged();
}

void SerialPortSendArea::sendData(const QString &data)
{

    if(data.isEmpty())
        return ;

    QByteArray _sendData{};
    if(encode=="UTF-8")
    {
        if(dataFormat=="文本")
        {
            _sendData=data.toUtf8();
        }
        else//十六进制发送(需要现将十六进制字符串转换为原始数据再发送)
        {
            _sendData=QByteArray::fromHex(data.toUtf8());
        }
    }else
    {
        if(dataFormat=="文本")
        {
            _sendData=data.toLocal8Bit();
        }
        else//十六进制发送(需要现将十六进制字符串转换为原始数据再发送)
        {
            _sendData=QByteArray::fromHex(data.toLocal8Bit());
        }
    }

    if(isAddLineFeed)
        _sendData+="\r\n";

    Q_EMIT requestSendData(_sendData);
}

void SerialPortSendArea::timeSend()
{
    if(isTimingSend)
        timer->start();
    else
        timer->stop();
}

QString SerialPortSendArea::getData() const
{
    return data;
}

void SerialPortSendArea::setData(const QString &newData)
{
    if (data == newData)
        return;
    data = newData;
    emit dataChanged();
}




