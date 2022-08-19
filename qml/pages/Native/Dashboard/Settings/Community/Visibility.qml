import QtQuick 2.0
import Felgo 3.0

import "../../../../../helper"

Page {

    title: qsTr("Visibilidad")
    backgroundColor: pagesBackColorGrey

    property real marginCol: 25

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




          ListSeparator { title: qsTr("Contenido de la Comunidad")}

          AppSwitchListItem {
               text: qsTr("Ocultar comentarios explícitos")
               dividerLeftSpacing: 0

               switchEnabled: root.hideExplicit

               onSwitch: (status) => {
                 // Logic


                 root.hideExplicit = status
              }
          }

          ListSeparator { title: ""}

          AppSwitchListItem {
               text: qsTr("Deshabilitar comunidad")
               dividerLeftSpacing: 0

               switchEnabled: root.disableCommunity

               onSwitch: (status) => {
                 // Logic


                 root.disableCommunity = status
              }
          }
      }
    }
}
