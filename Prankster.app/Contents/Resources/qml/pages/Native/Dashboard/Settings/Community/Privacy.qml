import QtQuick 2.0
import Felgo 3.0

import "../../../../../helper"

Page {

    title: qsTr("Privacidad")
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




          ListSeparator { title: qsTr("Perfil")}

          AppSwitchListItem {
               id: hidePubs

               text: qsTr("Ocultar publicaciones")
               detailText: qsTr("Cuando alguien visita tu @")

               onSwitch: (status) => {
                 // Logic

                  if (!canTriggerHidePubs)
                       return

                 root.hidePubs = status
                 console.debug("[INFO] Pubs hidden: " + status)
              }

              enabled: !incognitoMode.switchEnabled
              switchEnabled: incognitoMode.switchEnabled ? true : (root.hidePubs) // replace this last statement

              Component.onCompleted: {
                  if (incognitoMode.switchEnabled)
                      canTriggerHidePubs = false
              }
          }


          // When toggled: hidePubs toggles.
          AppSwitchListItem {
               id: incognitoMode

               text: qsTr("Modo Incógnito")
               dividerLeftSpacing: 0

               switchEnabled: root.incognitoMode

               onSwitch: (status) => {
                         // Logic


                        if (status) {
                                canTriggerHidePubs = false

                                if (!root.hidePubs)
                                    hidePubs.toggleSwitch()

                             } else {
                                 if (!root.hidePubs)
                                     hidePubs.toggleSwitch()


                                canTriggerHidePubs = true
                             }

                       root.incognitoMode = status

                       console.debug("[INFO] Incognito mode: " + status)
              }
          }
      }
    }
}
