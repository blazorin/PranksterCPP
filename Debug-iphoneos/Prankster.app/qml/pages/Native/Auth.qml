import QtQuick 2.0
import Felgo 3.0
import Qt.labs.lottieqt 1.0
import blazorin.QtLottie 1.0
import "../../helper"
import "Dashboard"

Page {

    // Switch:
    property bool newAccountDebug: true
    property bool skipLoginDebug: true && newAccountDebug
    property bool skipToDashboard: false && newAccountDebug


    property bool appleLoginHappening
    property bool continueLoginHappening: true // fast fingers

    property bool isApple

    id: searchPage
    title: qsTr("Search Cross")
    backgroundColor: pagesBackColor

    // Truquito :)

    AppText {
        id: posHelper

        anchors.verticalCenter: parent.verticalCenter

        visible: false
        text: "*"

        Component.onCompleted: {
            console.debug("Initial poshelper y: " + y)
        }
    }

    Column {
        id: contentColumn
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: contentPadding
        //anchors.topMargin: dp(30)

        AppImage {
           source: "../../../assets/prankster-logo.svg"
           width: parent.width
           anchors.horizontalCenter: parent.horizontalCenter
           fillMode: Image.PreserveAspectFit

        }



        Item {

            id: initialLottie

            anchors.horizontalCenter: parent.horizontalCenter

            width: 256
            height: 256

            //y: posHelper.y - (height / 1.6) // tripa
            visible: false
            // posHelperY is 0 on app startup while rendering


           // This helps to position. LottieItem is lost on that on startup
           LottieAnimation {
                  visible: false
                  source: "../../../assets/lottie/sheep_auth.json"

           }

           LottieItem {
               source: "../../../assets/lottie/sheep_auth.json"
               anchors.fill: parent
           }

           Component.onCompleted: {
               lottiePositionerTimer.running = true

               console.debug("Initial lottie y: " + y)
           }


        }


        // Workarround for correct positioning on low-end devices (app startup)
        Timer {
            id: lottiePositionerTimer
             interval: 15 // 2000
             repeat: true
             running: false
             triggeredOnStart: true

             onTriggered: {

                 if (posHelper.y >= 100) // has centered
                 {
                     initialLottie.y = posHelper.y - (initialLottie.height / 1.58)

                     console.debug("Final lottie y: " + initialLottie.y)
                     initialLottie.visible = true

                     lottiePositionerTimer.running = false
                 }
             }

        }

    }

    Column {
        id: bottomColumn
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: contentPadding

        spacing: dp(18)

        AppText {
            id: welcomeText
            width: parent.width
            text: qsTr("Inicia sesión o continua directamente.")
            font.pixelSize: getTextSize(17)

            horizontalAlignment: Text.AlignHCenter

            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        }

        AppleSignIn {
          id: appleSignIn


          onSignInFailed: (message) => {
                console.debug("Error with AppleLogIn: " + message)

                NativeDialog.confirm("Login error", "An error ocurred while performing Apple Sign In: \n" + message, function(){}, false)
           }

           onSignInCompleted: {
               console.debug("Logged with Apple,  UserID: " + appleSignIn.userId + "  Username: " + appleSignIn.userName)

               continueLoginHappening = true
               isApple = true

               continueBtn.text = "ㅤ" // Invisible character
               continueSpinner.visible = true

               authTimer.running = true

           }
        }

        AppButton {
          id: appleBtn

          enabled: appleSignIn.isAvailable && !continueLoginHappening

          flat: false

          width: parent.width - dp(30)

          verticalPadding: 13

          text: appleSignIn.isAvailable ? qsTr("Iniciar sesión con Apple") : qsTr("Iniciar sesión con Apple no disponible")
          textSize: getTextSize(12)
          textFormat: Text.StyledText
          textColor: "#FFFFFF"
          textColorPressed: "#FFFFFF"

          backgroundColor: "#000000"
          backgroundColorPressed: "#8E9399"
          disabledColor: "#8E9399"
          textColorDisabled: "#FFFFFF"

          borderColor: "#000000"
          borderColorPressed: "#8E9399"
          radius: dp(10)

          iconLeft: IconType.apple

          anchors.horizontalCenter: parent.horizontalCenter


          onClicked: appleSignIn.signIn()


          Component.onCompleted: {
              if (appleBtn.width > 450) {

                  appleBtn.width = 450
                  verticalPadding = 12

              }
          }

        }

        ActionButton {
          id: continueBtn

          enabled: !appleLoginHappening && !continueLoginHappening

          width: parent.width - dp(30)

          text: qsTr("Continuar")

          textSize: 11
          fontBold: true

          textColor: "#FFFFFF"
          textColorDisabled: "#ECEFF2"
          backgroundColor: "#047AFF"
          backgroundColorPressed: "#086CDC" // Pressed/disabled background color


          anchors.horizontalCenter: parent.horizontalCenter

          AppActivityIndicator {
              id: continueSpinner

              height: parent.height
              iconSize: 15

              anchors.horizontalCenter: parent.horizontalCenter

              animating: true
              visible: false

              color: continueBtn.textColorDisabled
              animationDuration: 1500
          }


          onClicked: {
              if (continueLoginHappening)
                  return;

              continueLoginHappening = true

              text = "ㅤ" // Invisible character
              continueSpinner.visible = true

              isApple = false
              authTimer.running = true

          }
        }

       CopyText { }

    }

    Timer {
        id: authTimer
         interval: 200 // 2000
         repeat: false
         running: false
         onTriggered: {

          if (doAuth(isApple))
          {
              continueSpinner.visible = false
              continueBtn.text = qsTr("Continuar")

              // Logic for authPage (navStack)

              if (!skipToDashboard)
                navigationStack.push(welcomePageComponent)
              else
                navigationStack.push(dashLayoutPageComponent)

              // navStack called
              continueLoginHappening = false
              authTimer.running = false
              return;
          }

          // Auth failed, renable buttons

          continueLoginHappening = false

          continueSpinner.visible = false
          continueBtn.text = qsTr("Continuar")

          authTimer.running = false

         }
    }

    function doAuth(isApple) {

        if (skipLoginDebug)
            return true

        var deviceModel = nativeUtils.deviceModel()
        var deviceKind = system.isPlatform(System.IOS) ? "0" : "1"


        if (isApple && (appleSignIn.userId === ""))
            isApple = false

        var userId = isApple ? appleSignIn.userId : "new"
        if (serverUserId !== "")
            userId = serverUserId


        var jsonPayload = "{\"USER\": \""+ userId +"\", \"DEVICE_MODEL\": \""+ deviceModel + "\", \"LOGIN_IP\": \""+ "1.1.1.1" + "\", \"DEVICE_KIND\": "+ deviceKind + "}"



        var requestResult = cppHelper.httpRequest("v1/account/auth", 1, jsonPayload);

        if (requestResult.result === false)
            return false

        // Set locals
        serverUserId = requestResult.responseObj["userId"]
        bearerToken = requestResult.responseObj["token"]

        subscriptionKind = requestResult.responseObj["subscriptionKind"]
        subscriptionEndDate = requestResult.responseObj["subscriptionEnd"]

        console.debug(serverUserId + " : " + bearerToken + " : " + subscriptionKind + " : " + subscriptionEndDate)

        // Store userId and bearer on keychain
        nativeUtils.setKeychainValue("userId", serverUserId)

        console.debug("\nkeychain userId set: " + nativeUtils.getKeychainValue("userId"))

        return true
    }

    Component.onCompleted: {

        //console.debug(animation.currentFrame + "/" + animation.frameCount)
        var keychainUserId = nativeUtils.getKeychainValue("userId")

        if (keychainUserId === "" || keychainUserId === "undefined" || newAccountDebug)
        {
            continueLoginHappening = false
            return
        }


        // Make login

        serverUserId = keychainUserId
        console.debug("\nStartup-retrieved userId: " + serverUserId)

        continueLoginHappening = true
        continueBtn.text = "ㅤ" // Invisible character
        continueSpinner.animating = true
        continueSpinner.visible = true

        authTimer.running = true

    }

    Component {
        id: welcomePageComponent

        Welcome { }
    }

    Component {
        id: dashLayoutPageComponent

        DashLayoutTab {}
    }


    navigationBarHidden: true
}
