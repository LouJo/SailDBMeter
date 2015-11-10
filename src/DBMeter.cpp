#include <iostream>
#include <QtConcurrent>
#include <QCoreApplication>
#include <stdint.h>
#include <pulse/simple.h>

#include "DBMeter.hpp"

using namespace std;

DBMeter::DBMeter()
{
	settings.setCodec("audio/PCM");
	settings.setChannelCount(1);
	settings.setSampleRate(16000);

	recorder = new QAudioRecorder(this);
	recorder->setAudioInput("pulseaudio:");
	recorder->setAudioSettings(settings);

	QUrl url = QString("/dev/null");
	recorder->setOutputLocation(url);

	probe = new QAudioProbe(this);
	connect(probe, SIGNAL(audioBufferProbed(QAudioBuffer)), this, SLOT(AudioCb(QAudioBuffer)));
	probe->setSource(recorder);
}

DBMeter::~DBMeter()
{
	delete recorder;
}

void DBMeter::Start()
{
	recorder->record();
}

void DBMeter::Stop()
{
	recorder->stop();
}

void DBMeter::AudioCb(const QAudioBuffer &buffer)
{
	const int16_t *ptr = buffer.constData<int16_t>();
	uint16_t maxVal = 0, val;
	int nbFrame = buffer.sampleCount();

	while (nbFrame--) {
		val = abs(*ptr++);
		if (val > maxVal) maxVal = val;
	}
	cerr << " maxVal " << maxVal << endl;
}
