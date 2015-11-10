#include <QCoreApplication>
#include <QtQml>
#include "DBMeter.hpp"

int main(int argc, char* argv[])
{
	QCoreApplication app(argc, argv);
	//qmlRegisterType<DBMeter>("io.audio.input.dbmeter", 1, 0, "DBMeter");
	DBMeter meter;
	meter.Start();
	return app.exec();
}
