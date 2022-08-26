import QtQuick 2.0
import Felgo 3.0

import "../../../../../helper"

Page {
    id: inviteFriendPage

    title: qsTr("Invitar")
    backgroundColor: pagesBackColorGrey

    property real marginCol: 35

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
             source: "../../../../../../assets/settings/invite.svg"

             width: (!isTablet ? (parent.width / 1.3) : (parent.width / 2.3))
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

              text: "¡Comparte y Gana!"
              font.pixelSize: getTextSize(23)

              font.weight: Font.ExtraLight
          }

          Rectangle {
              id: friendRec

              width: parent.width
              height: friendRow.height + 5

              radius: dp(15)

              anchors.horizontalCenter: parent.horizontalCenter

              Row {
                  id: friendRow

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

                      color: "#5D93FD"
                      radius: dp(10)

                      anchors.verticalCenter: parent.verticalCenter

                      Icon {
                         id: atIcon

                         icon: IconType.link
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
                    width: friendRow.width - atIconRect.width - copyButton.width - 10

                    placeholderText: qsTr("Obteniendo enlace...")

                    text: "prankster.es/unete/" + accountId

                    font.pixelSize: getTextSize(17, true)
                    color: "#FA4D3E"

                    //maximumLength: 15
                    enabled: false

                    onTextChanged: {

                        if (textInput.text == "")
                        {
                           copyButton.visible = false
                           return;
                        }

                           copyButton.visible = true
                    }

                    Component.onCompleted: {
                        if (isTablet)
                            textInput.fontSize = 18
                    }

                  }

              }

              TextButtonBarItem {
                      id: copyButton

                      text: qsTr("Copiar")

                      color: Theme.navigationBar.itemColor
                      anchors.right: friendRow.right
                      //anchors.verticalCenter: atIconRect.verticalCenter


                      onClicked: {
                          // Copy URL to share
                          copyButton.text = qsTr("Copiado")
                          copyButtonTimer.running = true

                      }

                      Component.onCompleted: {
                        //y = atIconRect.y - 7
                      }
              }

              Timer {
                  id: copyButtonTimer

                  running: false
                  repeat: false
                  interval: 6000

                  onTriggered: {
                      copyButton.text = qsTr("Copiar")
                      copyButtonTimer.running = false
                  }
              }

          }

          PromoRectangle {
              text: qsTr("¡Ambos ganaréis una broma!")
              textSizeInt: (!isTablet ? 12 : 14)

              radius: dp(15)

              textColor: "#FFFFFF"
              bgColor: "#35CD79"
              bold: true

              visible: !root.isThisDeviceLinked

              anchors.horizontalCenter: parent.horizontalCenter

          }
      }
    }
}
