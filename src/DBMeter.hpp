#include <QAudioRecorder>
#include <QAudioProbe>

class DBMeter : public QObject {
	Q_OBJECT
	private:
	QAudioRecorder *recorder;
	QAudioEncoderSettings settings;
	QAudioProbe *probe;

	static const int bufferSize = 10 << 10; // 10ko;
	char buffer[bufferSize];

	private slots:
	void AudioCb(const QAudioBuffer &buffer);

	public:
	DBMeter();
	~DBMeter();

	void Start();
	void Stop();
};
