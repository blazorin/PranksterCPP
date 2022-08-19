import Felgo 3.0
import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC

import "../../../../../helper"

Page {
    id: subscriptionStorePage
    title: qsTr("Tienda")
    property int swipeDefaultIndex: subscriptionKind

    Component.onCompleted: {
      // Using this will correctly trigger the signals, but will show visual transitions
      //swipeView.currentIndex = Qt.binding(function() {return subscriptionStorePage.swipeDefaultIndex})
    }

    QQC.SwipeView {
      id: swipeView

      currentIndex: subscriptionStorePage.swipeDefaultIndex
      anchors.fill: parent

      onCurrentItemChanged: {
        //console.debug("onCurrentItemChanged")
        // You could ignore any calls where !currentItem
        //console.log(currentIndex)
        //console.log(currentItem)

      }
      onCurrentIndexChanged: {
        //console.debug("onCurrentIndexChanged")
        // You could ignore any calls where !currentItem
        //console.log(currentIndex)
        subscriptionsStoreExternalIndex = currentIndex

        if ((currentIndex == 1 || currentIndex == 2) && !bottomToTopEnabled) {
            navStack.enableBottomToTop()
        }
        else if (currentIndex == 0 && bottomToTopEnabled) {
            navStack.disableBottomToTop()
        }

        //console.log(currentItem)
      }

      // Call this manually after completion will trigger again with correct data
      Component.onCompleted: currentItemChanged()

      // Sin Repeater (hace a veces que se coloque mal)

            Loader {
                active: true
                asynchronous: false // Si es true se colocará mal // TODO: revisar en un futuro si se bugea demasiado frecuente
                visible: status == Loader.Ready

                sourceComponent: Subscription
                {
                    useCustomSubscriptionKind: true
                    customSubscriptionKind: 0

                    //showLottie: currentIndex == index
                }
            }

            Loader {
                active: true
                asynchronous: false // Si es true se colocará mal
                visible: status == Loader.Ready

                sourceComponent: Subscription
                {
                    useCustomSubscriptionKind: true
                    customSubscriptionKind: 1

                    //showLottie: currentIndex == index
                }
            }

            Loader {
                active: true
                asynchronous: false // Si es true se colocará mal
                visible: status == Loader.Ready

                sourceComponent: Subscription
                {
                    useCustomSubscriptionKind: true
                    customSubscriptionKind: 2

                    //showLottie: currentIndex == index
                }
            }


    }

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
