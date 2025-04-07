#ifndef SERIALPORTSETTING_H
#define SERIALPORTSETTING_H
#include <QSerialPort>
#include <QSerialPortInfo>
#include <QtCore/QObject>
#include <QStringListModel>
#include <QStringList>
#include <QList>
#include <QMap>
class SerialPortSetting : public QObject
{
    Q_OBJECT
public:
    explicit SerialPortSetting(QObject *parent = nullptr);

    Q_PROPERTY(QStringListModel *portInfo READ getPortInfo NOTIFY portInfoChanged FINAL)
    QStringListModel *getPortInfo() const;

    // 这些函数用于从QML设置参数
    Q_INVOKABLE bool setBaudRate(int baudRate); //设置波特率
    Q_INVOKABLE bool setDataBits(int dataBits); //设置数据位
    Q_INVOKABLE bool setParity(int parity);     //设置校验位
    Q_INVOKABLE bool setStopBits(const QString& stopBits); //设置停止位
    Q_INVOKABLE bool setFlowControl(int flowControl);//设置流控制
    //设置串口信息
    Q_INVOKABLE void setPort(const QString& portInfo);
    //打开串口
    Q_INVOKABLE void openSerialPort();
    //关闭串口
    Q_INVOKABLE void closeSerialPort();
    Q_PROPERTY(bool isOpened READ getIsOpened WRITE setIsOpened NOTIFY isOpenedChanged FINAL)
    bool getIsOpened() const;
    void setIsOpened(bool newIsOpened);

public Q_SLOTS:
        //更新模型数据
        void updatePort();
        //串口数据到达(当串口的ReadyRead发出时调用该槽函数)
        //用于读取串口数据并发出dataReceived信号给其他类使用
        void onReadyRead();
        //发送数据
        void writeData(const QByteArray& data);

Q_SIGNALS:
    void portInfoChanged();//串口信息变化信号
    void settingError(const QString & error); //设置串口错误信号
    void isOpenedChanged();

    //数据接受信号
    void dataReceived(const QByteArray& data);

private:
    //可用的串口
    QSerialPort* port;
    //存储所有的可用的串口名的模型用于qml
    QStringListModel* portInfo;
    //是否已打开串口标志
    bool isOpened=false;
    //串口相关属性
    int m_baudRate=-1; //波特率
    int m_dataBits=99; //数据位
    int m_parity=99;   //校验位
    int m_stopBits=99; //停止位
    int m_flowControl=99;//流控制

};

#endif // SERIALPORTSETTING_H
