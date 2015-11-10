#include <QGuiApplication>
#include <QQuickView>
#include <QtQml>
#include <sailfishapp.h>
#include "DBMeter.hpp"

Q_DECL_EXPORT int main(int argc, char* argv[])
{
	qmlRegisterType<DBMeter>("LJDBMeter", 1, 0, "DBMeter");

	QGuiApplication *app = SailfishApp::application(argc, argv);
	QQuickView *view = SailfishApp::createView();
	view->setSource(QUrl("qrc:///qml/Sailfish.qml"));
	view->show();

	return app->exec();
}
