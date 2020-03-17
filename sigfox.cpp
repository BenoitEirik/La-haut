#include "sigfox.h"

Sigfox::Sigfox(QObject *parent) : QObject(parent)
{

}

void Sigfox::initAPIaccess()
{
	// init variables
	device = "__";
	data = "__";
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
	onRequestStatus = true;

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

	onRequestStatus = false;
}


void Sigfox::parsingData(QNetworkReply* reply)
{
	QByteArray byteData = reply->readAll();
	QJsonParseError jsError;
	QJsonDocument jsDoc = QJsonDocument::fromJson(byteData, &jsError);

	if(jsError.error != QJsonParseError::NoError)
	{
		if(DEBUG) qDebug() << "[!] QJsonParseError: " << jsError.error;
		status = false;
		return;
	}
	else
	{
		// change status connection to the server
		status = true;
	}

	// {"data":[{"device":{"id":"2EDED7"},"time":1583360784000,"data":"6060606060606060606000"
	QJsonObject rootObject = jsDoc.object();
	QJsonArray array_msg = rootObject["data"].toArray();

	// device
	device = array_msg[0].toObject()["device"].toObject()["id"].toString();

	// "data"
	data = array_msg[0].toObject()["data"].toString();
	lat = (data.mid(0,6)).toDouble() / 10000;
	lng = (data.mid(6,6)).toDouble() / 10000;
	alt = (data.mid(12,4)).toDouble() / 100;
	temp = (data.mid(17,2)).toInt();
	if((data.mid(16,1)).toInt() == 1)
	{
		temp = temp - (2 * temp);
	}
	pressure = (data.mid(19,4)).toInt();

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


QString Sigfox::convertDDtoDMS(double coord)
{
	int deg = (int)(coord);
	int min = (int)((coord - (double)deg) * 60);
	int sec = ((((coord - (double)deg) * 60) - (double)min) * 60 );

	QString dms = QString::number(deg);
	dms += "° ";
	dms += QString::number(min);
	dms += "' ";
	dms += QString::number(sec);
	dms += "\"";

	return dms;
}


void Sigfox::start()
{
	if(!APIaccess) initAPIaccess();

	QTimer *timer = new QTimer();
	if(getRequestStatus() == false)
		connect(timer, SIGNAL(timeout()), this, SLOT(httpRequest()));
	timer->start(3000);
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
		return "__";
	}
	else return device;
}

QString Sigfox::getData()
{
	if(data.isEmpty())
	{
		return "__";
	}
	else return data;
}


QString Sigfox::getSeqNumber()
{
	if(seqNumber == 0)
	{
		return "__";
	}
	else return QString::number(seqNumber);
}

bool Sigfox::getStatus()
{
	if(!status) return false;
	return status;
}

bool Sigfox::getRequestStatus()
{
	if(DEBUG) qDebug() << "[!] onRequestStatus : " << onRequestStatus;
	if(!onRequestStatus) return false;
	return onRequestStatus;
}

QString Sigfox::getUser()
{
	if(!user.isEmpty()) return user;
	return "";
}

QString Sigfox::getPwd()
{
	if(!pwd.isEmpty()) return pwd;
	return "";
}

QString Sigfox::getSpecigicData(QString type)
{
	if(type == "lat")
	{
		return convertDDtoDMS(lat);
	}
	if(type == "lng")
	{
		return convertDDtoDMS(lng);
	}
	if(type == "alt") return QString::number(alt) += " km";
	if(type == "temp") return QString::number(temp) += " °C";
	if(type == "pressure")
	{
		return QString::number(pressure) += " Pa";
	}
	return "";
}
