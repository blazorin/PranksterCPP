# allows to add DEPLOYMENTFOLDERS and links to the Felgo library and QtCreator auto-completion
CONFIG += felgo
CONFIG+=sdk_no_version_check
QMAKE_MACOSX_DEPLOYMENT_TARGET = 11.0

# uncomment this line to add the Live Client Module and use live reloading with your custom C++ code
# for the remaining steps to build a custom Live Code Reload app see here: https://felgo.com/custom-code-reload-app/
# CONFIG += felgo-live

# Project identifier and version
# More information: https://felgo.com/doc/felgo-publishing/#project-configuration
PRODUCT_IDENTIFIER = com.albertoromero.prankster
PRODUCT_VERSION_NAME = 1.0.0
PRODUCT_VERSION_CODE = 1

# Optionally set a license key that is used instead of the license key from
# main.qml file (App::licenseKey for your app or GameWindow::licenseKey for your game)
# Only used for local builds and Felgo Cloud Builds (https://felgo.com/cloud-builds)
# Not used if using Felgo Live
PRODUCT_LICENSE_KEY = "667E31EFE21D078D6C1F01A2815E6316BF1D581CCEFB24ACC6261D053CE4BA2690994FE9F236E181364BFA5668B1A29A2567745AD05805F85B48F16B214D5C6E739585133C4871167B0F2956FF7ACBA699F65856CE52EC35615BB89F89212ED2B64C421FAB004441D4D940C116F58D4E17D4D54075E8A263728CD1D6FC1132D33B133441C80F22EFCFC4DBB90875FBFC2FCF4D4EF473F03972EFAA1CF89DAC050A3C6A538CDFCB538365A53BFBD6624B479CD033DF15D9136356C91F8E7B5D6D066FD4873636F017CCB8ECE692250ECD9E9FE8FB64DF1104B8E62C53BCE78CEE556A5FC4B05EB4B7E323751A5D67C0B170B3118622231985C27F8A914A24D2096E4FC26E0BCA89C919FE576E778496E16247E0053C3A81002E44D551C4B5E9BAA6E5CE01FCC32D9953A6E57F6EBC9E012151D122FCA37CA8198957625179EDF937F9FA6667073E713EA50AC346A7ADF2BCC7B7E628A1C0655344F9C3D1F7B163F77F827AAB087D326488199412D09F65D7E57F153BE8F79BB012D1B5B1C8C1BF2F557612F96773C507DB7E87F849DE0BDBA44E900F5ADDDD1433880BBFD76536ED91CAE678E34E34C516130A9BF16CD2F8936BE900BE476490388219F14B89EC80BBD9EA72F76ADC3BD11CEBB23DEED3EF138378EC7C3C90EA63F4ABCD540366B7F4FC5DD0D77325148236891692E791"

qmlFolder.source = qml
DEPLOYMENTFOLDERS += qmlFolder # comment for publishing

assetsFolder.source = assets
DEPLOYMENTFOLDERS += assetsFolder

# Add more folders to ship with the application here

# RESOURCES += resources.qrc # uncomment for publishing

# NOTE: for PUBLISHING, perform the following steps:
# 1. comment the DEPLOYMENTFOLDERS += qmlFolder line above, to avoid shipping your qml files with the application (instead they get compiled to the app binary)
# 2. uncomment the resources.qrc file inclusion and add any qml subfolders to the .qrc file; this compiles your qml files and js files to the app binary and protects your source code
# 3. change the setMainQmlFile() call in main.cpp to the one starting with "qrc:/" - this loads the qml files from the resources
# for more details see the "Deployment Guides" in the Felgo Documentation

# during development, use the qmlFolder deployment because you then get shorter compilation times (the qml files do not need to be compiled to the binary but are just copied)
# also, for quickest deployment on Desktop disable the "Shadow Build" option in Projects/Builds - you can then select "Run Without Deployment" from the Build menu in Qt Creator if you only changed QML files; this speeds up application start, because your app is not copied & re-compiled but just re-interpreted


# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    Cpp/Http/Source/Http.cpp \
    Cpp/Http/Impl/HttpClient.cpp \
    Include/rest-cpp/src/ChunkedReaderImpl.cpp \
    Include/rest-cpp/src/ChunkedWriterImpl.cpp \
    Include/rest-cpp/src/ConnectionImpl.h \
    Include/rest-cpp/src/ConnectionPoolImpl.cpp \
    Include/rest-cpp/src/DataReaderStream.cpp \
    Include/rest-cpp/src/IoReaderImpl.cpp \
    Include/rest-cpp/src/IoWriterImpl.cpp \
    Include/rest-cpp/src/NoBodyReaderImpl.cpp \
    Include/rest-cpp/src/PlainReaderImpl.cpp \
    Include/rest-cpp/src/PlainWriterImpl.cpp \
    Include/rest-cpp/src/ReplyImpl.cpp \
    Include/rest-cpp/src/ReplyImpl.h \
    Include/rest-cpp/src/RequestBodyFileImpl.cpp \
    Include/rest-cpp/src/RequestBodyStringImpl.cpp \
    Include/rest-cpp/src/RequestImpl.cpp \
    Include/rest-cpp/src/RestClientImpl.cpp \
    Include/rest-cpp/src/SocketImpl.h \
    Include/rest-cpp/src/TlsSocketImpl.h \
    Include/rest-cpp/src/TlsSocketImpl.h \
    Include/rest-cpp/src/Url.cpp \
    Include/rest-cpp/src/url_encode.cpp \
    Cpp/Lottie/qtlottiedrawengine_rlottie.cpp \
    Cpp/Lottie/qtlottiedrawenginefactory.cpp \
    Cpp/Lottie/qtlottieitem.cpp \
    Cpp/Lottie/qtlottiewidget.cpp

#FELGO_PLUGINS += admob
#FELGO_PLUGINS += soomla
#FELGO_PLUGINS += facebook
#FELGO_PLUGINS += onesignal
#FELGO_PLUGINS += amplitude
#FELGO_PLUGINS += gamecenter

FELGO_PLUGINS += applesignin


# App entitlements (for apple sign in)
APP_ENTITLEMENTS.name = CODE_SIGN_ENTITLEMENTS
APP_ENTITLEMENTS.value = $$PWD/ios/App.entitlements
QMAKE_MAC_XCODE_SETTINGS += APP_ENTITLEMENTS
OTHER_FILES += $$APP_ENTITLEMENTS.value

CONFIG += c++17

QT += svg

INCLUDEPATH += Include/rest-cpp/include/
INCLUDEPATH += Include/rapidjson/
INCLUDEPATH += Include/rlottie/headers/

USER_PATH = /Users/alberto

android {
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
    OTHER_FILES += android/AndroidManifest.xml       android/build.gradle
}

ios {

    QMAKE_INFO_PLIST = ios/Project-Info.plist
    OTHER_FILES += $$QMAKE_INFO_PLIST

    ## Boost
    INCLUDEPATH += "$${USER_PATH}/EssentialLibs/boost"
    LIBS += -L"$${USER_PATH}/EssentialLibs/boost/stage/ios/lib"
    LIBS += -lboost_system -lboost_thread -lboost_filesystem -lboost_context -lboost_coroutine-mt

    # OpenSSL
    INCLUDEPATH += "$${USER_PATH}/EssentialLibs/OpenSSL/iphoneos/include/"
    LIBS += -L$${USER_PATH}/EssentialLibs/OpenSSL/iphoneos/lib
    LIBS += -lssl -lcrypto

    # rlottie Engine
    LIBS += -L$$PWD/Include/rlottie/ios
    LIBS += -lrlottie
}

# set application icons for win and macx
win32 {
    RC_FILE += win/app_icon.rc
}

macx {

    CONFIG += felgo-live

    ICON = macx/app_icon.icns

    ## Boost
    INCLUDEPATH += "$${USER_PATH}/EssentialLibs/boost"
    LIBS += -L"$${USER_PATH}/EssentialLibs/boost/stage/macosx/lib"
    LIBS += -lboost_system -lboost_thread -lboost_filesystem -lboost_coroutine-mt

    # OpenSSL
    INCLUDEPATH += "$${USER_PATH}/EssentialLibs/OpenSSL/macosx/include/"
    LIBS += -L$${USER_PATH}/EssentialLibs/OpenSSL/macosx/lib
    LIBS += -lssl -lcrypto

    # rlottie Engine
    LIBS += -L$$PWD/Include/rlottie/mac
    LIBS += -lrlottie
}

DISTFILES += \
    ios/App.entitlements \
    qml/PropertyCrossMainItem.qml \
    qml/helper/ActionButton.qml \
    qml/helper/AnimationHelper.qml \
    qml/helper/AppSwitchListItem.qml \
    qml/helper/CuteText.qml \
    qml/helper/FeatureRow.qml \
    qml/helper/GoBackButtonBarItem.qml \
    qml/helper/ListSeparator.qml \
    qml/helper/PromoRectangle.qml \
    qml/helper/RedBubble.qml \
    qml/helper/SaveButtonBarItem.qml \
    qml/helper/SeparatorLine.qml \
    qml/model/DataModel.qml \
    qml/model/Logic.qml \
    qml/pages/Native/Auth.qml \
    qml/pages/Native/Dashboard/DashLayoutTab.qml \
    qml/pages/Native/Dashboard/Settings/Account/AccountData.qml \
    qml/pages/Native/Dashboard/Settings/Account/LinkedAccounts.qml \
    qml/pages/Native/Dashboard/Settings/Community/Privacy.qml \
    qml/pages/Native/Dashboard/Settings/Community/Visibility.qml \
    qml/pages/Native/Dashboard/Settings/Payments/InAppPurchases.qml \
    qml/pages/Native/Dashboard/Settings/Payments/Subscription.qml \
    qml/pages/Native/Dashboard/Settings/Payments/SubscriptionStore.qml \
    qml/pages/Native/Dashboard/Settings/Profile/AvatarSelection.qml \
    qml/pages/Native/Dashboard/Settings/Profile/MyProfile.qml \
    qml/pages/Native/Dashboard/SettingsTab.qml \
    qml/pages/Native/ListingDetailPage.qml \
    qml/pages/Native/ListingsListPage.qml \
    qml/pages/Native/PropertyCrossMainPage.qml \
    qml/model/CppHelper.qml \
    qml/helper/CopyText.qml \
    qml/pages/Native/Welcome.qml

HEADERS += \
    Cpp/Http/Source/Http.h \
    Cpp/Http/Impl/HttpClient.h \
    Cpp/Lottie/qtlottie_global.h \
    Cpp/Lottie/qtlottiedrawengine_rlottie.h \
    Cpp/Lottie/qtlottiedrawengine.h \
    Cpp/Lottie/qtlottiedrawenginefactory.h \
    Cpp/Lottie/qtlottieitem.h \
    Cpp/Lottie/qtlottiewidget.h \
