#include "SerialPortRecvArea.h"

SerialPortRecvArea::SerialPortRecvArea(QObject *parent)
    : QObject{parent}
{
}

bool SerialPortRecvArea::getIsAddDateTime() const
{
    return isAddDateTime;
}

void SerialPortRecvArea::setIsAddDateTime(bool newIsAddDateTime)
{
    if (isAddDateTime == newIsAddDateTime)
        return;
    isAddDateTime = newIsAddDateTime;
    Q_EMIT isAddDateTimeChanged();
}

void SerialPortRecvArea::writeDataToFile(const QUrl &filePath,const QString &data)
{
    //检查文件是否存在
    if(!QFile::exists(filePath.toLocalFile()))
    {
        auto info=std::source_location::current();
        auto errorInfo=QString{"文件名: "}+ QString{info.file_name()}+"\n行号: "
                         +QString::number(info.line())+"\n原因: "
                         +QString{"文件不存在!"};
        Q_EMIT errorMessage(errorInfo);
        return ;
    }

    //打开文件
    QFile file{filePath.toLocalFile(),this};
    if (!file.open(QIODevice::Append | QIODevice::Text)) {
        auto info=std::source_location::current();
        auto errorInfo=QString{"文件名: "}+ QString{info.file_name()}+"\n行号: "
                         +QString::number(info.line())+"\n原因: "
                         +QString{"Failed to open file for writing!"};
        Q_EMIT errorMessage(errorInfo);
        file.close();
        return;
    }
    QTextStream out(&file);
    out<<data;

    file.close();

    Q_EMIT dataWriteToFileFinish();
    return;
}

void SerialPortRecvArea::getPortData(const QByteArray &data)
{
    if(data.isEmpty())
    {
        return;
    }

    if(encode=="UTF-8")
    {
        if(dataFormat=="文本")
        {
            serialPortInfo=QString::fromUtf8(data);
        }
        else//十六进制显示
        {
            serialPortInfo=QString::fromUtf8(data.toHex(' ')).toUpper()+' ';
        }
    }else
    {
        if(dataFormat=="文本")
        {
            serialPortInfo=QString::fromLocal8Bit(data);
        }
        else//十六进制显示
        {
            serialPortInfo=QString::fromLocal8Bit(data.toHex(' ')).toUpper()+' ';
        }
    }


    //是否添加时间戳
    if(isAddDateTime)
    {
        serialPortInfo="["+QDateTime::currentDateTime().toString("hh:mm:ss.zzz")+"]"+" "+serialPortInfo;
    }

    Q_EMIT serialPortInfoChanged();

}

QString SerialPortRecvArea::utf8ToHex(const QString &str)
{
    if(str.isEmpty())
    {
        return QString{};
    }
    auto hex=str.toUtf8().toHex(' ');
    return QString::fromUtf8(hex).toUpper();
}

QString SerialPortRecvArea::gbkToHex(const QString &str)
{
    if(str.isEmpty())
    {
        return QString{};
    }

    auto hex=str.toLocal8Bit().toHex(' ');
    return QString::fromLocal8Bit(hex).toUpper();
}

QString SerialPortRecvArea::utf8FromHex(const QString &str)
{
    if(str.isEmpty())
    {
        return QString{};
    }
    //警告:fromhex会删除空格换行等造成数据不一致
    auto text=QByteArray::fromHex(str.toLower().toUtf8());
    return QString::fromUtf8(text);
}

QString SerialPortRecvArea::gbkFromHex(const QString &str)
{
    if(str.isEmpty())
    {
        return QString{};
    }
    auto text=QByteArray::fromHex(str.toLower().toLocal8Bit());
    return QString::fromLocal8Bit(text);
}

QString SerialPortRecvArea::gbkToUtf8(const QString &str)
{
    if(str.isEmpty())
    {
        return QString{};
    }
    return QString::fromUtf8(str.toUtf8());
}

QString SerialPortRecvArea::utf8ToGbk(const QString &str)
{
    if(str.isEmpty())
    {
        return QString{};
    }
    return QString::fromLocal8Bit(str.toLocal8Bit());
}

QString SerialPortRecvArea::gbkHexToUtf8Hex(const QString &str)
{
    if(str.isEmpty())
    {
        return QString{};
    }
    //1.将16进制gbkqstring转换为16进制gbkQbytearray
    auto byte=str.toLower().toLocal8Bit();
    //2.获取原始数据(Qbytearray)
    auto gbkQbytearray=QByteArray::fromHex(byte);
    //3.将gbkQbytearray原始数据转换为gbkQstring原始数据
    auto gbkQstring=QString::fromLocal8Bit(gbkQbytearray);
    //4.将gbkstring转换为utf8qbytearray的十六进制表示
    auto utf8Hex=gbkQstring.toUtf8().toHex(' ');
    //5.返回utf8qstring的十六进制表示
    return QString::fromUtf8(utf8Hex).toUpper();

}

QString SerialPortRecvArea::utf8HexToGbkHex(const QString &str)
{
    if(str.isEmpty())
    {
        return QString{};
    }
    //1.将16进制utf8qstring转换为16进制utf8Qbytearray
    auto byte=str.toLower().toUtf8();
    //2.获取原始数据(Qbytearray)
    auto utf8Qbytearray=QByteArray::fromHex(byte);
    //3.将utf8Qbytearray原始数据转换为utf8Qstring原始数据
    auto utf8Qstring=QString::fromUtf8(utf8Qbytearray);
    //4.将utf8string转换为gbkqbytearray的十六进制表示
    auto gbkHex=utf8Qstring.toLocal8Bit().toHex(' ');
    //5.返回gbkqstring的十六进制表示
    return QString::fromUtf8(gbkHex).toUpper();
}

QString SerialPortRecvArea::getSerialPortInfo() const
{
    return serialPortInfo;
}



QString SerialPortRecvArea::getDataFormat() const
{
    return dataFormat;
}

void SerialPortRecvArea::setDataFormat(const QString &newDataFormat)
{
    if (dataFormat == newDataFormat)
        return;
    dataFormat = newDataFormat;
    Q_EMIT dataFormatChanged();
}

QString SerialPortRecvArea::getEncode() const
{
    return encode;
}

void SerialPortRecvArea::setEncode(const QString &newEncode)
{
    if (encode == newEncode)
        return;
    encode = newEncode;
    Q_EMIT encodeChanged();
}
