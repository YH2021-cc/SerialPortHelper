#ifndef SERIALPORTENGINE_H
#define SERIALPORTENGINE_H
#include <QtCore/QObject>
#include "SerialPortSetting.h"
#include "SerialPortRecvArea.h"
#include "SerialPortSendArea.h"
class SerialPortEngine : public QObject
{
    Q_OBJECT
public:
    explicit SerialPortEngine(QObject *parent = nullptr);

    Q_PROPERTY(SerialPortSetting *sps READ sps NOTIFY spsChanged FINAL)
    SerialPortSetting *sps() const;

    Q_PROPERTY(SerialPortRecvArea *rectArea READ rectArea NOTIFY rectAreaChanged FINAL)
    SerialPortRecvArea *rectArea() const;

    Q_PROPERTY(SerialPortSendArea *sendArea READ sendArea NOTIFY sendAreaChanged FINAL)
    SerialPortSendArea *sendArea() const;


Q_SIGNALS:
    void spsChanged();
    void rectAreaChanged();
    void sendAreaChanged();

private:
    SerialPortSetting* _sps;
    SerialPortRecvArea* _rectArea;
    SerialPortSendArea* _sendArea;


};

#endif // SERIALPORTENGINE_H
