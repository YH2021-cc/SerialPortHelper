#ifndef SERIALPORTRECVAREA_H
#define SERIALPORTRECVAREA_H

#include <QtCore/QObject>
#include <QString>
#include <QByteArray>
#include <QUrl>
#include <QDateTime>
#include <QFile>
#include <QTextStream>
#include <source_location>
class SerialPortRecvArea : public QObject
{
    Q_OBJECT
public:
    explicit SerialPortRecvArea(QObject *parent = nullptr);


    Q_PROPERTY(bool isAddDateTime READ getIsAddDateTime WRITE setIsAddDateTime NOTIFY isAddDateTimeChanged FINAL)
    bool getIsAddDateTime() const;
    void setIsAddDateTime(bool newIsAddDateTime);

    Q_PROPERTY(QString encode READ getEncode WRITE setEncode NOTIFY encodeChanged FINAL)
    QString getEncode() const;
    void setEncode(const QString &newEncode);

    Q_PROPERTY(QString dataFormat READ getDataFormat WRITE setDataFormat NOTIFY dataFormatChanged FINAL)
    QString getDataFormat() const;
    void setDataFormat(const QString &newDataFormat);

    Q_PROPERTY(QString serialPortInfo READ getSerialPortInfo NOTIFY serialPortInfoChanged FINAL)
    QString getSerialPortInfo() const;

public Q_SLOTS:
    //写入文本区域的数据到文件
    void writeDataToFile(const QUrl& filePath, const QString &data);
    //获取串口发送的信息
    void getPortData(const QByteArray& data);
    //将文本转换为16进制表示(utf-8版本)
    QString utf8ToHex(const QString & str);
    //将文本转换为16进制表示(gbk版本)
    QString gbkToHex(const QString & str);
    //将十六进制表示转换为文本(utf-8版本)
    QString utf8FromHex(const QString & str);
    //将十六进制表示转换为文本(gbk版本)
    QString gbkFromHex(const QString & str);
    //将gbk文本转换为utf-8文本
    QString gbkToUtf8(const QString & str);
    //将utf-8文本转换为gbk文本
    QString utf8ToGbk(const QString & str);
    //将gbkhex转换为utf-8hex
    QString gbkHexToUtf8Hex(const QString & str);
    //将utf-8hex转换为gbkhex
    QString utf8HexToGbkHex(const QString & str);

Q_SIGNALS:
    //串口信息更改信号
    void serialPortInfoChanged();
    //是否添加时间戳更改信号
    void isAddDateTimeChanged();
    //错误消息信号
    void errorMessage(const QString& errorInfo);
    //编码更改信号
    void encodeChanged();
    //数据格式更改信号
    void dataFormatChanged();
    //数据写入到文件完成信号
    void dataWriteToFileFinish();

private:
    //存储串口发过来的信息
    QString serialPortInfo{};
    //是否添加时间戳
    bool isAddDateTime{false};
    //编码格式
    QString encode{"GBK"};
    //数据格式
    QString dataFormat{"文本"};

};

#endif // SERIALPORTRECVAREA_H
