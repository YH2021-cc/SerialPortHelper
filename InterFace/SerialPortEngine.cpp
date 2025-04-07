#include "SerialPortEngine.h"

SerialPortEngine::SerialPortEngine(QObject *parent)
    : QObject{parent},_sps(new SerialPortSetting(this)),_rectArea(new SerialPortRecvArea(this))
    ,_sendArea(new SerialPortSendArea(this))
{
    //当串口有数据时发出信号,使显示设备显示数据
    connect(_sps,&SerialPortSetting::dataReceived,_rectArea,&SerialPortRecvArea::getPortData);

    //发送数据信号
    connect(_sendArea,&SerialPortSendArea::requestSendData,_sps,&SerialPortSetting::writeData);

}

SerialPortSetting *SerialPortEngine::sps() const
{
    return _sps;
}

SerialPortRecvArea *SerialPortEngine::rectArea() const
{
    return _rectArea;
}

SerialPortSendArea *SerialPortEngine::sendArea() const
{
    return _sendArea;
}











