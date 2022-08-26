import QtQuick 2.0
import Felgo 3.0
import "../../../../../helper"


Page {
    id: avatarSelectionPage

    title: "Elegir Avatar"
    backgroundColor: pagesBackColorGreyExtra

    rightBarItem: SaveButtonBarItem {
        id: saveBtn
        handlerFunc: () => {
            return true
        }

        Component.onCompleted: {
            saveBtn.registerBackButtonItem(backBtn, avatarSelectionPage)
        }
    }

    leftBarItem: GoBackButtonBarItem {
        id: backBtn
    }

    property real marginCol: 25

    property int tempAvatarColorIndex: avatarColorIndex
    property int tempAvatarIconIndex: avatarIconIndex
    property int tempGender: gender

    property real cachedMenX: -5
    property real cachedWomenX: -5

    property int cachedMenAvatarIconIndex: (tempGender == 0 ? tempAvatarIconIndex : 0)
    property int cachedWomenAvatarIconIndex: (tempGender == 1 ? tempAvatarIconIndex : 0)

    AppFlickable {
          id: scroller

          anchors.fill: parent

          contentWidth: parent.width
          contentHeight: contentColumn.height + (marginCol * 2)

          flickableDirection: Flickable.VerticalFlick
    Column {
        id: contentColumn
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: marginCol
        spacing: dp(30)

        Rectangle {
            id: mainRec

            width: avatarRec.width + marginCol + 20
            height: avatarRec.height + marginCol + 20
            anchors.horizontalCenter: parent.horizontalCenter

            radius: dp(35)

            Rectangle {
                id: subRec
                anchors.centerIn: parent

                color: dataModel.profileColors[tempAvatarColorIndex]
                radius: dp(20)
                width: avatarRec.width + 7
                height: avatarRec.height + 8

                Rectangle {
                    id: avatarRec
                    anchors.centerIn: parent

                        color: pagesBackColor
                        radius: dp(20)
                        width: dp(155)
                        height: width

                        AppImage {
                            id: avatar

                            width: parent.width - dp(15)
                            anchors.centerIn: parent
                            fillMode: Image.PreserveAspectFit

                            source: "../../../../../../assets/avatars/" + (tempGender == 0 ? "men" : "women") + "/"
                                    + (tempGender == 0 ? cachedMenAvatarIconIndex : cachedWomenAvatarIconIndex) + ".svg"

                            }
                        Component.onCompleted: {
                            if (isTablet) {
                                avatarRec.width = avatarRec.width * 1.3
                            }
                        }
                    }
            }
        }

        /** Start Back selector scroller **/

        AppText {
            width: parent.width

            color: Theme.listItem.detailTextColor
            font.pixelSize: getTextSize(16)

            text: qsTr("Color de fondo")

            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            bottomPadding: dp(7)

            SeparatorLine {
                width: parent.width - contentPadding * 3
                height: 1

                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
            }
           }

        Rectangle {
            id: colorSelectorRec
            width: parent.width - contentPadding * 4
            height: 40
            radius: dp(10)


            anchors.horizontalCenter: parent.horizontalCenter

            Component.onCompleted: {
                if (isTablet) {
                    colorSelectorRec.width = colorSelectorRec.width - contentPadding * 4
                }
            }

             AppFlickable {

                 leftMargin: 4

                 width: parent.width
                 height: parent.height

                 contentWidth: (dataModel.profileColors.length * (25 + 4 + colorsRow.spacing)) - 6
                 contentHeight: height

                 flickableDirection: Flickable.HorizontalFlick

                    Row {
                        id: colorsRow

                        width: parent.width
                        anchors.verticalCenter: parent.verticalCenter

                        spacing: dp(20)

                        Repeater {
                            model: dataModel.profileColors

                            Rectangle {
                                width: colorRec.width + 4
                                height: colorRec.height + 4
                                radius: 15

                                color: (tempAvatarColorIndex === index ? "#43BADD" : "white")
                                Rectangle {
                                    id: colorRec

                                    width: 25
                                    height: 25
                                    color: dataModel.profileColors[index]

                                    anchors.centerIn: parent
                                    radius: 15
                                }

                                MouseArea {
                                    anchors.fill: parent

                                    onClicked: {

                                        tempAvatarColorIndex = index
                                        enableSaveBtn()

                                        console.debug("Selected avatar color: " + index)

                                    }
                                }
                            }
                        }
                    }
                }
    }


        /** End Back selector scroller **/

        AppText {
            width: parent.width

            color: Theme.listItem.detailTextColor
            font.pixelSize: getTextSize(16)

            text: qsTr("Género")

            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            bottomPadding: dp(7)

            SeparatorLine {
                width: parent.width - contentPadding * 3
                height: 1

                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
            }
           }

           Row {
               width: parent.width - contentPadding * 5
               anchors.horizontalCenter: parent.horizontalCenter

               spacing: 2

               ActionButton {
                 id: manBtn

                 width: parent.width / 2
                 enabled: tempGender != 0

                 text: qsTr("Hombre")

                 textSize: 12

                 textColor: "#FFFFFF"
                 textColorDisabled: "#ECEFF2"
                 backgroundColor: "#047AFF"
                 backgroundColorPressed: "#21A2F6" // Pressed/disabled background color
                 fontBold: true

                 onClicked: {
                     if (!manBtn.enabled)
                         return

                     tempGender = 0
                     avatarScroller.contentX = cachedMenX

                     enableSaveBtn()
                 }

                 //anchors.horizontalCenter: parent.horizontalCenter
               }

               ActionButton {
                 id: womenBtn

                 width: parent.width / 2
                 enabled: tempGender != 1

                 text: qsTr("Mujer")

                 textSize: 12

                 textColor: "#FFFFFF"
                 textColorDisabled: "#ECEFF2"
                 backgroundColor: "#F222F5"
                 backgroundColorPressed: "#F470F6" // Pressed/disabled background color
                 fontBold: true

                 //anchors.horizontalCenter: parent.horizontalCenter

                 onClicked: {
                     if (!womenBtn.enabled)
                         return

                     tempGender = 1
                     avatarScroller.contentX = cachedWomenX

                     enableSaveBtn()
                 }
               }
           }

           // Start Avatar Selector

           Rectangle {
               id: avatarSelectorRec
               width: parent.width - contentPadding * 4
               height: 100
               radius: dp(10)


               anchors.horizontalCenter: parent.horizontalCenter

               Component.onCompleted: {
                   if (isTablet) {
                       avatarSelectorRec.width = avatarSelectorRec.width - contentPadding * 4
                   }
               }

                AppFlickable {
                    id: avatarScroller

                    leftMargin: 4

                    width: parent.width
                    height: parent.height

                    contentWidth: ((tempGender == 0 ? dataModel.menAvatarsIndexes : dataModel.womenAvatarsIndexes) * (65 + 12 + avatarsRow.spacing)) - 6
                    contentHeight: height

                    flickableDirection: Flickable.HorizontalFlick

                       Row {
                           id: avatarsRow

                           width: parent.width
                           anchors.verticalCenter: parent.verticalCenter

                           spacing: dp(20)

                           Repeater {
                               model: (tempGender == 0 ? dataModel.menAvatarsIndexes : dataModel.womenAvatarsIndexes) // Amount of avatars for each gender

                               Rectangle {
                                   width: avatarElemRec.width + 12
                                   height: avatarElemRec.height + 12
                                   radius: 20

                                   color: ((tempGender == 0 ? (cachedMenAvatarIconIndex === index) :
                                                          (cachedWomenAvatarIconIndex) === index ) ? "#EDEDED" : "white")
                                   AppImage {
                                       id: avatarElemRec

                                       width: 65
                                       height: 65

                                       fillMode: Image.PreserveAspectFit
                                       source: "../../../../../../assets/avatars/" + (tempGender == 0 ? "men" : "women") + "/" + index + ".svg"

                                       anchors.centerIn: parent
                                   }

                                   MouseArea {
                                       anchors.fill: parent

                                       onClicked: {

                                           tempAvatarIconIndex = index

                                           if (tempGender == 0) {
                                               cachedMenAvatarIconIndex = index
                                               cachedMenX = avatarScroller.contentX
                                           }
                                           else {
                                               cachedWomenAvatarIconIndex = index
                                               cachedWomenX = avatarScroller.contentX
                                           }

                                           enableSaveBtn()
                                           console.debug("Selected avatar icon: " + index)

                                       }
                                   }
                               }

                               Component.onCompleted: {

                                   // Remove properties lambdas
                                   removePropertiesLambdas()
                               }
                           }
                       }
                   }
               }

               // End Avatar Selector

        }

        ScrollIndicator {
            flickable: scroller
        }
    }

    function removePropertiesLambdas() {

        if (tempGender == 0) {
            cachedWomenAvatarIconIndex = 0
            cachedMenAvatarIconIndex = tempAvatarIconIndex
        }
        else {
            cachedMenAvatarIconIndex = 0
            cachedWomenAvatarIconIndex = tempAvatarIconIndex
        }

    }

    function enableSaveBtn() {
        saveBtn.canSave = true
    }
}
