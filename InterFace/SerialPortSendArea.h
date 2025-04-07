#ifndef SERIALPORTSENDAREA_H
#define SERIALPORTSENDAREA_H
#include <QString>
#include <QtCore/QObject>
#include <QTimer>
#include <QDebug>
class SerialPortSendArea : public QObject
{
    Q_OBJECT
public:
    explicit SerialPortSendArea(QObject *parent = nullptr);


    Q_PROPERTY(QString encode READ getEncode WRITE setEncode NOTIFY encodeChanged FINAL)
    QString getEncode() const;
    void setEncode(const QString &newEncode);

    QString getDataFormat() const;
    void setDataFormat(const QString &newDataFormat);
    Q_PROPERTY(QString dataFormat READ getDataFormat WRITE setDataFormat NOTIFY dataFormatChanged FINAL)

    Q_PROPERTY(bool isAddLineFeed READ getIsAddLineFeed WRITE setIsAddLineFeed NOTIFY isAddLineFeedChanged FINAL)
    bool getIsAddLineFeed() const;
    void setIsAddLineFeed(bool newIsAddLineFeed);

    Q_PROPERTY(int sendTime READ getSendTime WRITE setSendTime NOTIFY sendTimeChanged FINAL)
    int getSendTime() const;
    void setSendTime(int newSendTime);

    Q_PROPERTY(bool isTimingSend READ getIsTimingSend WRITE setIsTimingSend NOTIFY isTimingSendChanged FINAL)
    bool getIsTimingSend() const;
    void setIsTimingSend(bool newIsTimingSend);

    Q_PROPERTY(QString data READ getData WRITE setData NOTIFY dataChanged FINAL)
    QString getData() const;
    void setData(const QString &newData);

public Q_SLOTS:
    //发送数据
    void sendData(const QString& data);
    //定时发送
    void timeSend();

Q_SIGNALS:
    void serialPortInfoChanged();
    void encodeChanged();
    void dataFormatChanged();
    void isAddLineFeedChanged();
    void sendTimeChanged();
    void isTimingSendChanged();

    //通过串口发送数据
    void requestSendData(const QByteArray& data);

    void dataChanged();

private:
    //编码格式
    QString encode{"GBK"};
    //数据格式
    QString dataFormat{"文本"};
    //是否添加换行
    bool isAddLineFeed{false};
    //定时发送时间
    int sendTime{1000};
    //是否定时发送
    bool isTimingSend{false};
    //定时器
    QTimer* timer;
    //要发送的数据(从qml里获取)
    QString data{};

};

#endif // SERIALPORTSENDAREA_H
