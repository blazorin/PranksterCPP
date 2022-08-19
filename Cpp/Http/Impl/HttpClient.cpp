#include "HttpClient.h"

HttpClient::HttpClient()
{

}


QString HttpClient::doSomething(QString text) {
    std::cout << std::endl << "Message from CPP: " << text.toStdString();

    return QString("");
}


QString HttpClient::webRequest(QString uri, int method, QString optionalJsonPayload, QString optionalJwtBearer)
{
    std::string uriStd = uri.toStdString();
    std::cout << std::endl << "About to fetch: " << uriStd;

    std::string jsonStd = optionalJsonPayload.toStdString();
    std::string bearerStd = optionalJwtBearer.toStdString();

    HttpMethod methodEnumType = method == 0 ? HttpMethod::Get : HttpMethod::Post;


    Http client(uriStd, methodEnumType, {}, jsonStd, bearerStd);
    std::string response;

    try {
        response = client.WebRequest();

    } catch (std::exception& ex) {
        std::cout << std::endl << "Error produced on webRequest (Impl)" << ex.what();
    }

    return QString::fromUtf8(response.c_str());

}

