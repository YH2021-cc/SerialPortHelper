#include <QtGui/QGuiApplication>
#include <QtQml/QQmlApplicationEngine>
#include <QQmlContext>
#include <QIcon>
#include "./InterFace/SerialPortEngine.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon(":/app_icon.ico"));
    QQmlApplicationEngine engine;

    SerialPortEngine *s1 = new SerialPortEngine(&engine);  // 堆对象，父对象为 engine
    engine.rootContext()->setContextProperty("serialPortEngine", s1);


    const QUrl url(QStringLiteral("qrc:/SerialPortHelper/Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
