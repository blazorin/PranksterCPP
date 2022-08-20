import QtQuick 2.0
import Felgo 3.0

IconButtonBarItem {
    id: backBtn

    icon: IconType.angleleft
    iconSize: sp(35)


    onClicked: {
        if (!backBtn.enabled)
            return

        navigationStack.pop()
    }

    property var pageItem

    function lock(pageItem) {
        backBtn.enabled = false
        transitionReturnOff.running = true

        backBtn.pageItem = pageItem
        backBtn.pageItem.backNavigationEnabled = false
    }

    function unlock() {
        unlockTimer.start()
    }

    Timer {
         id: unlockTimer
         interval: 100
         repeat: true
         running: false

         onTriggered: {
             if (transitionReturnOff.running)
                 return

             transitionReturnIn.start()
             unlockTimer.stop()
          }
    }


    NumberAnimation on opacity {
        id: transitionReturnOff

        running: false

        easing.type: Easing.OutQuint
        from: 1
        to: 0
        duration: 1100

        onStopped: {
            // Ha terminado y velocity=0

            //transitionReturnIn.running = true
            transitionReturnOff.running = false
        }
    }

    NumberAnimation on opacity {
        id: transitionReturnIn

        running: false

        easing.type: Easing.OutQuint
        from: 0
        to: 1
        duration: 815


        onStarted: {
           backBtn.enabled = true

           backBtn.pageItem.backNavigationEnabled = true
        }

        onStopped: {
            // Ha terminado y velocity=0

            transitionReturnIn.running = false
        }
    }

}
