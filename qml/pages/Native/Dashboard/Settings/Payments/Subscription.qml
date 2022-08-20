import QtQuick 2.0
import Felgo 3.0

import "../../../../../helper"

import Qt.labs.lottieqt 1.0
import blazorin.QtLottie 1.0

Item {

    id: subscriptionPage

    //title: qsTr((!useCustomSubscriptionKind ? "Subscripción" : "Tienda"))
    //backgroundColor: pagesBackColorGrey

    width: root.width
    height: root.height

    property real marginCol: 25

    Component.onCompleted: {
        //console.debug("final: " + getAllHeights())
        //console.debug(root.height)

        scroller.contentHeight = getAllHeights()
    }

    // Use These properties if the User comes from the Store page instead of Settings tab
    property bool useCustomSubscriptionKind: false
    property int customSubscriptionKind: 0

    property int subscriptionKindToDisplay: (useCustomSubscriptionKind ? customSubscriptionKind : subscriptionKind)

    // For StoreView optimization
    property bool showLottie: (subscriptionsStoreExternalIndex == customSubscriptionKind) // external managed property
    property bool lottieVisible: true

    // This timer helps position on StoreView (SwipeView)
    Timer {
        id: storeViewPositionTimer

        running: true
        repeat: true
        interval: 35

        onTriggered: {
            if (!useCustomSubscriptionKind) {
                storeViewPositionTimer.running = false
                return
            }

            secondRow.x = firstRow.x
            thirdRow.x = firstRow.x
            forthRow.x = firstRow.x
            fifthRow.x = firstRow.x
            sixthRow.x = firstRow.x
        }
    }


    Timer {
        id: lottieControlStarterTimer

        running: true
        repeat: false

        interval: 10

        onTriggered: {
            if (!useCustomSubscriptionKind) {
                lottieControlStarterTimer.running = false
                return
            }


            if (lottieVisible && !showLottie)
            {
                //subcriptionLottie.frameRate = 2
                subcriptionLottie.pause()
                lottieVisible = false

                console.debug("[DEBUG] Paused StoreView Subscription lottie!")

                return
            }

            lottiePauseTimer.running = true
            lottieResumeTimer.running = true

            lottieControlStarterTimer.running = false
            lottiePauseTimerStartup.running = true

            //console.debug("[DEBUG] lottieControlStarterTimer has run.")
        }
    }


    property int pauseTimerStartupTimes: 0
    // This timer is made for the purpose, depending on the device, the lotties could take more to load
    // and thus dont pause the animation. So I give a 1S period for the completion to happen, so we can stop it
    Timer {
        id: lottiePauseTimerStartup

        running: true
        repeat: true
        interval: 50


        onTriggered: {

            if (pauseTimerStartupTimes == 20 || showLottie) {
                lottiePauseTimerStartup.running = false
                return
            }

            if (!showLottie) // 1 and 2
            {
                subcriptionLottie.pause()
                lottieVisible = false

                pauseTimerStartupTimes++
            }
        }
    }

    // This timmer will avoid Lag and app crashes due to the Lotties on StoreView
    Timer {
        id: lottiePauseTimer

        running: false
        repeat: true
        interval: 250


        onTriggered: {


            if (lottieVisible && !showLottie)
            {
                //subcriptionLottie.frameRate = 2
                subcriptionLottie.pause()
                lottieVisible = false

                console.debug("[DEBUG] Paused StoreView Subscription lottie!")

                return
            }
        }
    }


    // This timmer will avoid Lag and app crashes due to the Lotties on StoreView
    Timer {
        id: lottieResumeTimer

        running: false
        repeat: true
        interval: 30


        onTriggered: {

            if (!lottieVisible && showLottie)
            {
                subcriptionLottie.resume()
                lottieVisible = true

                //console.debug("[DEBUG] Resumed StoreView Subscription lottie!")
            }
        }
    }


    AppFlickable {
          id: scroller

          anchors.fill: parent

          contentWidth: parent.width
          //contentHeight: getAllHeights()

          // I do care here for the scroll. otherwise just contentColumn.height

          flickableDirection: Flickable.VerticalFlick

          onMovementStarted: {
              //console.debug("H: " + (contentY)) // f(x)
              //console.debug("CY: " + (contentY - originY) * (height / contentHeight))
          }

      Column {
          id: contentColumn
          anchors.left: parent.left
          anchors.right: parent.right
          anchors.top: parent.top
          anchors.topMargin: marginCol

          anchors.leftMargin: dp(20)
          anchors.rightMargin: dp(20)

          spacing: dp(20)

          AppText {
              width: parent.width
              wrapMode: Text.WrapAtWordBoundaryOrAnywhere

              horizontalAlignment: Text.AlignHCenter
              leftPadding: ((subscriptionKindToDisplay == 0 || subscriptionKindToDisplay == 2) ? 11 : 0)

              text: qsTr((subscriptionKindToDisplay == subscriptionKind ? "Mi subscripción" : "Ver subscripción"))
              font.pixelSize: getTextSize(23)

              font.weight: Font.ExtraLight
          }

          CuteText {
              width: parent.width

              horizontalAlignment: Text.AlignHCenter
              color: cuteColorSecondary

              text: qsTr("Expira: " + subscriptionEndDate)
              font.pixelSize: getTextSize(13, true)

              visible: ((subscriptionKindToDisplay == subscriptionKind) && subscriptionKindToDisplay != 0)
          }
      }

      Column {
          id: subcriptionLottieColumn

          anchors.top: contentColumn.bottom

          anchors.left: parent.left
          anchors.right: parent.right

          anchors.topMargin: 25
          anchors.leftMargin: dataModel.getSubscriptionLottie(subscriptionKindToDisplay).leftMargin
          anchors.rightMargin: dataModel.getSubscriptionLottie(subscriptionKindToDisplay).rightMargin

                Item {

                    anchors.horizontalCenter: parent.horizontalCenter

                    id: lottie

                    width: dataModel.getSubscriptionLottie(subscriptionKindToDisplay).width
                    height: dataModel.getSubscriptionLottie(subscriptionKindToDisplay).height

                       LottieItem {
                           id: subcriptionLottie

                           source: "../../../../../../assets/subscription/" + dataModel.getSubscriptionLottie(subscriptionKindToDisplay).name + ".json"
                           anchors.fill: parent
                           }
                      }


            }

      Column {
          id: subscriptionTagColumn

          anchors.top: subcriptionLottieColumn.bottom


          anchors.left: parent.left
          anchors.right: parent.right

          anchors.topMargin: marginCol
          anchors.leftMargin: dp(20)
          anchors.rightMargin: dp(20)

          spacing: dp(15)

          PromoRectangle {
              text: dataModel.getSubscriptionLottie(subscriptionKindToDisplay).title
              textSizeInt: 16

              radius: dp(15)

              textColor: "#FFFFFF"
              bgColor: dataModel.getSubscriptionLottie(subscriptionKindToDisplay).color
              bold: true

              anchors.horizontalCenter: parent.horizontalCenter
          }

          SeparatorLine {
              width: parent.width
              height: dp(6)

              radius: dp(5)

              color: dataModel.getSubscriptionLottie(subscriptionKindToDisplay).color
          }
      }

      Column {
          id: subscriptionFeaturesColumnFirst

          anchors.top: subscriptionTagColumn.bottom
          anchors.left: parent.left
          anchors.right: parent.right

          anchors.leftMargin: dp(20)
          anchors.rightMargin: dp(10)

          anchors.topMargin: 15

          spacing: dp(8)

          FeatureRow {
              id: firstRow

              //spacing: 0
              boldText: qsTr(dataModel.getSubscriptionLottie(subscriptionKindToDisplay).dailyPranks +  " ")
              mainText: "bromas" + (subscriptionKindToDisplay != 2 ? " diarias incluidas" : ", infinitas risas")

              textSizeInt: 19

              icon: IconType.phone
              iconColor: "#EC7063"

              anchors.horizontalCenter: parent.horizontalCenter

              /*
              AppImage {
                 source: "../../../../../../assets/subscription/checkbox.svg"

                 width: (!isTablet ? (dp(32)) : (dp(64)))
                 //anchors.horizontalCenter: parent.horizontalCenter
                 fillMode: Image.PreserveAspectFit

                 anchors.verticalCenter: parent.verticalCenter

              }
              */

          }

          SeparatorLine {
              id: firstSeparator

              width: firstRow.width + dp(50)
              //width: parent.width / 1.5

              anchors.horizontalCenter: parent.horizontalCenter

              height: dp(2)

              Component.onCompleted: {
                  if (isTablet)
                      height = dp(3)
              }


              color: "#D5DBDB"
          }

          FeatureRow {
              id: secondRow

              //spacing: 0
              boldText: qsTr(dataModel.getSubscriptionLottie(subscriptionKindToDisplay).rewardsMultiplier + "X" +  " ")
              mainText: qsTr("en todas recompensas")

              boldTextLeftPadding: 20
              textSizeInt: 19

              icon: IconType.dollar
              iconColor: "#4CB42A"


              Component.onCompleted: {

                  secondRow.x = firstRow.x
              }

          }

          SeparatorLine {
              width: firstSeparator.width
              //width: parent.width / 1.5

              anchors.horizontalCenter: parent.horizontalCenter

              height: dp(2)

              Component.onCompleted: {
                  if (isTablet)
                      height = dp(3)
              }


              color: "#D5DBDB"
          }

  }

      Column {
          id: subscriptionFeaturesColumnSecond

          anchors.top: subscriptionFeaturesColumnFirst.bottom
          anchors.left: parent.left
          anchors.right: parent.right

          anchors.leftMargin: dp(20)
          anchors.rightMargin: dp(10)

          anchors.topMargin: (subscriptionKindToDisplay == 1 || subscriptionKindToDisplay == 2 ? 25 : 0)

          spacing: dp(8)

          visible: subscriptionKindToDisplay == 1 || subscriptionKindToDisplay == 2

          FeatureRow {
              id: thirdRow

              mainText: qsTr("Acceso a bromas Premium")

              boldTextVisible: false

              textSizeInt: 19

              icon: IconType.key
              iconColor: "#FDBA23"

              visible: subscriptionKindToDisplay == 1 || subscriptionKindToDisplay == 2

              Component.onCompleted: {
                  thirdRow.x = firstRow.x
              }

          }

          SeparatorLine {
              width: firstSeparator.width
              //width: parent.width / 1.5

              anchors.horizontalCenter: parent.horizontalCenter

              height: dp(2)

              Component.onCompleted: {
                  if (isTablet)
                      height = dp(3)
              }

              visible: subscriptionKindToDisplay == 1 || subscriptionKindToDisplay == 2

              color: "#FDBA23"
          }
      }

      Column {
          id: subscriptionFeaturesColumnThird

          anchors.top: subscriptionFeaturesColumnSecond.bottom
          anchors.left: parent.left
          anchors.right: parent.right

          anchors.leftMargin: dp(20)
          anchors.rightMargin: dp(10)

          anchors.topMargin: (subscriptionKindToDisplay == 2 ? 20 : 0)

          spacing: dp(8)

          visible: subscriptionKindToDisplay == 2


          FeatureRow {
              id: sixthRow // I think moving it here is a better idea.

              //spacing: 0
              boldText: qsTr("Eliges" +  " ")
              mainText: qsTr("el número saliente!")


              boldTextLeftPadding: 17
              mainTextLeftPadding: 2

              textSizeInt: 19

              icon: IconType.locationarrow
              iconColor: "#A840FF"

              visible: subscriptionKindToDisplay == 2

              Component.onCompleted: {
                  sixthRow.x = firstRow.x
              }

          }

          SeparatorLine {
              width: firstSeparator.width
              //width: parent.width / 1.5

              anchors.horizontalCenter: parent.horizontalCenter

              height: dp(2)

              Component.onCompleted: {
                  if (isTablet)
                      height = dp(3)
              }

              visible: subscriptionKindToDisplay == 2

              color: "#A840FF"
          }
      }

      Column {
          id: subscriptionFeaturesColumnForth

          anchors.top: subscriptionFeaturesColumnThird.bottom
          anchors.left: parent.left
          anchors.right: parent.right

          anchors.leftMargin: dp(20)
          anchors.rightMargin: dp(10)

          anchors.topMargin: (subscriptionKindToDisplay == 1 || subscriptionKindToDisplay == 2 ? 25 : 0)

          spacing: dp(8)

          visible: subscriptionKindToDisplay == 1 || subscriptionKindToDisplay == 2

          Row {
              id: forthRow

              spacing: 0

               Icon {

                     id: iconElem

                     icon: IconType.tag
                     size: mainTextTag.height * 1.3

                     color: "#BBC3C3"

                     }


                  AppText {
                      id: mainTextTag

                      topPadding: dp(3)
                      wrapMode: Text.WrapAtWordBoundaryOrAnywhere

                      anchors.verticalCenter: parent.verticalCenter

                      font.pixelSize: getTextSize(19, true)

                      text: qsTr("Tag ")

                      leftPadding: 14
                  }

                  AppText {
                      id: colorTextTag

                      topPadding: dp(3)
                      wrapMode: Text.WrapAtWordBoundaryOrAnywhere

                      anchors.verticalCenter: parent.verticalCenter

                      font.pixelSize: getTextSize(19, true)
                      font.bold: true

                      text: qsTr(dataModel.getSubscriptionLottie(subscriptionKindToDisplay).title)
                      color: dataModel.getSubscriptionLottie(subscriptionKindToDisplay).color

                  }

                  AppText {
                      id: endTextTag

                      topPadding: dp(3)
                      wrapMode: Text.WrapAtWordBoundaryOrAnywhere

                      anchors.verticalCenter: parent.verticalCenter

                      font.pixelSize: getTextSize(19, true)

                      text: qsTr(" en tu Perfil")

                  }


              Component.onCompleted: {
                  forthRow.x = firstRow.x

              }
          }

          SeparatorLine {
              width: firstSeparator.width
              //width: parent.width / 1.5

              anchors.horizontalCenter: parent.horizontalCenter

              height: dp(2)

              Component.onCompleted: {
                  if (isTablet)
                      height = dp(3)
              }

              visible: subscriptionKindToDisplay == 1 || subscriptionKindToDisplay == 2

              color: "#D5DBDB"
          }

          FeatureRow {
              id: fifthRow

              mainText: qsTr("¡Sin publicidad!")

              boldTextVisible: false

              mainTextLeftPadding: 14

              textSizeInt: 19

              icon: IconType.ban
              iconColor: "#F30900"

              visible: subscriptionKindToDisplay == 1 || subscriptionKindToDisplay == 2

              Component.onCompleted: {
                  fifthRow.x = firstRow.x
              }

          }

          SeparatorLine {
              width: firstSeparator.width
              //width: parent.width / 1.5

              anchors.horizontalCenter: parent.horizontalCenter

              height: dp(2)

              Component.onCompleted: {
                  if (isTablet)
                      height = dp(3)
              }

              visible: subscriptionKindToDisplay == 1 || subscriptionKindToDisplay == 2

              color: "#D5DBDB"
          }
      }
    }

    // From Settings, promt to go to Store
    // From Store, prompt purchase

    // This column its outside Flickable to position over the other elements
    Column {
        id: subscriptionActionColumn

        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.leftMargin: dp(20)
        anchors.rightMargin: dp(10)

        anchors.bottomMargin: dp(30)

        spacing: dp(8)


        ActionButton {
          id: subscriptionActionBtn

          width: parent.width - dp(30)

          //text: qsTr((!useCustomSubscriptionKind ? "Ir a la Tienda" : "Adquirir Subscripción"))

          textSize: 14
          fontBold: true


          textColor: "#FFFFFF"
          textColorDisabled: "#FFFFFF"
          backgroundColor: "#047AFF"
          backgroundColorPressed: "#086CDC" // Pressed background color

          disabledColorRemoved: true

          anchors.horizontalCenter: parent.horizontalCenter

          Component.onCompleted: {
              if (!useCustomSubscriptionKind && subscriptionKindToDisplay == 2) {
                  subscriptionActionBtn.visible = false
                  return
              }

              if (useCustomSubscriptionKind && (customSubscriptionKind == subscriptionKind)) {
                  subscriptionActionBtn.text = qsTr("Subscripción actual")
                  subscriptionActionBtn.enabled = false

                  subscriptionActionBtn.disabledColor = "#FFFFFF"
                  subscriptionActionBtn.textColorDisabled = "#047AFF"

                  return
              }

              if (useCustomSubscriptionKind && (subscriptionKind > customSubscriptionKind)) {
                   subscriptionActionBtn.text = qsTr("Bajar a esta Subscripción")
                  return
              }

              subscriptionActionBtn.text = qsTr((!useCustomSubscriptionKind ? "Ir a la Tienda" : (subscriptionKind == 0 ? "Adquirir Subscripción" : "Mejorar Subscripción")))
          }

          onClicked: {
              // Logic

              if (!useCustomSubscriptionKind) {

                  cachedSubscriptionSettingsPage = subscriptionPage
                  cachedSubscriptionSettingsLottieNeedPause = true

                  navStack.push(subscriptionsStoreExternalComponent)


                  //navStack.pop()// to prevent recursive
                  return
              }

              let wantsDowngrade = useCustomSubscriptionKind && (subscriptionKind > customSubscriptionKind)
          }
        }
    }

    Timer {
        id: actionBtnOpacityTimer

        running: true
        repeat: true
        interval: 10

        onTriggered: {

            let opacityCalc = ( ((scroller.visibleArea.yPosition) * 10) / 1.5 )
            if (isTablet)
                opacityCalc *= 2.5

            if (subscriptionKindToDisplay == 0)
            {
                 opacityCalc = 1.0
                 actionBtnOpacityTimer.running = false
            }

            else if (subscriptionKindToDisplay == 1)
            {
                if (isTablet)
                {
                    opacityCalc = 1.0
                    actionBtnOpacityTimer.running = false
                }

                else {
                    opacityCalc *= 3.2
                }
            }

            if (opacityCalc >= 0.7)
                opacityCalc += 0.07

            if (opacityCalc <= 0.3)
                opacityCalc = 0.3
            else if (opacityCalc >= 0.97)
                opacityCalc = 1.0

            if (scroller.atYEnd)
                opacityCalc = 1.0

            if (!firstEntered && (opacityCalc >= 0.93 || scroller.atYEnd)) {
                opacityCalc = 1.0

                actionBtnOpacityTimer.running = false
            }

            subscriptionActionBtn.opacity = opacityCalc

            if (!(useCustomSubscriptionKind && (customSubscriptionKind == subscriptionKind)))
            {
                if (opacityCalc >= 0.8 && !subscriptionActionBtn.enabled) {
                    subscriptionActionBtn.enabled = true
                }
                else if (opacityCalc < 0.8 && subscriptionActionBtn.enabled)
                    subscriptionActionBtn.enabled = false
            }

            //console.debug("AC btn: " +  " / " + opacityCalc + " / " + subscriptionFeaturesColumnForth.y + "/" + subscriptionPage.height)
            if (!firstEntered)
                firstEntered = true

        }
    }

    property bool firstEntered: false

    function getAllHeights() {
        return ( contentColumn.height + marginCol + subcriptionLottieColumn.height + 25 + subscriptionTagColumn.height + marginCol
        + subscriptionFeaturesColumnFirst.height + 15
        + (subscriptionKindToDisplay == 1 || subscriptionKindToDisplay == 2 ? (subscriptionFeaturesColumnSecond.height + 25) : 0 )
        + (subscriptionKindToDisplay == 2 ? (subscriptionFeaturesColumnThird.height + 20) : 0 )
        + (subscriptionKindToDisplay == 1 || subscriptionKindToDisplay == 2 ? (subscriptionFeaturesColumnForth.height + 25) : 0 )
        + ((!useCustomSubscriptionKind && subscriptionKindToDisplay == 2) ? 0 : (subscriptionActionColumn.height + 30))
        + (!isTablet ? 13 : 30) )

        // Sin dp(x) porque al haber tantas columnas, daba lugar a cantidades muy diferentes en otros dispositivos
    }

    /*
    Timer {
        id: pauseSettingsLottietimer

        running: false
        repeat: false
        interval: 1500

        onTriggered: {
            subcriptionLottie.pause()

            cachedSubscriptionSettingsPageReady = true
            cachedSubscriptionSettingsPage = subscriptionPage

            console.debug("[DEBUG] Paused Settings Subscription lottie!")
        }
    }
    */

    function pauseSettingsLottie() {
        subcriptionLottie.pause()

        console.debug("[DEBUG] Paused Settings Subscription lottie!")
    }

    function resumeSettingsLottie() {
        subcriptionLottie.resume()

        cachedSubscriptionSettingsPage = null

        console.debug("[DEBUG] Resumed Settings Subscription lottie!")
    }

    ScrollIndicator {
        flickable: scroller
    }

}
