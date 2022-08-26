import QtQuick 2.0
import Felgo 3.0

import "../../../../../helper"

Page {

    title: qsTr("Preferencias")
    backgroundColor: pagesBackColorGrey

    property real marginCol: 25

    property bool canTriggerHidePubs: true

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




          ListSeparator { title: qsTr("Bromas")}

          AppSwitchListItem {

               text: qsTr("Compartir automáticamente")
               detailText: qsTr("Se publicarán automáticamente en la comunidad")

               onSwitch: (status) => {
                 // Logic

                 root.sharePranksAuto = status
              }

               dividerLeftSpacing: 0

               switchEnabled: root.sharePranksAuto
          }
      }
    }
}
