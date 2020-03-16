#ifndef SIGFOX_H
#define SIGFOX_H

#include <QObject>
#include <QtNetwork>
#include <QDebug>
#include <QJsonDocument>
#include <QCryptographicHash>
#include <QString>

#define DEBUG 1


class Sigfox : public QObject
{
	Q_OBJECT

public:
	explicit Sigfox(QObject *parent = nullptr);

public slots:
	void initAPIaccess();
	void httpRequest();
	void parsingData(QNetworkReply* reply);
	void provideAuthentification(QNetworkReply* reply, QAuthenticator* basicAuth);
	void setCredentials(QString sUser, QString sPwd);

	// switch data to QML
	bool getAPIaccessStatus();
	QString getDevice();
	QString getData();
	QString getSeqNumber();
	bool getStatus();
	bool getRequestStatus();

signals:

private:
	// network
	QNetworkAccessManager *networkManager;
	QAuthenticator access;
	bool onRequestStatus;


	bool APIaccess;
	bool status;
	QString user;
	QString pwd;
	QUrl msgUrl;

	// data received
	QString device;
	QString data;
	int seqNumber;
};

#endif // SIGFOX_H
