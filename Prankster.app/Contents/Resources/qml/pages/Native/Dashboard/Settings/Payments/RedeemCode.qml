import QtQuick 2.0
import Felgo 3.0

import "../../../../../helper"

Page {
    id: redeemCodePage

    title: qsTr("Canjear Código")
    backgroundColor: pagesBackColorGreyExtra

    property real marginCol: 35

    leftBarItem: GoBackButtonBarItem {
        id: backBtn
    }

    AppFlickable {
          id: scroller

          anchors.fill: parent

          contentWidth: parent.width
          contentHeight: contentColumn.height + imageColumn.height + marginCol

          flickableDirection: Flickable.VerticalFlick

      Column {
          id: imageColumn

          anchors.left: parent.left
          anchors.right: parent.right
          anchors.top: parent.top
          anchors.topMargin: marginCol

          anchors.leftMargin: dp(20)
          anchors.rightMargin: dp(20)

          spacing: dp(20)

          AppImage {
             source: "../../../../../../assets/settings/giftcard_globe_v2.svg"

             width: (!isTablet ? (parent.width / 1.5) : (parent.width / 2.7))
             anchors.horizontalCenter: parent.horizontalCenter
             fillMode: Image.PreserveAspectFit


          }

      }

      Column {
          id: contentColumn

          anchors.left: parent.left
          anchors.right: parent.right
          anchors.top: imageColumn.bottom
          anchors.topMargin: 20

          anchors.leftMargin: dp(20)
          anchors.rightMargin: dp(20)

          spacing: dp(20)

          AppText {
              width: parent.width
              wrapMode: Text.WrapAtWordBoundaryOrAnywhere

              horizontalAlignment: Text.AlignHCenter

              text: qsTr("Introduce tu código")
              font.pixelSize: getTextSize(23)

              font.weight: Font.ExtraLight
          }

          Rectangle {
              id: redeemRec

              width: parent.width
              height: redeemRow.height + 5

              radius: dp(15)

              anchors.horizontalCenter: parent.horizontalCenter

              Row {
                  id: redeemRow

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

                      color: svgColor
                      radius: dp(10)

                      anchors.verticalCenter: parent.verticalCenter

                      Icon {
                         id: atIcon

                         icon: IconType.gift
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
                    width: redeemRow.width - atIconRect.width - saveBtn.width - 10

                    placeholderText: qsTr("Código")
                    font.pixelSize: getTextSize(17, true)


                    // only allow letters and check length
                    validator: RegExpValidator {
                      regExp: /[A-Za-z0-9]+/
                    }

                    maximumLength: 15

                    onTextChanged: {

                        if (textInput.text == "" || textInput.text.length < 5)
                        {
                           saveBtn.canSave = false
                           return;
                        }

                        saveBtn.canSave = true
                    }

                    Component.onCompleted: {
                        if (isTablet)
                            textInput.fontSize = 18
                    }

                  }

                  SaveButtonBarItem {

                          id: saveBtn
                          handlerFunc: () => {
                              //Logic
                              let cachedCode = textInput.text



                              textInput.deselect()
                              textInput.focus = false
                              textInput.text = ""

                              // NativeDialog

                              console.debug("[Info] Redeemed code: " + cachedCode)

                              return true
                          }

                          Component.onCompleted: {
                              saveBtn.registerBackButtonItem(backBtn, redeemCodePage)

                              // No es Guardando ni Guardar en este caso:
                              saveBtn.statuses[1] = "Canjear"
                              saveBtn.statuses[2] = "Comprobando"
                          }
                      }

              }

          }

          AppText {
              width: parent.width
              wrapMode: Text.WrapAtWordBoundaryOrAnywhere
              topPadding: dp(20)

              horizontalAlignment: Text.AlignHCenter

              text: qsTr("¿Dónde puedo encontrar códigos?")
              font.pixelSize: getTextSize(19, true)

              font.weight: Font.ExtraLight
          }

          CuteText {
              width: parent.width

              text: qsTr("¡En nuestras redes!")


              horizontalAlignment: Text.AlignHCenter

              font.pixelSize: getTextSize(12)

          }
          CuteText {
              width: parent.width

              text: qsTr("Síguenos en todas y te daremos un regalito ;)")


              horizontalAlignment: Text.AlignHCenter

              font.pixelSize: getTextSize(12)

          }

          // Links

          Row {

              id: socialRow
              anchors.horizontalCenter: parent.horizontalCenter

              spacing: 15

          AppImage {
                 width: 64 // works good for all!

                 fillMode: Image.PreserveAspectFit

                 source: "../../../../../../assets/social/instagram.svg"

                 MouseArea {
                     anchors.fill: parent

                     onClicked: {
                         nativeUtils.openUrl("https://www.miraclia.com/t%C3%A9rminos-y-condiciones-de-uso")
                     }
                 }

                 CuteText {
                     width: parent.width

                     text: qsTr("Instagram")
                     topPadding: 11

                     anchors.top: parent.bottom


                     horizontalAlignment: Text.AlignHCenter

                     font.pixelSize: getTextSize(12)

                     MouseArea {
                         anchors.fill: parent

                         onClicked: {
                             nativeUtils.openUrl("https://www.miraclia.com/t%C3%A9rminos-y-condiciones-de-uso")
                         }
                     }

                 }
            }

          AppImage {
                 width: 64 // works good for all!

                 fillMode: Image.PreserveAspectFit

                 source: "../../../../../../assets/social/youtube_8.svg"

                 MouseArea {
                     anchors.fill: parent

                     onClicked: {
                         nativeUtils.openUrl("https://www.miraclia.com/t%C3%A9rminos-y-condiciones-de-uso")
                     }
                 }

                 CuteText {
                     width: parent.width

                     text: qsTr("YouTube")
                     topPadding: 11

                     anchors.top: parent.bottom


                     horizontalAlignment: Text.AlignHCenter

                     font.pixelSize: getTextSize(12)

                     MouseArea {
                         anchors.fill: parent

                         onClicked: {
                             nativeUtils.openUrl("https://www.miraclia.com/t%C3%A9rminos-y-condiciones-de-uso")
                         }
                     }

                 }
            }

          AppImage {
                 width: 64 // works good for all!

                 fillMode: Image.PreserveAspectFit

                 source: "../../../../../../assets/social/discord.svg"

                 MouseArea {
                     anchors.fill: parent

                     onClicked: {
                         nativeUtils.openUrl("https://www.miraclia.com/t%C3%A9rminos-y-condiciones-de-uso")
                     }
                 }

                 CuteText {
                     width: parent.width

                     text: qsTr("Discord")
                     topPadding: 2

                     anchors.top: parent.bottom


                     horizontalAlignment: Text.AlignHCenter

                     font.pixelSize: getTextSize(12)

                     MouseArea {
                         anchors.fill: parent

                         onClicked: {
                             nativeUtils.openUrl("https://www.miraclia.com/t%C3%A9rminos-y-condiciones-de-uso")
                         }
                     }

                 }
            }

          }


      }
    }
}
