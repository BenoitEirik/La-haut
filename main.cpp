#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtAndroid>
#include <QtNetwork>
#include <QQmlContext>
#include "statusbar.h"
#include "sigfox.h"

int main(int argc, char *argv[])
{
	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

	QGuiApplication app(argc, argv);

	// set status bar
	qmlRegisterType<StatusBar>("StatusBar", 0, 1, "StatusBar");

	QQmlApplicationEngine engine;
	const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
	QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
					 &app, [url](QObject *obj, const QUrl &objUrl) {
		if (!obj && url == objUrl)
			QCoreApplication::exit(-1);
	}, Qt::QueuedConnection);
	engine.load(url);

	// API request
	qDebug() << "[!] TEST API access";
	Sigfox instance;
	instance.initAPIaccess();
	instance.httpRequest();
	engine.rootContext()->setContextProperty("sigfox", &instance);

	QtAndroid::hideSplashScreen();

	return app.exec();
}
