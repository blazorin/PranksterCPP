#include <QApplication>
#include <FelgoApplication>
#include <FelgoLiveClient>
#include <QtGlobal>

#include <QQmlApplicationEngine>

// uncomment this line to add the Live Client Module and use live reloading with your custom C++ code
//#include <FelgoLiveClient>

// include qml context, required to add a context property
#include <QQmlContext>

#include "Cpp/Http/Impl/HttpClient.h"

#include <Cpp/Lottie/qtlottieitem.h>


int main(int argc, char *argv[])
{

    QApplication app(argc, argv);

    FelgoApplication felgo;

    // Use platform-specific fonts instead of Felgo's default font
    felgo.setPreservePlatformFonts(true);

    QQmlApplicationEngine engine;
    felgo.initialize(&engine);

    // Set an optional license key from project file
    // This does not work if using Felgo Live, only for Felgo Cloud Builds and local builds
    felgo.setLicenseKey(PRODUCT_LICENSE_KEY);

    // use this during development
    // for PUBLISHING, use the entry point below


    // COMMENT FOR FelgoLive
    felgo.setMainQmlFileName(QStringLiteral("qml/Main.qml"));


    // use this instead of the above call to avoid deployment of the qml files and compile them into the binary with qt's resource system qrc
    // this is the preferred deployment option for publishing games to the app stores, because then your qml files and js files are protected
    // to avoid deployment of your qml files and images, also comment the DEPLOYMENTFOLDERS command in the .pro file
    // also see the .pro file for more details
    //felgo.setMainQmlFileName(QStringLiteral("qrc:/qml/Main.qml"));

    // Global C++ exposure to QML below

    std::cout << std::endl << "QT Version: " << qVersion() ;

    HttpClient* client = new HttpClient();
    client->doSomething("Hola desde C++ (Inicio)");
    client->doSomething("Hola desde C++ (Inicio)");

    engine.rootContext()->setContextProperty("httpClient", client); // disponible en QML con este nombre

    qmlRegisterType<QtLottieItem>("blazorin.QtLottie", 1, 0, "LottieItem"); // Register Lottie


    // COMMENT FOR FelgoLive
    engine.load(QUrl(felgo.mainQmlFileName())); // no felgoLive


    // COMMENT FOR NO FelgoLive
    //FelgoLiveClient liveClient(&engine);


    // to start your project as Live Client, comment (remove) the lines "felgo.setMainQmlFileName ..." & "engine.load ...",
    // and uncomment the line below
    //FelgoLiveClient client (&engine);

    return app.exec();
}
