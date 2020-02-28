#ifndef SIGFOX_H
#define SIGFOX_H

#include <QObject>

class Sigfox : public QObject
{
	Q_OBJECT
public:
	explicit Sigfox(QObject *parent = nullptr);

signals:

};

#endif // SIGFOX_H
