import QtQuick 2.0
import QtQuick.Controls 2.4

import Felgo 3.0

import "../Settings/Payments"

SwipeView {
    Repeater {
        model: 6
        Loader {
            active: SwipeView.isCurrentItem || SwipeView.isNextItem || SwipeView.isPreviousItem
            sourceComponent: Text {
                text: index
                Component.onCompleted: console.log("created:", index)
                Component.onDestruction: console.log("destroyed:", index)
            }
        }
    }
}

