#ifndef SIGFOX_H
#define SIGFOX_H

#include <QObject>
#include <QtNetwork>
#include <QDebug>
#include <QJsonDocument>
#include <QCryptographicHash>
#include <QString>
#include <QObject>
#include <QTimer>
#include <cmath>

#define DEBUG 1


class Sigfox : public QObject
{
	Q_OBJECT

public:
	explicit Sigfox(QObject *parent = nullptr);

public slots:
	void start();
	void initAPIaccess();
	void httpRequest();

	void parsingData(QNetworkReply* reply);
	void provideAuthentification(QNetworkReply* reply, QAuthenticator* basicAuth);
	void setCredentials(QString sUser, QString sPwd);
	void stopAccess();
	void startAccess();

	QString convertDDtoDMS(double coord);

	// switch data to QML
	bool getAPIaccessStatus();
	QString getDevice();
	QString getData();
	QString getSeqNumber();
	bool getStatus();
	bool getRequestStatus();
	QString getUser();
	QString getPwd();
	QString getSpecigicData(QString type);

signals:

private:
	// network
	QNetworkAccessManager *networkManager;
	QAuthenticator access;
	bool onRequestStatus;


	bool APIaccess = false;
	bool status = false;
	bool stop = false;
	QString user;
	QString pwd;
	QUrl msgUrl;

	// data received
	QString data = "__";
	QString device = "__";
	int seqNumber = 0;
	double lat = 0;
	QString dirLat = "N";
	double lng = 0;
	QString dirLng = "E";
	double alt = 0;
	int temp = 0;
	int pressure = 0;
};

#endif // SIGFOX_H
