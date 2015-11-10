QT += qml quick gui multimedia concurrent
TARGET = DBMeter

CONFIG += c++11

DEFINES += TARGET=\""$(TARGET")\"

RESOURCES += \
	qml/qml.qrc

SOURCES += \
	src/DBMeter.cpp \
	src/main.cpp

HEADERS += \
	src/DBMeter.hpp
