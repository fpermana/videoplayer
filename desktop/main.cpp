//#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <singleapplication.h>
#include "setting/Setting.h"
#include "filepicker/FilePicker.h"
#include "GlobalConstants.h"
#include <QQuickStyle>
#include <QDebug>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setOrganizationName(SETTINGS_ORGANIZATION);
    QCoreApplication::setOrganizationDomain(SETTINGS_DOMAIN);
    QCoreApplication::setApplicationName(SETTINGS_APPLICATION);

//    QGuiApplication app(argc, argv);
    SingleApplication app( argc, argv );

    QQuickStyle::setStyle("Universal");

    qmlRegisterType<Setting>("id.fpermana.videoplayer", 1, 0, "Setting");
    qmlRegisterType<FilePicker>("id.fpermana.videoplayer", 1, 0, "FilePicker");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

//    QQmlContext *rootContext = engine.rootContext();

    engine.load(url);

    return app.exec();
}
