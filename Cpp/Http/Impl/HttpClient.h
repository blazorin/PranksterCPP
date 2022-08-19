#pragma once

#include <QObject>
#include <QMap>
#include <iostream>
#include "../Source/Http.h"

class HttpClient : public QObject
{
    Q_OBJECT

    //Q_PROPERTY(quint8 future_view READ futureView NOTIFY sFutureViewChanged)

    public:


        HttpClient();

     public slots:
        QString doSomething(QString text);

        QString webRequest(QString uri, int method, QString optionalJsonPayload = "", QString optionalJwtBearer = "");

};

