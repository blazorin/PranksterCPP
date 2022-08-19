import QtQuick 2.0
import Felgo 3.0

Rectangle {
    id: rect

         property alias bubbleText: bubbleChild.text
         property int bubbleSizeInt: 0

         property var customColor: ""
         color: customColor != "" ? customColor : "red"

         AppText {
             id: bubbleChild
                color: "#FFFFFF"

                font.bold: true
                anchors.centerIn: parent

                Component.onCompleted: {
                    if (bubbleSizeInt == 0)
                        bubbleChild.fontSize = getTextSize(15)
                    else
                        bubbleChild.fontSize = getTextSize(bubbleSizeInt)
                }
          }
}
