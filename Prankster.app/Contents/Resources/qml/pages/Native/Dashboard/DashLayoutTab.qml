import QtQuick 2.0
import QtGraphicalEffects 1.12
import Felgo 3.0

Page {

    id: dashLayout

    title: "Dashboard Layout"

    backNavigationEnabled: false // important

    navigationBarHidden: true
    backgroundColor: (!onGreyToneTab ? pagesBackColor : pagesBackColorGrey)

    property bool fromWelcome: false

    property bool onGreyToneTab: false

    // Icons Components

    Component {
        id: homeIconComponent

        AppImage {
            source: ""
            width: 128

            fillMode: Image.PreserveAspectFit
        }
    }

    Navigation {
        id: navBox

        navigationMode: navigationModeTabs

        NavigationItem {
          //title: "Next"
          icon: IconType.home


          SettingsTab {}
        }

        NavigationItem {
          //title: "Next"
          icon: IconType.shoppingcart


          SettingsTab {}
        }

        NavigationItem {
          //icon: IconType.shoppingcart
          visible: false
          enabled: false
          //iconComponent: circularShapeComponent

        }

        NavigationItem {
          //title: "Next"
          icon: IconType.group
          enabled: !disableCommunity

          SettingsTab {}
        }

        NavigationItem {
          id: setingss
          //title: "Ajustes"
          icon: IconType.gear

          SettingsTab {}

          onSelected: {
              onGreyToneTab = true
              console.debug("[Dash Layout] Tab changed to " + title)
          }

        }



        //tabs.style.


    }

    Rectangle {
        id: lineCenterRec

        width: 50
        height: 35

        radius: 20
        color: Theme.navigationTabBar.titleColor

        anchors.horizontalCenter: parent.horizontalCenter

        Icon {
            size: 20
            icon: IconType.phone

            color: "#FFFFFF"

            anchors.centerIn: parent
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
