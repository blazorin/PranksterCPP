import QtQuick 2.0
import QtGraphicalEffects 1.12
import Felgo 3.0

Page {

    id: dashLayout

    title: "Dashboard Layout"

    backNavigationEnabled: false // important

    navigationBarHidden: true
    backgroundColor: (!onGreyExtraTab ? pagesBackColorGrey : pagesBackColorGreyExtra)

    property bool fromWelcome: false

    property bool onGreyExtraTab: false

    // Icons Components

    Component {
        id: homeIconComponent

        AppImage {
            source: "../../../../assets/icons/home_final.svg"

            width: 32
            height: 32

            Component.onCompleted: {
                y -= 4
            }

            /*
            AppText {
                font.pixelSize: getTextSize(13)
                color: layoutIconColor

                horizontalAlignment: Text.AlignHCenter
                anchors.top: parent.bottom
                anchors.topMargin: 5

                text: qsTr("Inicio")

                ColorOverlay{
                    anchors.fill: parent
                    source: parent
                    color: layoutIconColorActive
                    transform:rotation
                    antialiasing: true
                    visible: navBox.currentIndex == 0
                }
            }
            */

            ColorOverlay{
                anchors.fill: parent
                source: parent
                color: layoutIconColorActive
                transform:rotation
                antialiasing: true
                visible: navBox.currentIndex == 0
            }
        }

    }

    Component {
        id: storeIconComponent

        AppImage {
            source: "../../../../assets/icons/store_final.svg"

            width: 32
            height: 32

            Component.onCompleted: {
                y -= 4
            }

            ColorOverlay{
                anchors.fill: parent
                source: parent
                color: layoutIconColorActive
                transform:rotation
                antialiasing: true
                visible: navBox.currentIndex == 1
            }
        }
    }

    Component {
        id: chatIconComponent

        AppImage {
            source: "../../../../assets/icons/chat_final.svg"

            width: 32
            height: 32

            Component.onCompleted: {
                y -= 4
            }

            ColorOverlay{
                anchors.fill: parent
                source: parent
                color: layoutIconColorActive
                transform:rotation
                antialiasing: true
                visible: navBox.currentIndex == 3
            }
        }
    }

    Component {
        id: settingsIconComponent

        AppImage {
            source: "../../../../assets/icons/settings_final.svg"

            width: 32
            height: 32

            Component.onCompleted: {
                y -= 4
            }

            ColorOverlay{
                anchors.fill: parent
                source: parent
                color: layoutIconColorActive
                transform:rotation
                antialiasing: true
                visible: navBox.currentIndex == 4
            }
        }

    }

    Navigation {
        id: navBox

        navigationMode: navigationModeTabs

        NavigationItem {
          iconComponent: homeIconComponent

          HomeTab {}

          onSelected: {
              //onGreyExtraTab = true
              console.debug("[Dash Layout] Tab changed to " + title)
          }
        }

        NavigationItem {
          iconComponent: storeIconComponent

          SettingsTab {}
        }

        NavigationItem {
          visible: false
          //enabled: false

          // Call Tab
          SettingsTab {}
        }

        NavigationItem {           
          iconComponent: chatIconComponent

          enabled: !disableCommunity

          SettingsTab {}
        }

        NavigationItem {
          iconComponent: settingsIconComponent

          SettingsTab {}

          onSelected: {
              onGreyExtraTab = false
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


        MouseArea {
            anchors.fill: parent

            onClicked: {
                navBox.currentIndex = 2
            }
        }

        Icon {
            size: 20
            icon: IconType.phone

            color: "#FFFFFF"

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 7


        }

        AppText {
            font.pixelSize: (callBalance < 99 ? getTextSize(14) : getTextSize(13))
            color: "#FFFFFF"

            font.bold: true

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: (callBalance < 10 ? 13 : (callBalance < 99 ? 7 : (callBalance < 200 ? 3 : 2) ))

            text: callBalance

        }

        Rectangle {

            width: 5
            height: 5

            radius: 2.5

            anchors.top: parent.bottom
            anchors.topMargin: 5

            color: Theme.navigationTabBar.titleColor
            visible: navBox.currentIndex == 2

            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            id: leftRec1

            width: (navBox.width - parent.width) / 2
            height: 2

            color: Theme.navigationTabBar.titleColor
            anchors.right: parent.left
            //anchors.rightMargin: 35

            //radius: 5
            anchors.verticalCenter: parent.verticalCenter

        }

        Rectangle {
            width: (navBox.width - parent.width) / 2
            height: 2

            color: Theme.navigationTabBar.titleColor
            anchors.left: parent.right

            //radius: 5
            anchors.verticalCenter: parent.verticalCenter
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
