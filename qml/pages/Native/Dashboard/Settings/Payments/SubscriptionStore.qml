import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC
import Felgo 3.0 as FELGO

import "../../../../../helper"

FELGO.Page {
    id: subscriptionStorePage
    title: qsTr("Tienda")

    backgroundColor: pagesBackColorGrey

    property int swipeDefaultIndex: 0

    //property var componentCache: Qt.createComponent("Subscription.qml")

    Component.onCompleted: {
      // Using this will correctly trigger the signals, but will show visual transitions
      //swipeView.currentIndex = Qt.binding(function() {return subscriptionStorePage.swipeDefaultIndex})
    }

    Component.onDestruction: {
        console.debug("[DEBUG] Destroyed subscriptionStorePage")
    }

    //clip: true

    QQC.SwipeView {
      id: swipeView

      currentIndex: subscriptionStorePage.swipeDefaultIndex
      anchors.fill: parent

      onCurrentItemChanged: {
          if (currentIndex == 0 && bottomToTopEnabled) {
              navStack.disableBottomToTop()
           }

      }
      onCurrentIndexChanged: {
        //console.debug("onCurrentIndexChanged")
        // You could ignore any calls where !currentItem
        //console.log("CI: " + currentIndex)
        subscriptionsStoreExternalIndex = currentIndex

        if ((currentIndex == 1 || currentIndex == 2) && !bottomToTopEnabled) {
            navStack.enableBottomToTop()
        }
        else if (currentIndex == 0 && bottomToTopEnabled) {
            navStack.disableBottomToTop()
        }

        //if (currentIndex == 1 && !thirdLoader.active) {
         //   thirdLoader.active = true
        //}

        //console.log(currentItem)
      }


      Loader {
          id: freeLoader

          //source: "Subscription.qml"
          asynchronous: true
          visible: status == Loader.Ready

          Component.onCompleted: {
              setSource("Subscription.qml",
                        {useCustomSubscriptionKind: true, customSubscriptionKind: 0}
                        );
          }
      }


      Loader {
          id: premiumLoader
          //source: "Subscription.qml"
          asynchronous: true
          visible: status == Loader.Ready

          Component.onCompleted: {
              setSource("Subscription.qml",
                        {useCustomSubscriptionKind: true, customSubscriptionKind: 1, lottieVisible: false}
                        );
          }
      }

          Loader {
              id: unlimitedLoader
              //source: "Subscription.qml"
              asynchronous: true
              visible: status == Loader.Ready

              Component.onCompleted: {
                  setSource("Subscription.qml",
                            {useCustomSubscriptionKind: true, customSubscriptionKind: 2, lottieVisible: false}
                            );
              }
          }



      Component.onDestruction: {
         subscriptionsStoreExternalIndex = 0 // Default value
          navStack.disableBottomToTop()
      }


      // Call this manually after completion will trigger again with correct data
      Component.onCompleted: {
          //addItem(sub0)
          //addItem(sub1)

          currentItemChanged()
          //ld0.sourceComponent = itemComp.createObject(parentObj)


      }


    }


    /*
    Component {
        id: demoComponent

        Subscription
        {
            useCustomSubscriptionKind: true
            customSubscriptionKind: 1

            lottieVisible: false
        }
    }
    */

    /*
    Column {
      anchors.centerIn: parent

      AppButton {
        text: "Next"
        onClicked: subscriptionStorePage.swipeDefaultIndex++
      }

      AppButton {
        text: "Prev"
        onClicked: subscriptionStorePage.swipeDefaultIndex--
      }

      AppButton {
        text: "CurrentItem"
        onClicked: console.log(swipeView.currentItem)
      }
    }
    */
}
