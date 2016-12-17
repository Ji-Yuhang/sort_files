#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "filehelper.h"
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    qmlRegisterType<FileHelper>("an.qt.FileHelper", 1,0,"FileHelper");
    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
