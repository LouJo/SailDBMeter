#include <iostream>
#include <QtConcurrent>
#include <QCoreApplication>
#include <stdint.h>

#include "DBMeter.hpp"

using namespace std;

DBMeter::DBMeter()
{
	level = 0;
	running = false;
	computeMs = defaultComputeMs;
	computeFrame = defaultComputeMs * rate / 1000;

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
	running = true;
	recorder->record();
	runningChanged();
}

void DBMeter::Stop()
{
	running = false;
	recorder->stop();
	runningChanged();
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
	levelChanged();
}

double DBMeter::GetLevel()
{
	return level;
}

bool DBMeter::GetRunning()
{
	return running;
}

void DBMeter::SetRunning(bool r)
{
	if (r) Start();
	else Stop();
}

int DBMeter::GetComputeFrameMs()
{
	return computeMs;
}

void DBMeter::SetComputeFrameMs(int ms)
{
	computeMs = ms;
	computeFrame = ms * rate / 1000;
	computeFrameMsChanged();
}
