QT += qml quick gui multimedia
TARGET = DBMeter

CONFIG += c++11

DEFINES += TARGET=\""$(TARGET")\"

SOURCES += \
	src/DBMeter.cpp \
	src/main.cpp

HEADERS += \
	src/DBMeter.hpp
