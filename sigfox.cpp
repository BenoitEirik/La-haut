#include "sigfox.h"

Sigfox::Sigfox(QObject *parent) : QObject(parent)
{

}

void Sigfox::initAPIaccess()
{
	// init variables
	device = "_ _";
	data = "_ _";
	seqNumber = 0;
	msgUrl = "https://api.sigfox.com/v2/devices/2EDED7/messages";

	// check existant output.dat file
	if(QFile::exists("output.dat"))
	{
		 if(DEBUG) qDebug() << "[i] output.dat finded";

		 QFile file("output.dat");
		 if(file.open(QFile::ReadOnly))
		 {
			 //char buf[1024];
			 QTextStream out(&file);
			 user = out.readLine(1024);
			 if(user.isEmpty()) return;
			 pwd = out.readLine(1024);
			 if(pwd.isEmpty()) return;
			 file.close();
		 }
	}
	else
	{
		if(DEBUG) qDebug() << "[i] output.dat not finded.";
		return;
	}

	//user = "5e591737319dc629c64ffbca";
	//pwd = "1c633b4d0ce05710fa21f1e2c997c7fe";


	APIaccess = true;

	if(DEBUG) qDebug() << "[!] Init API access";
}


void Sigfox::setCredentials(QString sUser, QString sPwd)
{
	user = sUser;
	pwd = sPwd;

	msgUrl = "https://api.sigfox.com/v2/devices/2EDED7/messages";
	APIaccess = true;

	QFile file("output.dat");
	if(file.open(QFile::WriteOnly))
	{
		QTextStream out(&file);
		out << user << "\n";
		out << pwd;
		file.close();
	}

}


void Sigfox::httpRequest()
{
	if (!APIaccess)
	{
		if(DEBUG) qDebug() << "[!] No APIaccess";
		return;
	}

	// create & check network status
	networkManager = new QNetworkAccessManager();
	qDebug() << "[!] " << networkManager->networkAccessible();

	// Authentification
	QObject::connect(networkManager,
					 SIGNAL(authenticationRequired(QNetworkReply*, QAuthenticator*)),
					 this,
					 SLOT(provideAuthentification(QNetworkReply*, QAuthenticator*)));

	// switch to parsingData
	QObject::connect(networkManager,
					 SIGNAL(finished(QNetworkReply*)),
					 this,
					 SLOT(parsingData(QNetworkReply*)));

	// GET request
	QNetworkRequest request(msgUrl);
	networkManager->get(request);
}


void Sigfox::parsingData(QNetworkReply* reply)
{
	QByteArray byteData = reply->readAll();
	QJsonParseError jsError;
	QJsonDocument jsDoc = QJsonDocument::fromJson(byteData, &jsError);

	if(jsError.error != QJsonParseError::NoError)
	{
		if(DEBUG) qDebug() << "[!] QJsonParseError: " << jsError.error;
		return;
	}

	// {"data":[{"device":{"id":"2EDED7"},"time":1583360784000,"data":"6060606060606060606000"
	QJsonObject rootObject = jsDoc.object();
	QJsonArray array_msg = rootObject["data"].toArray();

	// device
	device = array_msg[0].toObject()["device"].toObject()["id"].toString();

	// "data"
	data = array_msg[0].toObject()["data"].toString();

	// "seqNumber"
	seqNumber = array_msg[0].toObject()["seqNumber"].toInt();

	if(DEBUG)
	{
		qDebug() << "[i] [JSON] device: " << device;
		qDebug() << "[i] [JSON] data: " << data;
		qDebug() << "[i] [JSON] seqNumber: " << seqNumber;
	}
}


void Sigfox::provideAuthentification(QNetworkReply* reply, QAuthenticator* basicAuth)
{
	basicAuth->setUser(user);
	basicAuth->setPassword(pwd);

	if(DEBUG)
	{
		qDebug() << "[i] USER = " << basicAuth->user();
		qDebug() << "[i] PWD  = " << basicAuth->password();
		qDebug() << "[i] [JSON] Readable ? " << reply->isReadable();
	}
	if(reply->readAll() == "") return;
}

/****************************************************************/
/*                        QML interaction                       */
/****************************************************************/

bool Sigfox::getAPIaccessStatus()
{
	return APIaccess;
}

QString Sigfox::getDevice()
{
	if(device.isEmpty())
	{
		return "_ _";
	}
	else return device;
}

QString Sigfox::getData()
{
	if(data.isEmpty())
	{
		return "_ _";
	}
	else return data;
}


QString Sigfox::getSeqNumber()
{
	if(seqNumber == 0)
	{
		return "_ _";
	}
	else return QString::number(seqNumber);
}
