import Felgo 3.0
import QtQuick 2.0
import "helper"
import "pages"

Item {
    anchors.fill: parent

    // app content with plugin list
    NavigationStack {
        id: pluginMainItem

        // initial page contains list if plugins and opens pages for each plugin when selected
        ListPage {
            id: page
            title: qsTr("Felgo Plugins")

            model: ListModel {
                ListElement { type: "Advertising"; name: "AdMob";
                    detailText: "Ad Monetization and Promotion"; image: "../assets/logo-admob.png" }
                ListElement { type: "In-App Purchases"; name: "Soomla"
                    detailText: "In-App Purchases & Virtual Currency"; image: "../assets/logo-soomla.png" }
                ListElement { type: "Social"; name: "Facebook"
                    detailText: "Social Sharing & Friend Invites"; image: "../assets/logo-facebook.png" }
                ListElement { type: "Social"; name: "GameCenter"
                    detailText: "Cross-Platform Gaming Services"; image: "../assets/logo-gamecenter.png" }
                ListElement { type: "Analytics"; name: "Amplitude"
                    detailText: "User Analytics & App Statistics"; image: "../assets/logo-amplitude.png" }
                ListElement { type: "Notifications"; name: "OneSignal Push Notifications"
                    detailText: "Targeted Push Notifications"; image: "../assets/logo-onesignal.png" }
            }

            delegate: PluginListItem {
                visible: name !== "GameCenter" || Theme.isIos
                opacity: enabled ? 1.0 : 0.3

                onSelected: {
                    switch (name) {
                    case "AdMob":
                        page.navigationStack.push(Qt.resolvedUrl("pages/AdMobPage.qml"))
                        break
                    case "Soomla":
                        page.navigationStack.push(soomlaPage)
                        break
                    case "Facebook":
                        page.navigationStack.push(facebookPage)
                        break
                    case "GameCenter":
                        page.navigationStack.push(Qt.resolvedUrl("pages/GameCenterPage.qml"))
                        break
                    case "Amplitude":
                        page.navigationStack.push(Qt.resolvedUrl("pages/AmplitudePage.qml"))
                        break
                    case "OneSignal Push Notifications":
                        page.navigationStack.push(Qt.resolvedUrl("pages/OneSignalPage.qml"))
                        break
                    }
                }
            }

            section.property: "type"
            section.delegate: SimpleSection { }
        }
    }
}
