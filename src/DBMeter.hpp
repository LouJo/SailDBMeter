#include <QAudioRecorder>
#include <QAudioProbe>

class DBMeter : public QObject {
	Q_OBJECT
	Q_PROPERTY(double level READ GetLevel NOTIFY levelChanged)
	Q_PROPERTY(bool running READ GetRunning WRITE SetRunning NOTIFY runningChanged)
	Q_PROPERTY(int computeFrameMs READ GetComputeFrameMs WRITE SetComputeFrameMs NOTIFY computeFrameMsChanged)

	private:
	QAudioRecorder *recorder;
	QAudioEncoderSettings settings;
	QAudioProbe *probe;

	double level;
	bool running;
	int computeMs, computeFrame;

	static const int rate = 16000;
	static const int defaultComputeMs = 500;

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

	signals:
	void levelChanged();
	void runningChanged();
	void computeFrameMsChanged();
};
