import QtQuick 2.0
import Felgo 3.0

import "../../../../../helper"

Page {

    title: qsTr("Compras In-App")
    backgroundColor: pagesBackColorGrey

    property real marginCol: 40

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

          spacing: dp(20)

          AppImage {
             source: "../../../../../../assets/settings/apple_purchase_history_es.png"

             width: (!isTablet ? (parent.width) : (parent.width / 1.5))
             anchors.horizontalCenter: parent.horizontalCenter
             fillMode: Image.PreserveAspectFit

          }

      }

      Column {
          anchors.left: parent.left
          anchors.right: parent.right
          anchors.top: contentColumn.bottom
          anchors.topMargin: 20

          anchors.leftMargin: dp(20)
          anchors.rightMargin: dp(20)

          // TODO: Needs to be different for Android
          CuteText {
              width: parent.width

              horizontalAlignment: Text.AlignHCenter
              color: cuteColorSecondary

              text: qsTr("Accede a")
              font.pixelSize: getTextSize(17, true)
          }

          CuteText {
              width: parent.width

              horizontalAlignment: Text.AlignHCenter
              color: cuteColorSecondary

              text: qsTr("App Store > Cuenta > Historial de compras")
              font.pixelSize: getTextSize(17, true)
              font.bold: true

          }

          CuteText {
              width: parent.width

              horizontalAlignment: Text.AlignHCenter
              color: cuteColorSecondary

              text: qsTr("para ver tus compras en Prankster.")
              font.pixelSize: getTextSize(17, true)
          }

          CuteText {
              width: parent.width
              topPadding: dp(20)

              horizontalAlignment: Text.AlignHCenter
              color: cuteColorSecondary

              text: qsTr("Si estás teniendo problemas con tus compras:")
              font.pixelSize: getTextSize(13)
          }

          CuteText {
              width: parent.width

              horizontalAlignment: Text.AlignHCenter
              color: cuteColorSecondary

              text: qsTr("Dirígete a Información y Ayuda > Contactar.")
              font.pixelSize: getTextSize(13)
          }
      }
    }
}
