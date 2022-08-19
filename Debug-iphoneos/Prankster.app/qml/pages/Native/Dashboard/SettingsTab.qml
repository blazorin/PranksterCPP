import QtQuick 2.0
import Felgo 3.0
import "../../../helper"

Page {

    title: "Search Switch"
    backgroundColor: (!onGreyTonePage ? pagesBackColor : pagesBackColorGrey)

    navigationBarHidden: true
    backNavigationEnabled: false // important

  AppFlickable {

         width: parent.width
         height: contentHeight

         contentHeight: (Theme.isAndroid ? (parent.height - 1) : parent.height)

         flickableDirection: Flickable.VerticalFlick

    Column {
        id: headerColumn
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 60

        AppText {
            id: headerText

            width: parent.width
            leftPadding: contentPadding
            bottomPadding: 10

            text: "Ajustes"
            fontSize: getTextSize(45)
            font.bold: true
        }

        /** Content **/

        AppListItem {
            id: profileItem

             text: qsTr("Mi perfil")

             leftItem: Rectangle {
                        color: pagesBackColor
                        radius: dp(20)
                        width: dp(60)
                        height: width
                        anchors.verticalCenter: parent.verticalCenter

                    AppImage {
                        width: parent.width - dp(15)
                        anchors.centerIn: parent
                        fillMode: Image.PreserveAspectFit

                        source: "../../../../assets/avatars/0.svg"
                        }
                      }

             Component.onCompleted: {
                 profileItem.height = profileItem.height * 2

                 if (isTablet)
                     profileItem.textFontSize = sp(24)
                 else
                     profileItem.textFontSize = sp(18)
             }
        }

        ListSeparator { title: "Community"}

        AppListItem {
             text: "First"
             rightText: "Longer rightText, really long"


             leftItem: Rectangle {
                        color: "grey"
                        radius: dp(5)
                        width: dp(26)
                        height: width
                        anchors.verticalCenter: parent.verticalCenter

                        Icon {
                          icon: IconType.cog
                          anchors.centerIn: parent
                          color: "white"
                        }
                      }
        }

        AppListItem {
             text: "First"
             rightText: "Longer rightText, really long"
        }

        AppListItem {
             text: "First"
             rightText: "Longer rightText, really long"
        }

      }
    }

    Rectangle {
        id: rect

        width: parent.width
        height: 1

        anchors.bottom: parent.bottom

        color: "#BCC9C9"

        visible: Theme.isAndroid // Only for Android
    }

}
