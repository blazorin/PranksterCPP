import QtQuick 2.0
import QtGraphicalEffects 1.15
import Felgo 3.0
import "../../../helper"

Page {

    title: "Inicio"
    backgroundColor: pagesBackColorGrey

    navigationBarHidden: true
    backNavigationEnabled: false // important




  AppFlickable {
        id: scroller

        anchors.fill: parent

        contentWidth: parent.width
        contentHeight: (logoColumn.height) + topTitleMarginBig + announcementColumn.height + 20 + homeColumn.height + 40 + ((c1.height + c2.height) * 1.27) + 20

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
                        navBox.currentIndex = 2
                    }
                }


                AppText {
                    font.pixelSize: getTextSize(18, true)
                    //font.bold: true

                    color: "white"

                    anchors.top: parent.top
                    anchors.topMargin: 13

                    anchors.left: parent.left
                    anchors.leftMargin: 23

                    font.family: montserratFont.name

                    text: qsTr("Hacer una")

                    AppText {
                        font.pixelSize: getTextSize(22, true)
                        font.bold: true

                        font.family: montserratFont.name

                        //font.wordSpacing: 1
                        font.letterSpacing: 3

                        color: "white"

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

                AppText {
                    text: "*"
                    color: "black"
                    visible: false

                    y: parent.height * 0.365 // End of top color
                    anchors.horizontalCenter: parent.horizontalCenter


                    id: imageHelper1
                }

                AppImage {
                       width: (!isTablet ? (parent.width / 2) : (parent.width / 3))

                       fillMode: Image.PreserveAspectFit

                       source: "../../../../assets/home/prankster_icon_final.svg"

                       anchors.top: imageHelper1.bottom
                       anchors.topMargin: dp(10)

                       anchors.bottom: parent.bottom
                       anchors.bottomMargin: dp(10)

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

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    navBox.currentIndex = 1
                }
            }

            AppText {
                font.pixelSize: getTextSize(18, true)
                //font.bold: true

                color: "white"

                anchors.top: parent.top
                anchors.topMargin: 13

                anchors.left: parent.left
                anchors.leftMargin: 23

                font.family: montserratFont.name

                text: qsTr("Ir a la")

                AppText {
                    font.pixelSize: getTextSize(22, true)
                    font.bold: true

                    font.family: montserratFont.name

                    //font.wordSpacing: 1
                    font.letterSpacing: 3

                    color: "white"

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

            AppText {
                text: "*"
                color: "black"
                visible: false

                y: parent.height * 0.365 // End of top color
                anchors.horizontalCenter: parent.horizontalCenter


                id: imageHelper2
            }

            AppImage {
                   width: (!isTablet ? (parent.width * 1.1) : (parent.width  / 1.3))

                   fillMode: Image.PreserveAspectFit

                   source: "../../../../assets/home/woman_2.svg"

                   anchors.top: imageHelper1.bottom
                   anchors.topMargin: dp(5)

                   anchors.bottom: parent.bottom
                   //anchors.bott


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
            anchors.topMargin: parent.spacing * 2

            anchors.horizontalCenter: parent.horizontalCenter

        }

        Rectangle {
            id: c2

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

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    navBox.currentIndex = 3
                }
            }

            AppText {
                font.pixelSize: getTextSize(18, true)
                //font.bold: true

                color: "white"

                anchors.top: parent.top
                anchors.topMargin: 13

                anchors.left: parent.left
                anchors.leftMargin: 23

                font.family: montserratFont.name

                text: qsTr("Ir a la")

                AppText {
                    font.pixelSize: getTextSize(14, true)
                    font.bold: true

                    font.family: montserratFont.name

                    //font.wordSpacing: 1
                    font.letterSpacing: 2

                    color: "white"

                    anchors.top: parent.top
                    anchors.topMargin: 27



                    text: qsTr("COMUNIDAD")

                    Icon {
                        icon: IconType.arrowright
                        size: (!isTablet ? 11 : 12)

                        anchors.top: parent.bottom
                        anchors.topMargin: 8.5

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
                   anchors.bottomMargin: ((height / width) * (!isTablet ? 7 : 13))

                   anchors.horizontalCenter: parent.horizontalCenter

                   z: 0
            }

            Rectangle {
                property real offset: Math.min(parent.width*0.045, parent.height*0.045)
                color: "#31ddff"
                width: parent.width
                height: parent.height
                z: -1
                opacity: 0.75
                radius: parent.radius + 2
                anchors.left: parent.left
                anchors.leftMargin: -offset
                anchors.top: parent.top
                anchors.topMargin: offset
            }

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

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    // Navigate to Rewards Page
                }
            }

            AppText {
                font.pixelSize: getTextSize(18, true)
                //font.bold: true

                color: "white"

                anchors.top: parent.top
                anchors.topMargin: 13

                anchors.left: parent.left
                anchors.leftMargin: 23

                font.family: montserratFont.name

                text: qsTr("Bromas")

                AppText {
                    font.pixelSize: getTextSize(22, true)
                    font.bold: true

                    font.family: montserratFont.name

                    //font.wordSpacing: 1
                    font.letterSpacing: 3

                    color: "white"

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
                   anchors.bottomMargin: ((height / width) * (!isTablet ? 10 : 13))

                   anchors.horizontalCenter: parent.horizontalCenter

                   z: 0
            }

            Rectangle {
                property real offset: Math.min(parent.width*0.045, parent.height*0.045)
                color: "#35e27d"
                width: parent.width
                height: parent.height
                z: -1
                opacity: 0.75
                radius: parent.radius + 2
                anchors.right: parent.right
                anchors.rightMargin: -offset
                anchors.top: parent.top
                anchors.topMargin: offset
            }
        }

        // END SECOND ROW

        // Settings Rectangle

 Rectangle {
     anchors.top: recPosHelperSecond.bottom
     anchors.topMargin: 20

     anchors.horizontalCenter: parent.horizontalCenter

     width: childSetsRec.width + 4
     height: childSetsRec.height + 4
     radius: 17

     color: layoutIconColorActive

     MouseArea {
         anchors.fill: parent

         onClicked: {
             navBox.currentIndex = 4
         }
     }

            Rectangle {
                id: childSetsRec

                color: "white"


                width: freePrankText.width + 15 + setsIcon.width + 3
                height: setsIcon.height + 10

                anchors.centerIn: parent

                radius: 15

                AppImage {
                    id: setsIcon

                    source: "../../../../assets/icons/settings_final.svg"
                    width: 28
                    height: 28

                    anchors.left: parent.left
                    anchors.leftMargin: 5

                    anchors.verticalCenter: parent.verticalCenter


                    AppText {
                        id: freePrankText

                        text: qsTr("Ir a Ajustes")
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

    }
  }

  ScrollIndicator {
      flickable: scroller
  }

  DashLineColocator {
      anchors.bottom: parent.bottom
  }

}
