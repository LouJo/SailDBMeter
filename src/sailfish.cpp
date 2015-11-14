#include <QGuiApplication>
#include <QQuickView>
#include <QtQml>
#include <sailfishapp.h>
#include "DBMeter.hpp"

class Main {
	private:
	QGuiApplication *app;
	QQuickView *view;

	public:
	Main(int &argc, char* argv[]) {
		app = SailfishApp::application(argc, argv);
		view = SailfishApp::createView();
		view->setSource(QUrl("qrc:///qml/Sailfish.qml"));
		QObject::connect(view->engine(), SIGNAL(quit()), app, SLOT(quit()));
	}
	Main() {}
	~Main() {}

	int Launch() {
		view->show();
		return app->exec();
	}
};

Q_DECL_EXPORT int main(int argc, char* argv[])
{
	qmlRegisterType<DBMeter>("LJDBMeter", 1, 0, "DBMeter");
	Main *appli = new Main(argc, argv);
	return appli->Launch();
}
