import QtQuick 2.0
import Felgo 3.0

import "../../../../../helper"

Page {

    title: qsTr("Información y Ayuda")
    backgroundColor: pagesBackColor

    property real marginCol: 35

    leftBarItem: GoBackButtonBarItem {
        id: backBtn
    }

    AppFlickable {
          id: scroller

          anchors.fill: parent

          contentWidth: parent.width
          contentHeight: developerColumn.height + actorsColumn.height + marketingColumn.height + helpSectionColumn.height + 20 + + imageColumn.height + marginCol + 20 + (30 * 2)

          flickableDirection: Flickable.VerticalFlick

      Column {
          id: imageColumn

          anchors.left: parent.left
          anchors.right: parent.right
          anchors.top: parent.top
          anchors.topMargin: marginCol

          anchors.leftMargin: dp(20)
          anchors.rightMargin: dp(20)

          spacing: dp(10)

          AppImage {
             source: "../../../../../../assets/prankster-logo.svg"

             width: (!isTablet ? (parent.width / 1.2) : (parent.width / 1.5))
             anchors.horizontalCenter: parent.horizontalCenter
             fillMode: Image.PreserveAspectFit


          }

          CuteText {
              width: parent.width

              horizontalAlignment: Text.AlignHCenter
              color: cuteColorSecondary

              text: qsTr("Versión " + app.versionCode)
              font.pixelSize: getTextSize(14, true)

              bottomPadding: dp(10)
          }

      }

      Column {
          id: developerColumn

          anchors.left: parent.left
          anchors.right: parent.right
          anchors.top: imageColumn.bottom
          anchors.topMargin: 20

          anchors.leftMargin: dp(20)
          anchors.rightMargin: dp(20)

          spacing: dp(10)

          PromoRectangle {

                text: qsTr("Desarrollo y Programación")
                textSizeInt: 13

                radius: dp(15)

                textColor: "#FFFFFF"
                bgColor: "#EA5455"
                bold: true

                anchors.horizontalCenter: parent.horizontalCenter
          }

          CuteText {
              width: parent.width

              horizontalAlignment: Text.AlignHCenter
              color: "black"

              text: "Alberto Romero"
              font.pixelSize: getTextSize(16, true)

              bottomPadding: dp(10)
          }
      }

      Column {
          id: actorsColumn

          anchors.left: parent.left
          anchors.right: parent.right
          anchors.top: developerColumn.bottom
          anchors.topMargin: 30

          anchors.leftMargin: dp(20)
          anchors.rightMargin: dp(20)

          spacing: dp(8)

          PromoRectangle {

                text: qsTr("Voces, doblaje y guiones")
                textSizeInt: 13

                radius: dp(15)

                textColor: "#FFFFFF"
                bgColor: "#EA5455"
                bold: true

                anchors.horizontalCenter: parent.horizontalCenter
          }

          CuteText {
              width: parent.width

              horizontalAlignment: Text.AlignHCenter
              color: cuteColorSecondary


              text: "Inés Romero"
              font.bold: true

              font.pixelSize: getTextSize(16, true)

              bottomPadding: dp(3)
          }

          CuteText {
              width: parent.width

              horizontalAlignment: Text.AlignHCenter
              color: cuteColorSecondary

              text: "Víctor Ruíz"
              font.bold: true

              font.pixelSize: getTextSize(16, true)

              bottomPadding: dp(2)
          }

          CuteText {
              width: parent.width

              horizontalAlignment: Text.AlignHCenter
              color: cuteColorSecondary

              text: "Conchita Doñate"
              font.bold: true
              font.pixelSize: getTextSize(16, true)

              bottomPadding: dp(5)
          }
      }

      Column {
          id: marketingColumn

          anchors.left: parent.left
          anchors.right: parent.right
          anchors.top: actorsColumn.bottom
          anchors.topMargin: 30

          anchors.leftMargin: dp(20)
          anchors.rightMargin: dp(20)

          spacing: dp(8)

          PromoRectangle {

                text: qsTr("Marketing y Comunicación")
                textSizeInt: 13

                radius: dp(15)

                textColor: "#FFFFFF"
                bgColor: "#EA5455"
                bold: true

                anchors.horizontalCenter: parent.horizontalCenter
          }

          CuteText {
              width: parent.width

              horizontalAlignment: Text.AlignHCenter
              color: "black"

              text: "Víctor Ruíz"
              font.pixelSize: getTextSize(16, true)

              bottomPadding: dp(10)
          }
      }

      Column {
          id: helpSectionColumn

          anchors.left: parent.left
          anchors.right: parent.right
          anchors.top: marketingColumn.bottom

          anchors.topMargin: dp(20)

          AppListItem {

               text: qsTr("Web de Prankster")
               textFontSize: getTextSize(17, true)

               backgroundColor: pagesBackColor

               textColor: Theme.appButton.textColor
               selectedTextColor: Theme.appButton.textColor

               //dividerLeftSpacing: 15
               showDisclosure: false

               onSelected: {

               }

               SeparatorLine {
                   anchors.bottom: parent.top

                   width: parent.width
                   anchors.left: parent.left
                   anchors.leftMargin: parent.dividerLeftSpacing

                   height: 1

               }
               Component.onCompleted: {
                   //s1.width = webLink.dividerHeight
               }
          }

          AppListItem {
               text: qsTr("Contacta con nosotros")
               textFontSize: getTextSize(17, true)

               backgroundColor: pagesBackColor

               textColor: Theme.appButton.textColor
               selectedTextColor: Theme.appButton.textColor

               //dividerLeftSpacing: 15
               showDisclosure: false

               onSelected: {

               }

               SeparatorLine {
                   anchors.bottom: parent.top

                   width: parent.width
                   anchors.left: parent.left
                   anchors.leftMargin: parent.dividerLeftSpacing

                   height: 1

               }
               Component.onCompleted: {
                   //s1.width = webLink.dividerHeight
               }
          }

          AppListItem {
               text: qsTr("Términos y Privacidad")
               textFontSize: getTextSize(17, true)

               backgroundColor: pagesBackColor

               textColor: Theme.appButton.textColor
               selectedTextColor: Theme.appButton.textColor

               //dividerLeftSpacing: 15
               showDisclosure: false

               onSelected: {

               }

               SeparatorLine {
                   anchors.bottom: parent.top

                   width: parent.width
                   anchors.left: parent.left
                   anchors.leftMargin: parent.dividerLeftSpacing

                   height: 1

               }
               Component.onCompleted: {
                   //s1.width = webLink.dividerHeight
               }
          }

          AppListItem {
               id: licensesItem

               text: qsTr("Licencias")
               textFontSize: getTextSize(17, true)

               backgroundColor: pagesBackColor

               textColor: Theme.appButton.textColor
               selectedTextColor: Theme.appButton.textColor

               //dividerLeftSpacing: 15
               showDisclosure: false

               onSelected: {
                   navStack.push(licensesPageComponent)
               }

               SeparatorLine {
                   anchors.bottom: parent.top

                   width: parent.width
                   anchors.left: parent.left
                   anchors.leftMargin: parent.dividerLeftSpacing

                   height: 1

               }
               Component.onCompleted: {
                   //s1.width = webLink.dividerHeight
               }
          }

          CuteText {
              width: parent.width
              color: "#6D6C70"

              text: "© " + new Date().getFullYear() + " Prankster"
              font.pixelSize: getTextSize(13)

              topPadding: dp(7)
              bottomPadding: dp(14)
              leftPadding: licensesItem.leftPadding
          }
      }
    }

    ScrollIndicator {
        flickable: scroller
    }

    Component {
        id: licensesPageComponent

        Licenses {}
    }
}
