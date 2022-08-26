import QtQuick 2.0
import Felgo 3.0

import "../../../../../helper"

Page {

    id: accountDataPage

    title: qsTr("Datos")
    backgroundColor: pagesBackColorGreyExtra

    property real marginCol: 40

    leftBarItem: GoBackButtonBarItem {
        id: backBtn
    }

    AppFlickable {
          id: scroller

          anchors.fill: parent

          contentWidth: parent.width
          contentHeight: contentColumn.height

          flickableDirection: Flickable.VerticalFlick

      Column {
          id: contentColumn
          anchors.left: parent.left
          anchors.right: parent.right
          anchors.top: parent.top
          anchors.topMargin: marginCol

          anchors.leftMargin: dp(20)
          anchors.rightMargin: dp(20)

          spacing: dp(5)

          CuteText {
              width: parent.width

              text: qsTr("Correo")

              anchors.left: parent.left
              anchors.leftMargin: dp(10)

          }

          Rectangle {
              id: emailRec

              width: parent.width
              height: emailRow.height + 5

              radius: dp(15)

              Row {
                  id: emailRow

                  width: parent.width

                  anchors.left: parent.left
                  anchors.right: parent.right

                  anchors.verticalCenter: parent.verticalCenter


                  anchors.leftMargin: dp(12)


                  spacing: 5

                  Rectangle {
                      id: atIconRect

                      width: atIcon.width + 4
                      height: atIcon.height + 4

                      color: "#5398EA"
                      radius: dp(10)

                      anchors.verticalCenter: parent.verticalCenter

                      Icon {
                         id: atIcon

                         icon: IconType.envelope
                         height: dp(23)
                         width: dp(23)
                         color: "white"

                         anchors.centerIn: parent

                         Component.onCompleted: {
                             atIcon.textItem.font.bold = true
                         }

                      }
                  }

                  // input
                  AppTextInput {
                    id: textInput
                    width: emailRow.width - atIconRect.width - saveBtn.width - 10

                    placeholderText: qsTr("Introduce tu email")
                    font.pixelSize: getTextSize(14)


                    // only allow letters and check length
                    validator: RegExpValidator {
                      regExp: /[A-Za-z0-9@._]+/
                    }

                    maximumLength: 25

                    onTextChanged: {
                        console.debug("[INFO] Email now: " + textInput.text)

                        if (textInput.text == "" || textInput.text == root.email)
                        {
                           saveBtn.canSave = false
                           return;
                        }

                        saveBtn.canSave = true
                    }

                    Component.onCompleted: {
                        textInput.text = root.email

                        if (isTablet)
                            textInput.fontSize = 20
                    }

                  }

                  SaveButtonBarItem {

                          id: saveBtn
                          handlerFunc: () => {
                              //Logic
                              let cachedEmail = textInput.text

                              if (!validateEmail(cachedEmail))
                               {
                                 // Native dialog
                                 NativeDialog.confirm("Error", "Introduce un correo válido.", function(){}, false)

                                 console.debug("[Warning] Invalid email: " + cachedEmail)
                                 return false
                               }



                              root.email = cachedEmail

                              textInput.deselect()
                              textInput.focus = false

                              console.debug("[Info] Updated email: " + cachedEmail)
                              return true
                          }

                          Component.onCompleted: {
                              saveBtn.registerBackButtonItem(backBtn, accountDataPage)
                          }
                      }

              }

          }

          CuteText {
              width: parent.width

              text: qsTr("Es esencial en caso de perder tu dispositivo y/o cuentas vinculadas como " + (Theme.isIos ? "Apple" : "Android" ) + ".")

              anchors.left: parent.left
              anchors.leftMargin: dp(10)

              font.pixelSize: getTextSize(12)

          }

          CuteText {
              width: parent.width

              text: qsTr("¡Y no solo eso! Puedes recibir bromas gratis y participar en nuestras promociones desde la casilla de abajo.")

              anchors.left: parent.left
              anchors.leftMargin: dp(10)

              font.pixelSize: getTextSize(10)

          }

      }

      Column {

          anchors.left: parent.left
          anchors.right: parent.right
          anchors.top: contentColumn.bottom

          anchors.topMargin: marginCol


          SeparatorLine {
              height: 3
              width: parent.width

              color: allowPromoEmails.switchEnabled ? allowPromoEmails.switcher.backgroundColorOn : "#E3E6E8" // Cool, will use this effect more :)
          }


          AppSwitchListItem {
               id: allowPromoEmails

               text: qsTr("Permitir emails de Prankster")
               detailText: qsTr("¡Bromas gratis, novedades y más!")

               dividerLeftSpacing: 0

               onSwitch: (status) => {
                 // Logic
                 if (root.email.length === 0)
                     return


                 root.receiveEmailPromos = status
              }

              enabled: (!(root.email.length === 0))
              switchEnabled: root.receiveEmailPromos

          }
      }
    }

    function validateEmail(mail)
    {
     if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(mail))
        return true


        return false
    }
}
