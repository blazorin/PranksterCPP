import Felgo 3.0
import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC

Page {
    id: currentPage
    title: "Demo"
    property int swipeDefaultIndex: 0

    Component.onCompleted: {
      // Using this will correctly trigger the signals, but will show visual transitions
      //swipeView.currentIndex = Qt.binding(function() {return currentPage.swipeDefaultIndex})
    }

    QQC.SwipeView {
      id: swipeView

      currentIndex: currentPage.swipeDefaultIndex
      anchors.fill: parent

      onCurrentItemChanged: {
        console.debug("onCurrentItemChanged")
        // You could ignore any calls where !currentItem
        console.log(currentIndex)
        console.log(currentItem)
      }
      onCurrentIndexChanged: {
        console.debug("onCurrentIndexChanged")
        // You could ignore any calls where !currentItem
        console.log(currentIndex)
        console.log(currentItem)
      }

      // Call this manually after completion will trigger again with correct data
      Component.onCompleted: currentItemChanged()

      Repeater {
        model: 7
        Item {

          Rectangle {
            anchors.fill: parent
            color: Qt.rgba(1,0,0,0.1*(index+1))
          }
        }
      }
    }

    Column {
      anchors.centerIn: parent

      AppButton {
        text: "Next"
        onClicked: currentPage.swipeDefaultIndex++
      }

      AppButton {
        text: "Prev"
        onClicked: currentPage.swipeDefaultIndex--
      }

      AppButton {
        text: "CurrentItem"
        onClicked: console.log(swipeView.currentItem)
      }
    }
}
