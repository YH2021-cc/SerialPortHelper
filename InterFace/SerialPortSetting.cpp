#include "SerialPortSetting.h"
#include <QList>
SerialPortSetting::SerialPortSetting(QObject *parent)
    : QObject{parent},port(new QSerialPort(this)),
    portInfo(new QStringListModel(this))
{
    QStringList info;
    const auto ports = QSerialPortInfo::availablePorts();
    if(!ports.empty())
    {
        for (const auto& port : ports) {
            info << port.portName();
        }
        //都按照从小到大进行排序容易删除或增加数据
        info.sort();
        portInfo->setStringList(info);
    }

    //当串口有数据时发射信号给其他要获取数据的类
    connect(port,&QSerialPort::readyRead,this,&SerialPortSetting::onReadyRead);

}

void SerialPortSetting::updatePort()
{
    //获取新串口信息
    const auto ports = QSerialPortInfo::availablePorts();
    //如果没有串口信息直接返回
    if(ports.empty())
        return;
    QStringList info;
    for (const auto& port : ports) {
        info << port.portName();
    }

    //排序
    info.sort();
    //如果没有新数据直接返回
    if(info==portInfo->stringList())
        return;

    //判断数据是新增还是减少
    int countChangd=info.size()-portInfo->stringList().size();
    //大于0说明新增数据
    if(countChangd>0)
    {
        //新增几个数据就添加几个行和数据
        for(int i=0;i<countChangd;++i)
        {
            //插入一行空行
            portInfo->insertRows(portInfo->rowCount(),1);
            //添加数据
            portInfo->setData(portInfo->index(portInfo->rowCount()-1),info.at(portInfo->stringList().size()-1),Qt::DisplayRole);


        }
    }
    else
    {
        //判断原串口信息是否还在新串口信息里,
        //如果不在获取它的索引存储起来,最后调用removeRows删除
        // 1 2 3 4 5 6
        // 1 2 3 4  >>5,6不在获取其索引4,5作为removeRows第一个参数
        //存储所有删除的数据的索引
        QList<int> indexList{};
        for(int i=0;i<portInfo->stringList().size();++i)
        {
            if(info.contains(portInfo->stringList().at(i)))
            {
                continue;
            }
            else
            {
                indexList.append(i);
            }
        }
        //清除数据
        for(int i=indexList.size()-1;i>=0;--i)
        {
            portInfo->removeRows(indexList.at(i),1);
        }

    }
    //发送数据变化信号
    Q_EMIT portInfoChanged();

}

void SerialPortSetting::onReadyRead()
{
    //读取串口数据
    QByteArray data= port->readAll();
    //发射信号要其他类接受
    Q_EMIT dataReceived(data);
}

void SerialPortSetting::writeData(const QByteArray &data)
{
    if(data.isEmpty())
        return;
    if(port&&port->isOpen())
        port->write(data);
    else {
        Q_EMIT settingError("串口未打开,无法发送数据!");
    }
}

bool SerialPortSetting::getIsOpened() const
{
    return isOpened;
}

void SerialPortSetting::setIsOpened(bool newIsOpened)
{
    if (isOpened == newIsOpened)
        return;
    isOpened = newIsOpened;
    Q_EMIT isOpenedChanged();
}



bool SerialPortSetting::setBaudRate(int baudRate)
{
    //验证数据是否合理
    QList<int> brGroup{1200,2400,4800,9600,19200,38400,57600,115200};
    if(!brGroup.contains(baudRate))
    {
        Q_EMIT settingError(QString("Invalid baud rate: %1").arg(baudRate));
        return false;
    }
    //判断和当前波特率是否相等相等直接返回
    if(baudRate==m_baudRate)
        return false;

    // 如果串口已打开，尝试应用设置,如果未打开直接设置
    if ((port && port->isOpen())||(port)) {
        if (!port->setBaudRate(baudRate)) {
            emit settingError(tr("Failed to set baud rate: %1").arg(port->errorString()));
            return false;
        }
    }
    // 如果设置成功更新内部值
    m_baudRate = baudRate;
    return true;
}

bool SerialPortSetting::setDataBits(int dataBits)
{
    //验证数据是否合理
    QList<int> dbGroup{5,6,7,8};
    if(!dbGroup.contains(dataBits))
    {
        Q_EMIT settingError(QString("Invalid dateBits: %1").arg(dataBits));
        return false;
    }
    //判断和当前数据位是否相等,相等直接返回
    if(dataBits==m_dataBits)
        return false;

    QMap<int,QSerialPort::DataBits> dataBitsMap{

        {5,QSerialPort::DataBits::Data5},{6,QSerialPort::DataBits::Data6},
        {7,QSerialPort::DataBits::Data7},{8,QSerialPort::DataBits::Data8}
    };

    // 如果串口已打开，尝试应用设置,如果未打开直接设置
    if ((port && port->isOpen())||(port)) {
        if (!port->setDataBits(dataBitsMap[dataBits])){
            emit settingError(tr("Failed to set dateBits: %1").arg(port->errorString()));
            return false;
        }
    }
    // 如果设置成功更新内部值
    m_dataBits = dataBits;
    return true;
}

bool SerialPortSetting::setParity(int parity)
{
    //验证数据是否合理
    QList<int> pyGroup{0,2,3,4,5};
    if(!pyGroup.contains(parity))
    {
        Q_EMIT settingError(QString("Invalid Parity: %1").arg(parity));
        return false;
    }
    //判断和当前校验位是否相等,相等直接返回
    if(parity==m_parity)
        return false;

    QMap<int,QSerialPort::Parity>parityMap{

        {0,QSerialPort::Parity::NoParity},
        {2,QSerialPort::Parity::EvenParity},
        {3,QSerialPort::Parity::OddParity},
        {4,QSerialPort::Parity::SpaceParity},
        {5,QSerialPort::Parity::MarkParity}
    };

    // 如果串口已打开，尝试应用设置,如果未打开直接设置
    if ((port && port->isOpen())||(port)) {
        if (!port->setParity(parityMap[parity])) {
            emit settingError(tr("Failed to set parity: %1").arg(port->errorString()));
            return false;
        }
    }
    // 如果设置成功更新内部值
    m_parity = parity;
    return true;
}

bool SerialPortSetting::setStopBits(const QString& stopBits)
{
    //验证数据是否合理
    QList<QString> sbGroup{"1","1.5","2"};
    if(!sbGroup.contains(stopBits))
    {
        Q_EMIT settingError(QString("Invalid StopBits: %1").arg(stopBits));
        return false;
    }
    //判断和当前停止位是否相等,相等直接返回
    auto temp=(stopBits==QString("1.5"));
    int tempStopBits{-1};
    if(temp)
    {
        if(3==m_stopBits)
            return false;
        tempStopBits=3;
    }
    else
    {
        if(stopBits.toInt()==m_stopBits)
            return false;
        tempStopBits=stopBits.toInt();
    }

    QMap<int, QSerialPort::StopBits> stopBitsMap{
        {1, QSerialPort::StopBits::OneStop},
        {3, QSerialPort::StopBits::OneAndHalfStop},
        {2, QSerialPort::StopBits::TwoStop},
        };

    // 如果串口已打开，尝试应用设置,如果未打开直接设置
    if ((port && port->isOpen())||(port)) {
        if (!port->setStopBits(stopBitsMap[tempStopBits])) {
            Q_EMIT settingError(tr("Failed to set StopBits: %1").arg(port->errorString()));
            return false;
        }
    }
    // 如果设置成功更新内部值
    m_stopBits = tempStopBits;
    return true;
}

bool SerialPortSetting::setFlowControl(int flowControl)
{
    //验证数据是否合理
    QList<int> fcGroup{0,1,2};
    if(!fcGroup.contains(flowControl))
    {
        Q_EMIT settingError(QString("Invalid FlowControl: %1").arg(flowControl));
        return false;
    }
    //判断和当前流控制是否相等相等直接返回
    if(flowControl==m_flowControl)
        return false;
    QMap<int,QSerialPort::FlowControl>flowMap{
        {0,QSerialPort::FlowControl::NoFlowControl},
        {1,QSerialPort::FlowControl::HardwareControl},
        {2,QSerialPort::FlowControl::SoftwareControl}
    };
    // 如果串口已打开，尝试应用设置,如果未打开直接设置
    if ((port && port->isOpen())||(port)) {
        if (!port->setFlowControl(flowMap[flowControl])) {
            emit settingError(tr("Failed to set FlowControl: %1").arg(port->errorString()));
            return false;
        }
    }
    // 如果设置成功更新内部值
    m_flowControl = flowControl;

    return true;
}

void SerialPortSetting::setPort(const QString& _portInfo)
{
    if(_portInfo.isEmpty())
        return;
    const auto ports = QSerialPortInfo::availablePorts();
    if(!ports.empty())
    {
        for (const auto& _port : ports) {
            if(_port.portName()==_portInfo)
            {
                port->setPort(_port);
                break;
            }
        }

    }
}

void SerialPortSetting::openSerialPort()
{
    //判断是否已打开串口
    if(isOpened)
        return;
    //如果没打开就打开串口
    if(port->open(QSerialPort::ReadWrite))
    {
        //设置打开标志
        setIsOpened(true);

    }
    else
    {
        Q_EMIT settingError(QString("Failed to open port: %1").arg(port->errorString()));
    }
}

void SerialPortSetting::closeSerialPort()
{
    if(isOpened)
    {
        port->close();
        setIsOpened(false);
    }
}





QStringListModel *SerialPortSetting::getPortInfo() const
{
    return portInfo;
}











