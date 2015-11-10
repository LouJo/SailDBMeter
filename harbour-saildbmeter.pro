QT += qml quick gui multimedia concurrent
TARGET = harbour-saildbmeter

CONFIG += c++11 sailfishapp sailfishapp_i18n

DEFINES += TARGET=\""$(TARGET")\"

RESOURCES += \
	qml/sailfish.qrc

SOURCES += \
	src/DBMeter.cpp \
	src/sailfish.cpp

HEADERS += \
	src/DBMeter.hpp
