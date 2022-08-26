import QtQuick 2.0
import Felgo 3.0

import "../../../../../helper"

Page {

    id: customNumberPage

    title: qsTr("Número Saliente (Unlimited)")

    backgroundColor: pagesBackColorGreyExtra

    property real marginCol: 40

    // Hecho a proposito para que se vea un poco sin subscripción

    Component.onCompleted: {
        if (subscriptionKind < 2) {
            showNoAccessTimer.running = true
        }
    }

    Timer {
       id: showNoAccessTimer

       running: false
       repeat: false
       interval: 350

       onTriggered: NativeDialog.confirm("¡Ups!", "Para modificar el número saliente necesitas: \n\nSubscripción Unlimited", function(){navStack.pop()}, false)
    }

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
             source: "../../../../../../assets/settings/phone_mustache.svg"

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

              text: qsTr("Número saliente por defecto")
              font.pixelSize: getTextSize(20)

              font.weight: Font.ExtraLight
          }

          Rectangle {
              id: numberRec

              width: parent.width
              height: prankRow.height + 5

              radius: dp(15)

              anchors.horizontalCenter: parent.horizontalCenter

              Row {
                  id: prankRow

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

                      color: "#474247"
                      radius: dp(10)

                      anchors.verticalCenter: parent.verticalCenter

                      Icon {
                         id: atIcon

                         icon: IconType.phone
                         height: dp(23)
                         width: dp(23)
                         color: "#F1C40F"

                         anchors.centerIn: parent

                         Component.onCompleted: {
                             atIcon.textItem.font.bold = true
                         }

                      }
                  }

                  // input
                  AppTextInput {
                    id: textInput
                    width: prankRow.width - atIconRect.width - saveBtn.width - 10

                    placeholderText: qsTr("Número")
                    font.pixelSize: getTextSize(17, true)


                    // only allow letters and check length
                    validator: RegExpValidator {
                      regExp: /[0-9]+/
                    }

                    maximumLength: 15

                    onTextChanged: {

                        if (textInput.text == "" || textInput.text.length < 5 || texInput.text === root.outgoingNumber)
                        {
                           saveBtn.canSave = false
                           return;
                        }

                        saveBtn.canSave = true
                    }

                    Component.onCompleted: {
                        textInput.text = root.outgoingNumber

                        if (isTablet)
                            textInput.fontSize = 18
                    }

                  }

                  SaveButtonBarItem {

                          id: saveBtn
                          handlerFunc: () => {
                              //Logic
                              let cachedNumber = textInput.text



                              root.outgoingNumber = cachedNumber

                              textInput.deselect()
                              textInput.focus = false

                              // NativeDialog

                              console.debug("[Info] Updated outgoing number: " + cachedNumber)

                              return true
                          }

                          Component.onCompleted: saveBtn.registerBackButtonItem(backBtn, customNumberPage)

                      }

              }

          }

          CuteText {
              width: parent.width

              horizontalAlignment: Text.AlignHCenter
              color: cuteColorSecondary

              text: qsTr("Lo puedes modificar antes de gastar la broma.")
              font.pixelSize: getTextSize(17, true)

              bottomPadding: dp(10)
          }
      }
    }
}
