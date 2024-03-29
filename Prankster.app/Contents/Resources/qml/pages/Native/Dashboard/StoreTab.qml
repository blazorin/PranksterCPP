import QtQuick 2.0
import QtGraphicalEffects 1.15
import Felgo 3.0
import "../../../helper"

Page {

    title: "Tienda"
    backgroundColor: pagesBackColorGrey

    navigationBarHidden: true
    backNavigationEnabled: false // important


  AppFlickable {
        id: scroller

        anchors.fill: parent

        contentWidth: parent.width
        contentHeight: (logoColumn.height) + topTitleMarginBig + storeColumn.height + 40 + ((c1.height) * 1.75) + 20

        flickableDirection: Flickable.VerticalFlick

    Column {
        id: logoColumn
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: topTitleMarginBig

        //spacing: 20


        AppImage {
           source: "../../../../assets/prankster-logo.svg"

           width: (!isTablet ? (parent.width / 1.2) : (parent.width / 1.5))
           anchors.horizontalCenter: parent.horizontalCenter
           fillMode: Image.PreserveAspectFit


        }

    }


    Column {
        id: storeColumn
        anchors.left: parent.left
        anchors.leftMargin: dp(20)

        anchors.right: parent.right
        anchors.rightMargin: dp(20)

        anchors.top: logoColumn.bottom
        anchors.topMargin: 10

        //spacing: 15


        AppImage {
           source: "../../../../assets/store/store_cuerda.svg"

           width: (!isTablet ? (parent.width / 1.2) : (parent.width / 1.8))
           anchors.horizontalCenter: parent.horizontalCenter
           fillMode: Image.PreserveAspectFit

           CuteText {
               width: parent.width

               horizontalAlignment: Text.AlignHCenter

               anchors.top: parent.top
               anchors.topMargin: (!isTablet ? (parent.height / 15) : (parent.height / 10))

               color: "white"
               text: qsTr("Tienda")
               font.pixelSize: getTextSize(45, true)

               font.family: blackjackFont.name

               wrapMode: Text.WrapAtWordBoundaryOrAnywhere

           }

        }

    }


    Column {
        id: cardsColumn
        anchors.left: parent.left
        anchors.leftMargin: dp(30)

        anchors.right: parent.right
        anchors.rightMargin: dp(30)

        anchors.top: storeColumn.bottom
        anchors.topMargin: 60

        spacing: 10

        // So it keeps centered on tablets

        // START FIRST ROW

        Rectangle {
            id: recPosHelper

            height: 205

            width: 5
            color: "black"
            visible: false

            anchors.horizontalCenter: parent.horizontalCenter

        }


            Rectangle {
                id: c1

                width: (parent.width / 2) - (!isTablet ? 10 : 50)
                height: 205

                radius: 15

                anchors.right: recPosHelper.left
                anchors.rightMargin: 7

                anchors.top: recPosHelper.top

                gradient: Gradient {
                    GradientStop { position: 0.0; color: layoutIconColorActive }
                    GradientStop { position: 0.4; color: layoutIconColorActive }
                    GradientStop { position: 0.41; color: "#FFFFFF" }
                    //GradientStop { position: 1.0; color: "green" }
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        navStack.push(storeInAppComponent)
                    }
                }

                Rectangle {

                    width: 60
                    height: 35

                    radius: 20
                    color: Theme.navigationTabBar.titleColor

                    anchors.horizontalCenter: parent.horizontalCenter

                    anchors.bottom: parent.top
                    anchors.bottomMargin: 10


                    AppText {
                        font.pixelSize: getTextSize(16)
                        color: "#FFFFFF"

                        font.bold: true

                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: phoneIcon.left
                        anchors.rightMargin: (callBalance < 10 ? 13 : (callBalance < 99 ? 7 : (callBalance < 200 ? 3 : 2) ))

                        text: callBalance

                    }

                    Icon {
                        id: phoneIcon

                        size: 20
                        icon: IconType.phone

                        color: "#FFFFFF"

                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 7
                    }
                }




                    AppText {
                        font.pixelSize: getTextSize(22, true)
                        font.bold: true

                        font.family: montserratFont.name

                        //font.wordSpacing: 1
                        font.letterSpacing: 3

                        color: "white"

                        anchors.top: parent.top
                        anchors.topMargin: 27

                        anchors.left: parent.left
                        anchors.leftMargin: (!isTablet ? 17 : 22)



                        text: qsTr("BROMAS")


                        AppText {
                            font.pixelSize: getTextSize(14)
                            font.bold: true
                            color: pagesBackColorGrey

                            anchors.bottom: parent.top
                            anchors.bottomMargin: 2


                            text: "2 X 1"
                            visible: root.doubleOfferEnabled

                            anchors.horizontalCenter: parent.horizontalCenter

                            SequentialAnimation on color
                            {
                                loops: Animation.Infinite

                                ColorAnimation
                                {
                                    from: "white"
                                    to: "white"
                                    duration: 1000
                                }

                                ColorAnimation
                                {
                                    from: "white"
                                    to: layoutIconColorActive
                                    duration: 500
                                }
                                ColorAnimation
                                {
                                    from: layoutIconColorActive
                                    to: "white"
                                    duration: 500
                                }

                            }

                            Icon {
                                color: "#FCCE69"

                                anchors.right: parent.left
                                anchors.rightMargin: 5

                                size: 14

                                icon: IconType.star
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }


                        Icon {
                            icon: IconType.arrowright
                            size: (!isTablet ? 13 : 14)

                            anchors.top: parent.bottom
                            anchors.topMargin: (!isTablet ? 10 : 9)

                            color: "white"

                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }

                AppImage {
                       width: (!isTablet ? (parent.width / 2) : (parent.width / 3))

                       fillMode: Image.PreserveAspectFit

                       source: "../../../../assets/home/prankster_icon_final.svg"

                       anchors.bottom: parent.bottom
                       anchors.bottomMargin: 20

                       anchors.horizontalCenter: parent.horizontalCenter

                       z: 0
                }

                Rectangle {
                    property real offset: Math.min(parent.width*0.045, parent.height*0.045)
                    color: layoutIconColorActive
                    width: parent.width
                    height: parent.height
                    z: -1
                    opacity: 0.75
                    radius: parent.radius + 2
                    anchors.left: parent.left
                    anchors.leftMargin: -offset
                    anchors.top: parent.top
                    anchors.topMargin: offset

                    /*
                    SequentialAnimation on color
                    {
                        loops: Animation.Infinite

                        ColorAnimation
                        {
                            from: layoutIconColorActive
                            to: layoutIconColorActive
                            duration: 1450
                        }

                        ColorAnimation
                        {
                            from: layoutIconColorActive
                            to: pagesBackColorGrey
                            duration: 2000
                        }
                        ColorAnimation
                        {
                            from: pagesBackColorGrey
                            to: layoutIconColorActive
                            duration: 1250
                        }

                    }
                    */
                }

        }

        Rectangle {

            height: 205
            width: (parent.width / 2) - (!isTablet ? 10 : 50)

            radius: 15

            gradient: Gradient {
                GradientStop { position: 0.0; color: "#FBB034"}
                GradientStop { position: 0.4; color: "#F9B54B" }
                GradientStop { position: 0.41; color: "#FFFFFF" }
                //GradientStop { position: 1.0; color: "green" }
            }

            anchors.left: recPosHelper.right
            anchors.leftMargin: 7

            anchors.top: recPosHelper.top

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    navStack.push(subscriptionsStoreExternalComponent)
                }
            }

            PromoRectangle {
                  id: subscriptionRec

                  visible: subscriptionKind > 0

                  anchors.bottom: parent.top
                  anchors.bottomMargin: 10

                  width: 85
                  height: 35
                  radius: 20

                  anchors.horizontalCenter: parent.horizontalCenter

                  text: qsTr(dataModel.getSubscriptionLottie(subscriptionKind).title.toUpperCase())
                  textSizeInt: 13


                  textColor: "#FFFFFF"
                  bgColor: dataModel.getSubscriptionLottie(subscriptionKind).color
                  bold: true
                }

            AppText {
                font.pixelSize: getTextSize(22, true)
                font.bold: true

                font.family: montserratFont.name

                //font.wordSpacing: 1
                font.letterSpacing: 3

                color: "white"

                anchors.top: parent.top
                anchors.topMargin: 27

                anchors.left: parent.left
                anchors.leftMargin: (!isTablet ? 17 : 22)



                text: qsTr("SUBS")

                Icon {
                    icon: IconType.arrowright
                    size: (!isTablet ? 13 : 14)

                    anchors.top: parent.bottom
                    anchors.topMargin: (!isTablet ? 10 : 9)

                    color: "white"

                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            AppText {
                text: "*"
                color: "black"
                visible: false

                y: parent.height * (!isTablet ? 0.613 : 0.63) // End of top color
                anchors.horizontalCenter: parent.horizontalCenter


                id: imageHelper2
            }

            AppImage {
                   width: (!isTablet ? (parent.width / 1.5) : (parent.width  / 2.2))

                   fillMode: Image.PreserveAspectFit

                   source: "../../../../assets/store/globe_v4.svg"

                   anchors.centerIn: imageHelper2

                   anchors.horizontalCenter: parent.horizontalCenter

                   z: 0
            }

            Rectangle {
                property real offset: Math.min(parent.width*0.045, parent.height*0.045)
                color: "#FFBC4F"
                width: parent.width
                height: parent.height
                z: -1
                opacity: 0.75
                radius: parent.radius + 2
                anchors.right: parent.right
                anchors.rightMargin: -offset
                anchors.top: parent.top
                anchors.topMargin: offset

                SequentialAnimation on color
                {
                    loops: Animation.Infinite

                    // Premium

                    ColorAnimation
                    {
                        from: "#FBB034"
                        to: "#FBB034"
                        duration: 1450
                    }

                    ColorAnimation
                    {
                        from: "#FBB034"
                        to: pagesBackColorGrey
                        duration: 2000
                    }
                    ColorAnimation
                    {
                        from: pagesBackColorGrey
                        to: "#A840FF"
                        duration: 1250
                    }

                    // Unlimited

                    ColorAnimation
                    {
                        from: "#A840FF"
                        to: "#A840FF"
                        duration: 1450
                    }

                    ColorAnimation
                    {
                        from: "#A840FF"
                        to: pagesBackColorGrey
                        duration: 2000
                    }
                    ColorAnimation
                    {
                        from: pagesBackColorGrey
                        to: "#FBB034"
                        duration: 1250
                    }

                }
            }

        }


        // END FIRST ROW

        // Subscriptions Rectangle

 Rectangle {
     id: parentSubsRec

     anchors.top: recPosHelper.bottom
     anchors.topMargin: 20

     anchors.horizontalCenter: parent.horizontalCenter

     width: childSubsRec.width + 4
     height: childSubsRec.height + 4
     radius: 17

     color: layoutIconColorActive

     MouseArea {
         anchors.fill: parent

         onClicked: {
             navStack.push(subscriptionsSettingsExternalComponent)
         }
     }

            Rectangle {
                id: childSubsRec

                color: "white"


                width: freePrankText.width + 15 + setsIcon.width + 3
                height: setsIcon.height + 10

                anchors.centerIn: parent

                radius: 15

                AppImage {
                    id: setsIcon

                    source: "../../../../assets/icons/me.svg"
                    width: 28
                    height: 28

                    anchors.left: parent.left
                    anchors.leftMargin: 5

                    anchors.verticalCenter: parent.verticalCenter


                    AppText {
                        id: freePrankText

                        text: qsTr("Mi Subscripción")
                        color: "#1F1E1E"

                        anchors.left: parent.right
                        anchors.leftMargin: 5

                        anchors.verticalCenter: parent.verticalCenter

                        font.pixelSize: getTextSize(15)
                        font.family: montserratFont.name
                        font.weight: Font.Medium

                        //font.bold: bold

                    }

                    ColorOverlay{
                        anchors.fill: parent
                        source: parent
                        color: layoutIconColorActive
                        transform:rotation
                        antialiasing: true
                    }
                }

            }

    }

         CuteText {
             width: parent.width

             anchors.top: parentSubsRec.bottom
             anchors.topMargin: 15

             anchors.horizontalCenter: parent.horizontalCenter

             horizontalAlignment: Text.AlignHCenter
             color: cuteColorSecondary

             text: qsTr("¡Subscríbete o realiza tu primera compra y no volverás a ver publicidad!")
             font.pixelSize: getTextSize(17, true)

             wrapMode: Text.WrapAtWordBoundaryOrAnywhere
             bottomPadding: dp(10)

             visible: !hasMadeAnyPurchase
         }

    }
  }


  DashLineColocator {
      anchors.bottom: parent.bottom
  }

  Component {
      id: storeInAppComponent

      StoreInApp {}
  }

}
