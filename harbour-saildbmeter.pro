QT += qml quick gui multimedia concurrent
TARGET = harbour-saildbmeter

CONFIG += c++11 sailfishapp sailfishapp_i18n

DEFINES += TARGET=\""$(TARGET")\"

SOURCES += \
	src/DBMeter.cpp \
	src/main.cpp

HEADERS += \
	src/DBMeter.hpp
