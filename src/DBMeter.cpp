#include <iostream>
#include <QtConcurrent>
#include <QCoreApplication>
#include <stdint.h>

#include "DBMeter.hpp"

using namespace std;

DBMeter::DBMeter()
{
	level = 0;
	gain = defaultGain;
	postGain = defaultPostGain;
	offset = defaultOffset;
	running = false;
	computeMs = defaultComputeMs;
	computeFrame = defaultComputeMs * rate / 1000;

	settings.setCodec("audio/PCM");
	settings.setChannelCount(1);
	settings.setSampleRate(rate);

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
	frameComputed = 0;
	energy = 0;
	recorder->record();
	runningChanged();
}

void DBMeter::Stop()
{
	running = false;
	recorder->stop();
	runningChanged();
}

void DBMeter::ComputeFrame(int16_t v)
{
	int32_t d = v * v;
	energy += d;

	if (frameComputed++ == computeFrame) {
		double w = sqrt(energy / INT32_MAX / frameComputed);
		level = postGain * 20 * log10(gain * w + offset);
		energy = 0;
		frameComputed = 0;
		levelChanged();
	}
}

void DBMeter::AudioCb(const QAudioBuffer &buffer)
{
	const int16_t *ptr = buffer.constData<int16_t>();
	int nbFrame = buffer.sampleCount();

	while (nbFrame--) ComputeFrame(*ptr++);
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

double DBMeter::GetGain() { return gain; }

void DBMeter::SetGain(double g)
{
	cerr << "set gain " << g << endl;
	gain = g;
	gainChanged();
}

double DBMeter::GetPostGain() { return postGain; }

void DBMeter::SetPostGain(double g)
{
	postGain = g;
	postGainChanged();
}

double DBMeter::GetOffset() { return offset; }

void DBMeter::SetOffset(double o)
{
	offset = o;
	offsetChanged();
}
