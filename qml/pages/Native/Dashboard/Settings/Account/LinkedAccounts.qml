import QtQuick 2.0
import Felgo 3.0

import "../../../../../helper"

Page {

    id: linkedAccountsPage

    title: qsTr("Cuentas Vinculadas")
    backgroundColor: pagesBackColorGrey

    property real marginCol: 20

    /*
    leftBarItem: GoBackButtonBarItem {
        id: backBtn
    }*/

    AppFlickable {
          id: scroller

          anchors.fill: parent

          contentWidth: parent.width
          contentHeight: contentColumn.height

          flickableDirection: Flickable.VerticalFlick

          Column {
              id: topColumn
              anchors.left: parent.left
              anchors.right: parent.right
              anchors.top: parent.top
              anchors.topMargin: dp(15)

              anchors.leftMargin: dp(20)
              anchors.rightMargin: dp(20)

              spacing: dp(10)

              PromoRectangle {
                  text: qsTr("¡Vincula tu cuenta y gana una broma!")
                  textSizeInt: 12

                  radius: dp(15)

                  textColor: "#FFFFFF"
                  bgColor: "#35CD79"
                  bold: true

                  visible: !root.isThisDeviceLinked

                  anchors.horizontalCenter: parent.horizontalCenter
              }
          }

      Column {
          id: contentColumn
          anchors.left: parent.left
          anchors.right: parent.right
          anchors.top: topColumn.bottom
          anchors.topMargin: marginCol

          anchors.leftMargin: dp(20)
          anchors.rightMargin: dp(20)

          spacing: dp(10)

          AppImage {
             source: "../../../../../../assets/settings/account_linking_v2.svg"

             width: (!isTablet ? (parent.width / 2) : (parent.width / 3))
             anchors.horizontalCenter: parent.horizontalCenter
             fillMode: Image.PreserveAspectFit


          }

          CuteText {
              width: parent.width

              horizontalAlignment: Text.AlignHCenter
              color: cuteColorSecondary

              text: qsTr("Vincula tu cuenta con ") + (Theme.isIos ? "Apple" : "Google") + (" para en caso de perder el dispositivo recuperarla.")
              font.pixelSize: getTextSize(17, true)

              bottomPadding: dp(10)
          }

          AppleSignIn {
            id: appleSignIn


            onSignInFailed: (message) => {
                  console.debug("Error with AppleLink: " + message)

                  NativeDialog.confirm("Error de vinculación", "Se ha producido un error mientras se vinculaba con Apple: \n" + message, function(){}, false)
             }

             onSignInCompleted: {
                 console.debug("Linked with Apple,  UserID: " + appleSignIn.userId + "  Username: " + appleSignIn.userName)

             }
          }

          AppButton {
            id: appleBtn

            enabled: appleSignIn.isAvailable

            flat: false

            width: parent.width - dp(30)

            verticalPadding: 13

            text: appleSignIn.isAvailable ? qsTr("Vincular con Apple") : qsTr("Vincular con Apple no disponible")
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

          CuteText {

              topPadding: dp(10)
              width: parent.width

              horizontalAlignment: Text.AlignHCenter
              color: cuteColorSecondary

              text: qsTr("Nota: En el caso de vincular a una cuenta ya existente, tu saldo de bromas y subscripción se transferirán.")
              font.pixelSize: getTextSize(12)
          }
      }
    }
}
