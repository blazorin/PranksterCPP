import QtQuick 2.0
import Felgo 3.0

Item {
    property url filePath

    property real animatedHeight: dp(400)
    property real animatedWidth


    AnimatedImage {
             id: animation
             source: filePath
             antialiasing: true
             fillMode: Image.PreserveAspectCrop
             width: animatedWidth
             height: animatedHeight
             paused: animation.currentFrame === animation.frameCount - 1 // just one time

             anchors.topMargin: dp(70)
         }
}
