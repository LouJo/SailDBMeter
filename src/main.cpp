#include <QCoreApplication>
#include "DBMeter.hpp"

int main(int argc, char* argv[])
{
	QCoreApplication app(argc, argv);
	DBMeter meter;
	meter.Start();
	return app.exec();
}
