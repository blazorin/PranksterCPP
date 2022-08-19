import QtQuick 2.0
import Felgo 3.0

Page {

    id: dashLayout

    title: "Dashboard Layout"

    backNavigationEnabled: false // important

    navigationBarHidden: true
    backgroundColor: (!onGreyToneTab ? pagesBackColor : pagesBackColorGrey)

    property bool fromWelcome: false

    property bool onGreyToneTab: false

    Navigation {
        id: navBox

        navigationMode: navigationModeTabs

        NavigationItem {
          title: "Next"
          icon: IconType.calculator


          SettingsTab {}
        }

        NavigationItem {
          title: "Ajustes"
          icon: IconType.gear

          SettingsTab {}

          onSelected: {
              onGreyToneTab = true
              console.debug("[Dash Layout] Tab changed to " + title)
          }

        }


    }

    Component.onCompleted: {
        disableBottomToTopTimer.running = true
    }

    Timer {
        id: disableBottomToTopTimer
        running: false

        repeat: false
        interval: (Theme.isIos ? 200 : 240)

        onTriggered: {
            if (rootPage.dashLayoutAtLeastOnce)
                return

            navStack.disableBottomToTop()

            rootPage.dashLayoutAtLeastOnce = true

            // Give a bit of time while doing animation (1.3s)
            disablePreLotties.running = true
        }
    }

    Timer {
        id: disablePreLotties
        running: false

        repeat: false
        interval: 1300

        onTriggered: {
            rootPage.preLottiesOn = false
        }
    }


}
