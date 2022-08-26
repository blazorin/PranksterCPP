import QtQuick 2.0
import Felgo 3.0

Page {
    id: subscriptionStorePage
    title: qsTr("Subscripción")

    backgroundColor: pagesBackColorGrey


    Subscription {
        anchors.fill: parent
    }
}
