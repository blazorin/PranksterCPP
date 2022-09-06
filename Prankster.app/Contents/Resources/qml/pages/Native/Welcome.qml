import QtQuick.Controls 2.4
import QtQuick 2.0
import Felgo 3.0
import Qt.labs.lottieqt 1.0
import blazorin.QtLottie 1.0
import "../../helper"
import "Dashboard"

Page {

    id: welcomePage

    backNavigationEnabled: welcomePageIndex != 0 && welcomePageIndex != 2 && welcomePageIndex != 3 // important

    title: qsTr("Welcome to Prankster")
    backgroundColor: pagesBackColor

    property int welcomePageIndex

    property bool isTransPage

    property int lottieSize: 256

    Column {
        id: bottomColumn
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: termsColumn.top
        anchors.margins: contentPadding

        spacing: dp(20)

        // Truquito :)
        AppText {
            id: posHelper

            text: "*"
            anchors.horizontalCenter: parent.horizontalCenter

            visible: false
        }


        AppText {
            id: welcomeText
            width: parent.width
            text: qsTr(dataModel.welcomeFeatures[welcomePageIndex])
            font.pixelSize: getRelativeTextSize(45, welcomeText)

            color: welcomePageIndex == 4 ? "#EA5455" : color
            font.bold: welcomePageIndex == 4 ? true : false
            font.weight: Font.ExtraBold

            horizontalAlignment: Text.AlignHCenter

            wrapMode: Text.WrapAtWordBoundaryOrAnywhere

            y: (-parent.y) + (95) // no more as will overlap in some devices

        }


        AppFlickable {

            id: flickable

            width: parent.width
            height: contentHeight

            flickableDirection: Flickable.HorizontalFlick

            contentWidth: lottie.width
            contentHeight: lottie.height

            //anchors.bottom: parent.bottom
            //anchors.bottomMargin: 30


            AppPaper {

                  id: paper

                  x: (posHelper.x - (lottie.width / 2) + (welcomePageIndex == 3 ? 20 : 0)) // welcome3 lottie needs this help

                  // Pages which need no AppPaper
                  width: ((welcomePageIndex != 0) ? 0 : lottie.width)
                  height: ((welcomePageIndex != 0) ? 0 : lottie.height)

                  radius: dp(20)

                  shadowOffsetDefault: dp(4)
                  shadowSizeDefault: dp(4)


                  shadowColor: paperShadowColor

                  Item {

                        id: lottie

                        width: lottieSize
                        height: lottieSize




                        //y: ((contentColumn.height - bottomColumn.height) - dp(5))

                         LottieItem {
                               id: mainLottie

                               visible: preLottiesOn

                               source: "../../../assets/lottie/welcome" + welcomePageIndex + ".json"
                               anchors.fill: parent
                           }

                         LottieItem {
                              id: transitionedLottie

                              source: "../../../assets/lottie/welcome_transitioned.json"
                              anchors.fill: parent

                              visible: false
                         }

                           Component.onCompleted: {

                               if (isTransPage)
                                 transitionOne.start() // Start first transition

                           }

                           /**
                             Animations that happens on Page 3 (index 2)
                           **/

                          NumberAnimation on opacity {
                              id: transitionOne

                              running: false

                              easing.type: Easing.InQuint
                              from: 1
                              to: 0
                              duration: 3700

                              onStopped: {
                                  // Ha terminado y velocity=0

                                  mainLottie.visible = false
                                  transitionTwo.start()
                                  transitionedLottie.visible = true

                              }
                          }

                          NumberAnimation on opacity {
                              id: transitionTwo

                              running: false

                              easing.type: Easing.OutQuint
                              from: 0
                              to: 1
                              duration: 2500

                              onStopped: {
                                  // Ha terminado y velocity=0

                                  // Le dejamos un loop más
                                  setTransitionedTimeout(() => {
                                         transitionThree.start()
                                  }, 2000)


                              }
                          }

                          NumberAnimation on opacity {
                              id: transitionThree

                              running: false

                              easing.type: Easing.InQuint
                              from: 1
                              to: 0
                              duration: 2100

                              onStopped: {
                                  // Ha terminado y velocity=0

                                 transitionedLottie.visible = false
                                 transitionFour.start()
                                 mainLottie.visible = true


                              }
                          }

                          NumberAnimation on opacity {
                              id: transitionFour

                              running: false

                              easing.type: Easing.InQuint
                              from: 0
                              to: 1
                              duration: 1300

                              onStopped: {
                                  // Ha terminado y velocity=0
                                  transitionOne.start()
                              }
                          }
                    }

                  Component.onCompleted: {

                  }
            }

            Component.onCompleted: {

                if (welcomePageIndex === 1) {
                   lottie.y = lottie.y + 50 // Adjustement because of the size
                }
                else if (welcomePageIndex == 4) {
                   parent.anchors.bottomMargin = 10
                }
                else {
                    parent.anchors.bottomMargin = 30
                }

            }
        }

    }

    Column {
        id: termsColumn
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: contentPadding
        spacing: dp(5)

    // Terms

            AppText {

                visible: welcomePageIndex == 4

                text: qsTr("Tocando en Comenzar, aceptas los ")
                font.pixelSize: getTextSize(13)



                width: parent.width

                horizontalAlignment: Text.AlignHCenter

                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            }

            AppButton {

                visible: welcomePageIndex == 4

                width: parent.width
                backgroundColor: pagesBackColor
                borderColor: pagesBackColor

                radius: dp(10)

                flat: true

                verticalMargin: 0

                text: qsTr("Términos y Condiciones de uso")
                textSize: getTextSize(13)

                iconRight: IconType.externallink

                textColor: "#3498DB"
                textColorPressed: "#3498DB"
                fontBold: true


                onClicked: {
                    nativeUtils.openUrl("https://www.miraclia.com/t%C3%A9rminos-y-condiciones-de-uso")
                }
            }

    // End Terms

        ActionButton {
          id: continueBtn

          width: parent.width

          text: welcomePageIndex != 4 ? qsTr("Siguiente") : qsTr("Comenzar")

          textSize: 14
          fontBold: true

          textColor: "#FFFFFF"
          textColorDisabled: "#ECEFF2"
          backgroundColor: "#258DFD"
          backgroundColorPressed: "#1183FD" // Pressed/disabled background color


          anchors.horizontalCenter: parent.horizontalCenter

          iconRight: IconType.arrowright
          iconSize: getTextSize(8)




          onClicked: {

              let nextIndex = welcomePageIndex + 1
              var currentOptions = {welcomePageIndex: welcomePageIndex, isTransPage: nextIndex == 2,
                    lottieSize: (welcomePageIndex === 1 ? 384 : 256)}


              if (welcomePageIndex != 4) // last Page
              {           

                var options = {welcomePageIndex: nextIndex, isTransPage: nextIndex == 2, lottieSize: (nextIndex === 1 ? 384 : 256)}

                // pushWithCleanUp for CPU
                navStack.pushWithCleanUp(welcomePageComponent, options, currentOptions)
              }
              else
              {
                  var fOpts = {fromWelcome: true}
                  navStack.enableBottomToTop()

                  navStack.popAllExceptFirstAndPush(dashLayoutPageComponent, fOpts)
                  disposeWelcomeLottietimer.running = true
              }

          }
        }

       CopyText { topPadding: 15}

    }

    Timer {
        id: transitionedTimer
        running: false
        repeat: false

        property var callback

        onTriggered: callback()
    }



    function setTransitionedTimeout(callback, delay)
    {
        if (transitionedTimer.running) {
            console.error("nested calls to setTimeout are not supported!");
            return;
        }

        transitionedTimer.callback = callback;
        transitionedTimer.interval = delay;
        transitionedTimer.running = true;
    }

    Timer {
        id: disposeWelcomeLottietimer

        running: false
        repeat: false
        interval: 250

        onTriggered: {
            mainLottie.pause() // .dispose() breaks engine

            console.debug("[DEBUG] Paused Welcome lottie!")
        }
    }

    Component {
        id: dashLayoutPageComponent

        DashLayoutTab {}
    }

    navigationBarHidden: true
}
