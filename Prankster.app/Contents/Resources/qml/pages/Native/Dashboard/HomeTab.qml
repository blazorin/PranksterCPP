import QtQuick 2.0
import QtGraphicalEffects 1.15
import Felgo 3.0
import "../../../helper"

Page {

    title: "Inicio"
    backgroundColor: pagesBackColorGreyExtra

    navigationBarHidden: true
    backNavigationEnabled: false // important




  AppFlickable {
        id: scroller

        anchors.fill: parent

        contentWidth: parent.width
        contentHeight: logoColumn.height + topTitleMarginBig + announcementColumn.height + 20 + homeColumn.height + 40 + cardsColumn.height + 20

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
        id: announcementColumn
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: logoColumn.bottom
        anchors.topMargin: 20

        CuteText {
            width: parent.width

            horizontalAlignment: Text.AlignHCenter
            color: "#817F7F"

            text: qsTr("Anuncio")
            font.pixelSize: getTextSize(13, true)

            bottomPadding: dp(7)

            visible: root.announcementText != ""
        }

        PromoRectangle {
            text: root.announcementText
            textSizeInt: 12

            radius: dp(15)

            textColor: "#FFFFFF"
            bgColor: root.announcemenTextColor
            bold: true

            visible: root.announcementText != ""

            anchors.horizontalCenter: parent.horizontalCenter

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    if (root.announcementTextUrl == "" || root.announcementText == "")
                        return

                    nativeUtils.openUrl(root.announcementTextUrl)
                }
            }
        }
    }

    Column {
        id: homeColumn
        anchors.left: parent.left
        anchors.leftMargin: dp(20)

        anchors.right: parent.right
        anchors.rightMargin: dp(20)

        anchors.top: announcementColumn.bottom
        anchors.topMargin: 40

        //spacing: 15


        CuteText {
            width: parent.width

            horizontalAlignment: Text.AlignHCenter
            color: "#1F1E1E"
            text: qsTr("¡Elige lo que quieres hacer!") + " 👌"
            font.pixelSize: getTextSize(21, true)

            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            bottomPadding: dp(10)
        }
    }


    Column {
        id: cardsColumn
        anchors.left: parent.left
        anchors.leftMargin: dp(30)

        anchors.right: parent.right
        anchors.rightMargin: dp(30)

        anchors.top: homeColumn.bottom
        anchors.topMargin: 20

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

            height: 205
            width: (parent.width / 2) - (!isTablet ? 10 : 50)

            radius: 15

            gradient: Gradient {
                GradientStop { position: 0.0; color: layoutIconColorActive }
                GradientStop { position: 0.4; color: layoutIconColorActive }
                GradientStop { position: 0.41; color: "#FFFFFF" }
                //GradientStop { position: 1.0; color: "green" }
            }

            anchors.right: recPosHelper.left
            anchors.rightMargin: 7

            anchors.top: recPosHelper.top

            AppText {
                font.pixelSize: getTextSize(18, true)
                //font.bold: true

                color: "white"

                anchors.top: parent.top
                anchors.topMargin: 13

                anchors.left: parent.left
                anchors.leftMargin: 23

                font.family: montserratFont.name
                font.weight: Font.bold

                text: qsTr("Hacer una")

                AppText {
                    font.pixelSize: getTextSize(22, true)
                    font.bold: true

                    font.family: montserratFont.name

                    //font.wordSpacing: 1
                    font.letterSpacing: 3

                    color: pagesBackColorGreyExtra

                    anchors.top: parent.top
                    anchors.topMargin: 27



                    text: qsTr("BROMA")

                    Icon {
                        icon: IconType.arrowright
                        size: (!isTablet ? 10 : 12)

                        anchors.top: parent.bottom
                        anchors.topMargin: (!isTablet ? 1 : 0)

                        color: "white"

                        anchors.horizontalCenter: parent.horizontalCenter
                    }
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
        }

        Rectangle {

            height: 205
            width: (parent.width / 2) - (!isTablet ? 10 : 50)

            radius: 15

            gradient: Gradient {
                GradientStop { position: 0.0; color: "#FFBC4F"}
                GradientStop { position: 0.4; color: "#FFBC4F" }
                GradientStop { position: 0.41; color: "#FFFFFF" }
                //GradientStop { position: 1.0; color: "green" }
            }

            anchors.left: recPosHelper.right
            anchors.leftMargin: 7

            anchors.top: recPosHelper.top

            AppText {
                font.pixelSize: getTextSize(18, true)
                //font.bold: true

                color: "white"

                anchors.top: parent.top
                anchors.topMargin: 13

                anchors.left: parent.left
                anchors.leftMargin: 23

                font.family: montserratFont.name
                font.weight: Font.bold

                text: qsTr("Ir a la")

                AppText {
                    font.pixelSize: getTextSize(22, true)
                    font.bold: true

                    font.family: montserratFont.name

                    //font.wordSpacing: 1
                    font.letterSpacing: 3

                    color: pagesBackColorGreyExtra

                    anchors.top: parent.top
                    anchors.topMargin: 27



                    text: qsTr("TIENDA")

                    Icon {
                        icon: IconType.arrowright
                        size: (!isTablet ? 10 : 12)

                        anchors.top: parent.bottom
                        anchors.topMargin: (!isTablet ? 1 : 0)

                        color: "white"

                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }

            AppImage {
                   width: (!isTablet ? (parent.width / 2) : (parent.width / 3))

                   fillMode: Image.PreserveAspectFit

                   source: "../../../../assets/home/woman.svg"

                   anchors.bottom: parent.bottom
                   anchors.bottomMargin: 14

                   anchors.horizontalCenter: parent.horizontalCenter

                   z: 0
            }
        }


        // END FIRST ROW

        // START SECOND ROW

        Rectangle {
            id: recPosHelperSecond

            height: 205

            width: 5
            color: "black"
            visible: false

            anchors.top: recPosHelper.bottom
            anchors.topMargin: parent.spacing * 1.5

            anchors.horizontalCenter: parent.horizontalCenter

        }

        Rectangle {
            id: communityRec

            height: 205
            width: (parent.width / 2) - (!isTablet ? 10 : 50)

            radius: 15

            gradient: Gradient {
                GradientStop { position: 0.0; color: "#31ddff"}
                GradientStop { position: 0.4; color: "#31ddff" }
                GradientStop { position: 0.41; color: "#FFFFFF" }
                //GradientStop { position: 1.0; color: "green" }
            }

            anchors.right: recPosHelperSecond.left
            anchors.rightMargin: 7

            anchors.top: recPosHelperSecond.top

            AppText {
                font.pixelSize: getTextSize(18, true)
                //font.bold: true

                color: "white"

                anchors.top: parent.top
                anchors.topMargin: 13

                anchors.left: parent.left
                anchors.leftMargin: 23

                font.family: montserratFont.name
                font.weight: Font.bold

                text: qsTr("Ir a la")

                AppText {
                    font.pixelSize: getTextSize(14, true)
                    font.bold: true

                    font.family: montserratFont.name

                    //font.wordSpacing: 1
                    font.letterSpacing: 2

                    color: pagesBackColorGreyExtra

                    anchors.top: parent.top
                    anchors.topMargin: 27



                    text: qsTr("COMUNIDAD")

                    Icon {
                        icon: IconType.arrowright
                        size: (!isTablet ? 10 : 12)

                        anchors.top: parent.bottom
                        anchors.topMargin: (!isTablet ? 1 : 0)

                        color: "white"

                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }

            AppImage {
                   width: (!isTablet ? (parent.width / 1.7) : (parent.width / 2.5))

                   fillMode: Image.PreserveAspectFit

                   source: "../../../../assets/home/social_2.svg"

                   anchors.bottom: parent.bottom
                   anchors.bottomMargin: 14

                   anchors.horizontalCenter: parent.horizontalCenter

                   z: 0
            }

        }

        DropShadow {
            anchors.fill: communityRec
            cached: true
            horizontalOffset: 1
            verticalOffset: 1
            radius: 8.0
            samples: 16
            color: "#31ddff"
            source: communityRec
        }


        Rectangle {

            height: 205
            width: (parent.width / 2) - (!isTablet ? 10 : 50)

            radius: 15

            gradient: Gradient {
                GradientStop { position: 0.0; color: "#35e27d"}
                GradientStop { position: 0.4; color: "#35e27d" }
                GradientStop { position: 0.41; color: "#FFFFFF" }
                //GradientStop { position: 1.0; color: "green" }
            }

            anchors.left: recPosHelperSecond.right
            anchors.leftMargin: 7

            anchors.top: recPosHelperSecond.top

            AppText {
                font.pixelSize: getTextSize(18, true)
                //font.bold: true

                color: "white"

                anchors.top: parent.top
                anchors.topMargin: 13

                anchors.left: parent.left
                anchors.leftMargin: 23

                font.family: montserratFont.name
                font.weight: Font.bold

                text: qsTr("Bromas")

                AppText {
                    font.pixelSize: getTextSize(22, true)
                    font.bold: true

                    font.family: montserratFont.name

                    //font.wordSpacing: 1
                    font.letterSpacing: 3

                    color: pagesBackColorGreyExtra

                    anchors.top: parent.top
                    anchors.topMargin: 27



                    text: qsTr("GRATIS")

                    Icon {
                        icon: IconType.arrowright
                        size: (!isTablet ? 10 : 12)

                        anchors.top: parent.bottom
                        anchors.topMargin: (!isTablet ? 1 : 0)

                        color: "white"

                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }

            AppImage {
                   width: (!isTablet ? (parent.width) : (parent.width / 1.5))

                   fillMode: Image.PreserveAspectFit

                   source: "../../../../assets/home/rewards.svg"

                   anchors.bottom: parent.bottom
                   anchors.bottomMargin: 14

                   anchors.horizontalCenter: parent.horizontalCenter

                   z: 0
            }
        }

        // END SECOND ROW

    }
  }

  DashLineColocator {
      anchors.bottom: parent.bottom
  }

}
