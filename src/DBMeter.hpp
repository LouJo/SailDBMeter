#include <QIODevice>
#include <QAudioInput>

class DBMeter : public QObject {
	Q_OBJECT
	private:
	QIODevice *device;
	QAudioInput *input;
	QAudioFormat format;
	QAudioDeviceInfo info;

	static const int bufferSize = 10 << 10; // 10ko;
	char buffer[bufferSize];

	private slots:
	void AudioCb();

	public:
	DBMeter();
	~DBMeter();

	void Start();
	void Stop();
};
