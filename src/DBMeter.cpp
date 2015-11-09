#include <iostream>
#include <QtConcurrent>
#include <QCoreApplication>
#include <stdint.h>
#include <pulse/simple.h>

#include "DBMeter.hpp"

using namespace std;

DBMeter::DBMeter()
{
	pa_simple *s;

	format.setSampleRate(16000);
	format.setChannelCount(1);
	format.setSampleSize(16);
	format.setCodec("audio/pcm");
	format.setByteOrder(QAudioFormat::LittleEndian);
	format.setSampleType(QAudioFormat::SignedInt);

	cerr << "devices list:" << endl;
	for (auto &dev : QAudioDeviceInfo::availableDevices(QAudio::AudioInput)) {
		cerr << dev.deviceName().toStdString() << endl;
	}
	cerr << endl;

	QAudioDeviceInfo info = QAudioDeviceInfo::defaultInputDevice();

	if (!info.isFormatSupported(format)) {
		cerr << "WARN: Default format not supported, trying to use the nearest.";
		format = info.nearestFormat(format);
	}

	cerr << "Audio input format: " << format.sampleRate() << "hz "
		<< format.channelCount() << " chans "
		<< format.sampleSize() << "b"
		<< endl;

	device = NULL;
	input = new QAudioInput(info, format, this);
}

DBMeter::~DBMeter()
{
	delete input;
}

void DBMeter::Start()
{
	device = input->start();
	if (device) connect(device, SIGNAL(readyRead()), this, SLOT(AudioCb()));
}

void DBMeter::Stop()
{
	input->stop();
}

void DBMeter::AudioCb()
{
	int size = device->read(buffer, bufferSize) >> 1;
	uint16_t maxVal = 0, val;
	int16_t *ptr = (int16_t*) buffer;

	cerr << __func__ << " length " << size;

	while (size--) {
		val = abs(*ptr++);
		if (val > maxVal) maxVal = val;
	}
	cerr << " maxVal " << maxVal << endl;
}
