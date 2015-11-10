#include <QAudioRecorder>
#include <QAudioProbe>

class DBMeter : public QObject {
	Q_OBJECT
	Q_PROPERTY(double level READ GetLevel NOTIFY levelChanged)
	Q_PROPERTY(bool running READ GetRunning WRITE SetRunning NOTIFY runningChanged)
	Q_PROPERTY(int computeFrameMs READ GetComputeFrameMs WRITE SetComputeFrameMs NOTIFY computeFrameMsChanged)
	Q_PROPERTY(int gain READ GetGain WRITE SetGain NOTIFY gainChanged)

	private:
	QAudioRecorder *recorder;
	QAudioEncoderSettings settings;
	QAudioProbe *probe;

	double level, energy, gain;
	bool running;
	int computeMs, computeFrame, frameComputed;

	static const int rate = 16000;
	static const int defaultComputeMs = 500;
	static const int defaultGain = 5000;

	inline void ComputeFrame(int16_t v);

	private slots:
	void AudioCb(const QAudioBuffer &buffer);

	public:
	DBMeter();
	~DBMeter();

	void Start();
	void Stop();

	double GetLevel();
	bool GetRunning();
	void SetRunning(bool r);
	void SetComputeFrameMs(int ms);
	int GetComputeFrameMs();
	double GetGain();
	void SetGain(double g);

	signals:
	void levelChanged();
	void runningChanged();
	void computeFrameMsChanged();
	void gainChanged();
};
