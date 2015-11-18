#include <QAudioRecorder>
#include <QAudioProbe>

class DBMeter : public QObject {
	Q_OBJECT
	Q_PROPERTY(double level READ GetLevel NOTIFY levelChanged)
	Q_PROPERTY(bool running READ GetRunning WRITE SetRunning NOTIFY runningChanged)
	Q_PROPERTY(int computeFrameMs READ GetComputeFrameMs WRITE SetComputeFrameMs NOTIFY computeFrameMsChanged)
	Q_PROPERTY(double gain READ GetGain WRITE SetGain NOTIFY gainChanged)
	Q_PROPERTY(double postGain READ GetPostGain WRITE SetPostGain NOTIFY postGainChanged)
	Q_PROPERTY(double offset READ GetOffset WRITE SetOffset NOTIFY offsetChanged)

	private:
	QAudioRecorder *recorder;
	QAudioEncoderSettings settings;
	QAudioProbe *probe;

	double level, energy;
	double gain, postGain, offset;
	bool running;
	int computeMs, computeFrame, frameComputed;

	static const int rate = 16000;
	static const int defaultComputeMs = 200;

	static const int defaultGain = 160000;
	static const int defaultPostGain = 1;
	static const int defaultOffset = 1;

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
	double GetOffset();
	void SetOffset(double g);
	double GetPostGain();
	void SetPostGain(double g);

	signals:
	void levelChanged();
	void runningChanged();
	void computeFrameMsChanged();
	void gainChanged();
	void postGainChanged();
	void offsetChanged();
};
