import QtQuick 2.0
import Felgo 3.0

TextButtonBarItem {
        id: saveBtn

        property var handlerFunc: () => {return true}
        property bool canSave: false

        property bool saving: false // do not touch this from outside

        property var statuses: ["ㅤ", "Guardar", "Guardando"]

        property var backButtonItemInternal
        property var pageItemInternal

        text: (!saving ? (canSave ? statuses[1] : statuses[0]) : statuses[2])
        color: Theme.navigationBar.itemColor

        enabled: canSave

        onClicked: {
            if (!enabled)
                return

            if (backButtonItemInternal === null || pageItemInternal === null) {
                console.debug("[INFO] Error. No back backButtonItem or pageItem set.")
                return
            }

            saveBtn.saving = true
            backButtonItemInternal.lock(pageItemInternal)

            saveActionTimer.running = true

        }

        onFocusChanged: {
            console.debug("Holaaa")
        }

        function registerBackButtonItem(backButtonItem, pageItem) {
            backButtonItemInternal = backButtonItem
            pageItemInternal = pageItem
        }

        Timer {
             id: saveActionTimer
             interval: 280
             repeat: false
             running: false

             onTriggered: {

                 console.debug("[INFO] Starting a save task.")

                 if (saveBtn.handlerFunc())
                     transitionSave.start()
                else
                     saveBtn.saving = false // Only set this

                 backButtonItemInternal.unlock()
                 saveActionTimer.running = false
              }
        }

        NumberAnimation on opacity {
            id: transitionSave

            running: false

            easing.type: Easing.InQuint
            from: 1
            to: 0
            duration: 700

            onStopped: {
                // Ha terminado y velocity=0

                saveBtn.canSave = false
                saveBtn.saving = false

                saveBtn.opacity = 1
            }
        }
}
