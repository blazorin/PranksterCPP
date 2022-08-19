import QtQuick 2.0
import Felgo 3.0

Page {

    id: dashLayout

    title: "Dashboard Layout"

    backNavigationEnabled: false // important

    navigationBarHidden: true
    backgroundColor: (!onGreyTonePage ? pagesBackColor : pagesBackColorGrey)

    property bool onDashLayout: false

    property bool onGreyTonePage: false

    Component.onCompleted: {
        navStack.disableBottomToTop() // not used anymore
    }

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
              onGreyTonePage = true
              console.debug("[Dash Layout] Tab changed to " + title)
          }

        }


    }


}
