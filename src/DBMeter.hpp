#include <QIODevice>
#include <QAudioInput>

class DBMeter {
	private:
	QIODevice *device;
	QAudioInput *input;

	public:
	DBMeter();
	~DBMeter();
};
