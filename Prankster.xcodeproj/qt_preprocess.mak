#############################################################################
# Makefile for building: Prankster.app/Contents/MacOS/Prankster
# Generated by qmake (3.1) (Qt 5.15.2)
# Project:  Prankster.pro
# Template: app
# Command: /Users/alberto/Felgo/Felgo/ios/bin/qmake -o Prankster.xcodeproj/project.pbxproj Prankster.pro -spec macx-xcode CONFIG+=release CONFIG+=iphoneos CONFIG+=device -after
#############################################################################

MAKEFILE      = project.pbxproj

EQ            = =

MOC       = /Users/alberto/Felgo/Felgo/ios/bin/moc
UIC       = /Users/alberto/Felgo/Felgo/ios/bin/uic
LEX       = flex
LEXFLAGS  = 
YACC      = yacc
YACCFLAGS = -d
DEFINES       = -DQT_COMPILER_SUPPORTS_SSE2 -DPRODUCT_LICENSE_KEY=\"667E31EFE21D078D6C1F01A2815E6316BF1D581CCEFB24ACC6261D053CE4BA2690994FE9F236E181364BFA5668B1A29A2567745AD05805F85B48F16B214D5C6E739585133C4871167B0F2956FF7ACBA699F65856CE52EC35615BB89F89212ED2B64C421FAB004441D4D940C116F58D4E17D4D54075E8A263728CD1D6FC1132D33B133441C80F22EFCFC4DBB90875FBFC2FCF4D4EF473F03972EFAA1CF89DAC050A3C6A538CDFCB538365A53BFBD6624B479CD033DF15D9136356C91F8E7B5D6D066FD4873636F017CCB8ECE692250ECD9E9FE8FB64DF1104B8E62C53BCE78CEE556A5FC4B05EB4B7E323751A5D67C0B170B3118622231985C27F8A914A24D2096E4FC26E0BCA89C919FE576E778496E16247E0053C3A81002E44D551C4B5E9BAA6E5CE01FCC32D9953A6E57F6EBC9E012151D122FCA37CA8198957625179EDF937F9FA6667073E713EA50AC346A7ADF2BCC7B7E628A1C0655344F9C3D1F7B163F77F827AAB087D326488199412D09F65D7E57F153BE8F79BB012D1B5B1C8C1BF2F557612F96773C507DB7E87F849DE0BDBA44E900F5ADDDD1433880BBFD76536ED91CAE678E34E34C516130A9BF16CD2F8936BE900BE476490388219F14B89EC80BBD9EA72F76ADC3BD11CEBB23DEED3EF138378EC7C3C90EA63F4ABCD540366B7F4FC5DD0D77325148236891692E791\" -DQT_NO_DEBUG -DQT_SVG_LIB -DQT_WIDGETS_LIB -DQT_QUICK_LIB -DQT_MULTIMEDIA_LIB -DQT_GUI_LIB -DQT_QMLMODELS_LIB -DQT_QML_LIB -DQT_WEBSOCKETS_LIB -DQT_NETWORK_LIB -DQT_SQL_LIB -DQT_BLUETOOTH_LIB -DQT_CORE_LIB
INCPATH       = -I. -I../../../../Felgo/Felgo/ios/mkspecs/common/uikit -IInclude/rest-cpp/include -IInclude/rapidjson -IInclude/rlottie/headers -I../../../../EssentialLibs/boost -I../../../../EssentialLibs/OpenSSL/iphoneos/include -I../../../../Felgo/Felgo/ios/include/Felgo -I../../../../Felgo/Felgo/ios/include -I../../../../Felgo/Felgo/ios/include/QtSvg -I../../../../Felgo/Felgo/ios/include/QtWidgets -I../../../../Felgo/Felgo/ios/include/QtQuick -I../../../../Felgo/Felgo/ios/include/QtMultimedia -I../../../../Felgo/Felgo/ios/include/QtGui -I../../../../Felgo/Felgo/ios/include/QtQmlModels -I../../../../Felgo/Felgo/ios/include/QtQml -I../../../../Felgo/Felgo/ios/include/QtWebSockets -I../../../../Felgo/Felgo/ios/include/QtNetwork -I../../../../Felgo/Felgo/ios/include/QtSql -I../../../../Felgo/Felgo/ios/include/QtBluetooth -I../../../../Felgo/Felgo/ios/include/QtCore -I. -I../../../../Felgo/Felgo/ios/mkspecs/macx-ios-clang
DEL_FILE  = rm -f
MOVE      = mv -f

preprocess: compilers
clean preprocess_clean: compiler_clean

mocclean: compiler_moc_header_clean compiler_moc_objc_header_clean compiler_moc_source_clean

mocables: compiler_moc_header_make_all compiler_moc_objc_header_make_all compiler_moc_source_make_all

check: first

benchmark: first

compilers: qrc_resources_user.cpp moc_HttpClient.cpp moc_qtlottiedrawengine_rlottie.cpp moc_qtlottiedrawengine.cpp\
	 moc_qtlottieitem.cpp moc_qtlottiewidget.cpp
compiler_rcc_make_all: qrc_resources_user.cpp
compiler_rcc_clean:
	-$(DEL_FILE) qrc_resources_user.cpp
qrc_resources_user.cpp: ../../../../Felgo/Felgo/ios/mkspecs/common/felgo/resources_user.qrc \
		../../../../Felgo/Felgo/ios/bin/rcc \
		../../../../Felgo/Felgo/felgo_license.key
	/Users/alberto/Felgo/Felgo/ios/bin/rcc -name resources_user ../../../../Felgo/Felgo/ios/mkspecs/common/felgo/resources_user.qrc -o qrc_resources_user.cpp

compiler_moc_header_make_all: moc_HttpClient.cpp moc_qtlottiedrawengine_rlottie.cpp moc_qtlottiedrawengine.cpp moc_qtlottieitem.cpp moc_qtlottiewidget.cpp
compiler_moc_header_clean:
	-$(DEL_FILE) moc_HttpClient.cpp moc_qtlottiedrawengine_rlottie.cpp moc_qtlottiedrawengine.cpp moc_qtlottieitem.cpp moc_qtlottiewidget.cpp
moc_HttpClient.cpp: Cpp/Http/Impl/HttpClient.h \
		../../../../Felgo/Felgo/ios/include/QtCore/QObject \
		../../../../Felgo/Felgo/ios/include/QtCore/QMap \
		Cpp/Http/Source/Http.h \
		Include/rest-cpp/include/restc-cpp/restc-cpp.h \
		Include/rest-cpp/include/restc-cpp/RequestBuilder.h \
		../../../../Felgo/Felgo/ios/bin/moc
	/Users/alberto/Felgo/Felgo/ios/bin/moc $(DEFINES) -D__APPLE__ -D__GNUC__=4 -D__APPLE_CC__ -D__cplusplus=199711L -D__APPLE_CC__=6000 -D__clang__ -D__clang_major__=13 -D__clang_minor__=1 -D__clang_patchlevel__=6 -D__GNUC__=4 -D__GNUC_MINOR__=2 -D__GNUC_PATCHLEVEL__=1 -I/Users/alberto/Felgo/Felgo/ios/mkspecs/macx-ios-clang -I/Users/alberto/Documents/WorkSpace/Felgo/Prankster -I/Users/alberto/Felgo/Felgo/ios/mkspecs/common/uikit -I/Users/alberto/Documents/WorkSpace/Felgo/Prankster/Include/rest-cpp/include -I/Users/alberto/Documents/WorkSpace/Felgo/Prankster/Include/rapidjson -I/Users/alberto/Documents/WorkSpace/Felgo/Prankster/Include/rlottie/headers -I/Users/alberto/EssentialLibs/boost -I/Users/alberto/EssentialLibs/OpenSSL/iphoneos/include -I/Users/alberto/Felgo/Felgo/ios/include/Felgo -I/Users/alberto/Felgo/Felgo/ios/include -I/Users/alberto/Felgo/Felgo/ios/include/QtSvg -I/Users/alberto/Felgo/Felgo/ios/include/QtWidgets -I/Users/alberto/Felgo/Felgo/ios/include/QtQuick -I/Users/alberto/Felgo/Felgo/ios/include/QtMultimedia -I/Users/alberto/Felgo/Felgo/ios/include/QtGui -I/Users/alberto/Felgo/Felgo/ios/include/QtQmlModels -I/Users/alberto/Felgo/Felgo/ios/include/QtQml -I/Users/alberto/Felgo/Felgo/ios/include/QtWebSockets -I/Users/alberto/Felgo/Felgo/ios/include/QtNetwork -I/Users/alberto/Felgo/Felgo/ios/include/QtSql -I/Users/alberto/Felgo/Felgo/ios/include/QtBluetooth -I/Users/alberto/Felgo/Felgo/ios/include/QtCore -I/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX12.0.sdk/usr/include/c++/v1 -I/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/13.1.6/include -I/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX12.0.sdk/usr/include -I/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include Cpp/Http/Impl/HttpClient.h -o moc_HttpClient.cpp

moc_qtlottiedrawengine_rlottie.cpp: Cpp/Lottie/qtlottiedrawengine_rlottie.h \
		Cpp/Lottie/qtlottiedrawengine.h \
		Cpp/Lottie/qtlottie_global.h \
		../../../../Felgo/Felgo/ios/include/QtCore/qglobal.h \
		../../../../Felgo/Felgo/ios/include/QtCore/qobject.h \
		../../../../Felgo/Felgo/ios/include/QtCore/qurl.h \
		../../../../Felgo/Felgo/ios/include/QtCore/qsize.h \
		../../../../Felgo/Felgo/ios/bin/moc
	/Users/alberto/Felgo/Felgo/ios/bin/moc $(DEFINES) -D__APPLE__ -D__GNUC__=4 -D__APPLE_CC__ -D__cplusplus=199711L -D__APPLE_CC__=6000 -D__clang__ -D__clang_major__=13 -D__clang_minor__=1 -D__clang_patchlevel__=6 -D__GNUC__=4 -D__GNUC_MINOR__=2 -D__GNUC_PATCHLEVEL__=1 -I/Users/alberto/Felgo/Felgo/ios/mkspecs/macx-ios-clang -I/Users/alberto/Documents/WorkSpace/Felgo/Prankster -I/Users/alberto/Felgo/Felgo/ios/mkspecs/common/uikit -I/Users/alberto/Documents/WorkSpace/Felgo/Prankster/Include/rest-cpp/include -I/Users/alberto/Documents/WorkSpace/Felgo/Prankster/Include/rapidjson -I/Users/alberto/Documents/WorkSpace/Felgo/Prankster/Include/rlottie/headers -I/Users/alberto/EssentialLibs/boost -I/Users/alberto/EssentialLibs/OpenSSL/iphoneos/include -I/Users/alberto/Felgo/Felgo/ios/include/Felgo -I/Users/alberto/Felgo/Felgo/ios/include -I/Users/alberto/Felgo/Felgo/ios/include/QtSvg -I/Users/alberto/Felgo/Felgo/ios/include/QtWidgets -I/Users/alberto/Felgo/Felgo/ios/include/QtQuick -I/Users/alberto/Felgo/Felgo/ios/include/QtMultimedia -I/Users/alberto/Felgo/Felgo/ios/include/QtGui -I/Users/alberto/Felgo/Felgo/ios/include/QtQmlModels -I/Users/alberto/Felgo/Felgo/ios/include/QtQml -I/Users/alberto/Felgo/Felgo/ios/include/QtWebSockets -I/Users/alberto/Felgo/Felgo/ios/include/QtNetwork -I/Users/alberto/Felgo/Felgo/ios/include/QtSql -I/Users/alberto/Felgo/Felgo/ios/include/QtBluetooth -I/Users/alberto/Felgo/Felgo/ios/include/QtCore -I/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX12.0.sdk/usr/include/c++/v1 -I/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/13.1.6/include -I/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX12.0.sdk/usr/include -I/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include Cpp/Lottie/qtlottiedrawengine_rlottie.h -o moc_qtlottiedrawengine_rlottie.cpp

moc_qtlottiedrawengine.cpp: Cpp/Lottie/qtlottiedrawengine.h \
		Cpp/Lottie/qtlottie_global.h \
		../../../../Felgo/Felgo/ios/include/QtCore/qglobal.h \
		../../../../Felgo/Felgo/ios/include/QtCore/qobject.h \
		../../../../Felgo/Felgo/ios/include/QtCore/qurl.h \
		../../../../Felgo/Felgo/ios/include/QtCore/qsize.h \
		../../../../Felgo/Felgo/ios/bin/moc
	/Users/alberto/Felgo/Felgo/ios/bin/moc $(DEFINES) -D__APPLE__ -D__GNUC__=4 -D__APPLE_CC__ -D__cplusplus=199711L -D__APPLE_CC__=6000 -D__clang__ -D__clang_major__=13 -D__clang_minor__=1 -D__clang_patchlevel__=6 -D__GNUC__=4 -D__GNUC_MINOR__=2 -D__GNUC_PATCHLEVEL__=1 -I/Users/alberto/Felgo/Felgo/ios/mkspecs/macx-ios-clang -I/Users/alberto/Documents/WorkSpace/Felgo/Prankster -I/Users/alberto/Felgo/Felgo/ios/mkspecs/common/uikit -I/Users/alberto/Documents/WorkSpace/Felgo/Prankster/Include/rest-cpp/include -I/Users/alberto/Documents/WorkSpace/Felgo/Prankster/Include/rapidjson -I/Users/alberto/Documents/WorkSpace/Felgo/Prankster/Include/rlottie/headers -I/Users/alberto/EssentialLibs/boost -I/Users/alberto/EssentialLibs/OpenSSL/iphoneos/include -I/Users/alberto/Felgo/Felgo/ios/include/Felgo -I/Users/alberto/Felgo/Felgo/ios/include -I/Users/alberto/Felgo/Felgo/ios/include/QtSvg -I/Users/alberto/Felgo/Felgo/ios/include/QtWidgets -I/Users/alberto/Felgo/Felgo/ios/include/QtQuick -I/Users/alberto/Felgo/Felgo/ios/include/QtMultimedia -I/Users/alberto/Felgo/Felgo/ios/include/QtGui -I/Users/alberto/Felgo/Felgo/ios/include/QtQmlModels -I/Users/alberto/Felgo/Felgo/ios/include/QtQml -I/Users/alberto/Felgo/Felgo/ios/include/QtWebSockets -I/Users/alberto/Felgo/Felgo/ios/include/QtNetwork -I/Users/alberto/Felgo/Felgo/ios/include/QtSql -I/Users/alberto/Felgo/Felgo/ios/include/QtBluetooth -I/Users/alberto/Felgo/Felgo/ios/include/QtCore -I/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX12.0.sdk/usr/include/c++/v1 -I/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/13.1.6/include -I/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX12.0.sdk/usr/include -I/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include Cpp/Lottie/qtlottiedrawengine.h -o moc_qtlottiedrawengine.cpp

moc_qtlottieitem.cpp: Cpp/Lottie/qtlottieitem.h \
		Cpp/Lottie/qtlottie_global.h \
		../../../../Felgo/Felgo/ios/include/QtCore/qglobal.h \
		../../../../Felgo/Felgo/ios/include/QtQuick/qquickpainteditem.h \
		../../../../Felgo/Felgo/ios/include/QtCore/qtimer.h \
		../../../../Felgo/Felgo/ios/bin/moc
	/Users/alberto/Felgo/Felgo/ios/bin/moc $(DEFINES) -D__APPLE__ -D__GNUC__=4 -D__APPLE_CC__ -D__cplusplus=199711L -D__APPLE_CC__=6000 -D__clang__ -D__clang_major__=13 -D__clang_minor__=1 -D__clang_patchlevel__=6 -D__GNUC__=4 -D__GNUC_MINOR__=2 -D__GNUC_PATCHLEVEL__=1 -I/Users/alberto/Felgo/Felgo/ios/mkspecs/macx-ios-clang -I/Users/alberto/Documents/WorkSpace/Felgo/Prankster -I/Users/alberto/Felgo/Felgo/ios/mkspecs/common/uikit -I/Users/alberto/Documents/WorkSpace/Felgo/Prankster/Include/rest-cpp/include -I/Users/alberto/Documents/WorkSpace/Felgo/Prankster/Include/rapidjson -I/Users/alberto/Documents/WorkSpace/Felgo/Prankster/Include/rlottie/headers -I/Users/alberto/EssentialLibs/boost -I/Users/alberto/EssentialLibs/OpenSSL/iphoneos/include -I/Users/alberto/Felgo/Felgo/ios/include/Felgo -I/Users/alberto/Felgo/Felgo/ios/include -I/Users/alberto/Felgo/Felgo/ios/include/QtSvg -I/Users/alberto/Felgo/Felgo/ios/include/QtWidgets -I/Users/alberto/Felgo/Felgo/ios/include/QtQuick -I/Users/alberto/Felgo/Felgo/ios/include/QtMultimedia -I/Users/alberto/Felgo/Felgo/ios/include/QtGui -I/Users/alberto/Felgo/Felgo/ios/include/QtQmlModels -I/Users/alberto/Felgo/Felgo/ios/include/QtQml -I/Users/alberto/Felgo/Felgo/ios/include/QtWebSockets -I/Users/alberto/Felgo/Felgo/ios/include/QtNetwork -I/Users/alberto/Felgo/Felgo/ios/include/QtSql -I/Users/alberto/Felgo/Felgo/ios/include/QtBluetooth -I/Users/alberto/Felgo/Felgo/ios/include/QtCore -I/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX12.0.sdk/usr/include/c++/v1 -I/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/13.1.6/include -I/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX12.0.sdk/usr/include -I/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include Cpp/Lottie/qtlottieitem.h -o moc_qtlottieitem.cpp

moc_qtlottiewidget.cpp: Cpp/Lottie/qtlottiewidget.h \
		Cpp/Lottie/qtlottie_global.h \
		../../../../Felgo/Felgo/ios/include/QtCore/qglobal.h \
		../../../../Felgo/Felgo/ios/include/QtWidgets/qwidget.h \
		../../../../Felgo/Felgo/ios/include/QtCore/qurl.h \
		../../../../Felgo/Felgo/ios/include/QtCore/qtimer.h \
		../../../../Felgo/Felgo/ios/bin/moc
	/Users/alberto/Felgo/Felgo/ios/bin/moc $(DEFINES) -D__APPLE__ -D__GNUC__=4 -D__APPLE_CC__ -D__cplusplus=199711L -D__APPLE_CC__=6000 -D__clang__ -D__clang_major__=13 -D__clang_minor__=1 -D__clang_patchlevel__=6 -D__GNUC__=4 -D__GNUC_MINOR__=2 -D__GNUC_PATCHLEVEL__=1 -I/Users/alberto/Felgo/Felgo/ios/mkspecs/macx-ios-clang -I/Users/alberto/Documents/WorkSpace/Felgo/Prankster -I/Users/alberto/Felgo/Felgo/ios/mkspecs/common/uikit -I/Users/alberto/Documents/WorkSpace/Felgo/Prankster/Include/rest-cpp/include -I/Users/alberto/Documents/WorkSpace/Felgo/Prankster/Include/rapidjson -I/Users/alberto/Documents/WorkSpace/Felgo/Prankster/Include/rlottie/headers -I/Users/alberto/EssentialLibs/boost -I/Users/alberto/EssentialLibs/OpenSSL/iphoneos/include -I/Users/alberto/Felgo/Felgo/ios/include/Felgo -I/Users/alberto/Felgo/Felgo/ios/include -I/Users/alberto/Felgo/Felgo/ios/include/QtSvg -I/Users/alberto/Felgo/Felgo/ios/include/QtWidgets -I/Users/alberto/Felgo/Felgo/ios/include/QtQuick -I/Users/alberto/Felgo/Felgo/ios/include/QtMultimedia -I/Users/alberto/Felgo/Felgo/ios/include/QtGui -I/Users/alberto/Felgo/Felgo/ios/include/QtQmlModels -I/Users/alberto/Felgo/Felgo/ios/include/QtQml -I/Users/alberto/Felgo/Felgo/ios/include/QtWebSockets -I/Users/alberto/Felgo/Felgo/ios/include/QtNetwork -I/Users/alberto/Felgo/Felgo/ios/include/QtSql -I/Users/alberto/Felgo/Felgo/ios/include/QtBluetooth -I/Users/alberto/Felgo/Felgo/ios/include/QtCore -I/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX12.0.sdk/usr/include/c++/v1 -I/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/13.1.6/include -I/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX12.0.sdk/usr/include -I/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include Cpp/Lottie/qtlottiewidget.h -o moc_qtlottiewidget.cpp

compiler_moc_objc_header_make_all:
compiler_moc_objc_header_clean:
compiler_moc_source_make_all:
compiler_moc_source_clean:
compiler_uic_make_all:
compiler_uic_clean:
compiler_rez_source_make_all:
compiler_rez_source_clean:
compiler_yacc_decl_make_all:
compiler_yacc_decl_clean:
compiler_yacc_impl_make_all:
compiler_yacc_impl_clean:
compiler_lex_make_all:
compiler_lex_clean:
compiler_clean: compiler_rcc_clean compiler_moc_header_clean 

