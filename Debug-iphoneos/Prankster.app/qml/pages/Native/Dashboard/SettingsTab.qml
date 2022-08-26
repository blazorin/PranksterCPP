import QtQuick 2.0
import Felgo 3.0
import "../../../helper"
import "Settings/Profile"
import "Settings/Community"
import "Settings/Account"
import "Settings/Payments"

Page {

    title: "Settings"
    backgroundColor: pagesBackColorGrey

    navigationBarHidden: true
    backNavigationEnabled: false // important

  AppFlickable {
        id: scroller

        anchors.fill: parent

        contentWidth: parent.width
        contentHeight: settingsColumn.height + topTitleMarginBig

        flickableDirection: Flickable.VerticalFlick

    Column {
        id: settingsColumn
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: topTitleMarginBig


        AppText {
            id: headerText

            width: parent.width
            leftPadding: contentPadding
            bottomPadding: 10

            text: "Ajustes"
            fontSize: getTextSize(45)
            font.bold: true

            Component.onCompleted: {
                // iPear 5
                let deviceModel = nativeUtils.deviceModel()

                if (deviceModel === "iPhone5,1" || deviceModel === "iPhone5,2" || deviceModel === "iPhone5,3" || deviceModel === "iPhone5,4")
                    headerText.fontSize = getTextSize(35)

            }
        }

        /** Content **/

        AppListItem {
            id: profileItem

             text: qsTr("Mi Perfil")

             leftItem: Rectangle {

                 id: subRec

                 color: dataModel.profileColors[avatarColorIndex]
                 radius: dp(15)
                 width: avatarRec.width + 4
                 height: avatarRec.height + 4

                 anchors.verticalCenter: parent.verticalCenter

                     Rectangle {
                            id: avatarRec
                            anchors.centerIn: parent

                            color: pagesBackColor
                            radius: dp(15)
                            width: dp(60)
                            height: width

                        AppImage {
                            width: parent.width - dp(15)
                            anchors.centerIn: parent
                            fillMode: Image.PreserveAspectFit

                            source: "../../../../assets/avatars/" + (gender == 0 ? "men" : "women") + "/"
                                    + avatarIconIndex + ".svg"
                            }
                          }
             }

             dividerLeftSpacing: 0

             Component.onCompleted: {
                 profileItem.height = profileItem.height * 1.9

                 if (isTablet)
                     profileItem.textFontSize = sp(24)
                 else
                     profileItem.textFontSize = sp(18)
             }

             onSelected: {
                 navStack.push(myProfileComponent)
             }


             Rectangle {

                 width: parent.width
                 height: 1

                 anchors.bottom: parent.top

                 color: separatorColor
             }
        }

        ListSeparator { title: qsTr("Comunidad")}

        AppListItem {
             text: qsTr("Visibilidad")
             textFontSize: getTextSize(15)


             leftItem: Rectangle {
                        color: "#44A4E5"
                        radius: dp(5)
                        width: dp(26)
                        height: width
                        anchors.verticalCenter: parent.verticalCenter

                        Icon {
                          icon: IconType.eye
                          anchors.centerIn: parent
                          color: "white"
                        }
                      }

             onSelected: {
                 navStack.push(communityVisibilityComponent)
             }
        }

        AppListItem {
             text: qsTr("Privacidad")

             textFontSize: getTextSize(15)


             leftItem: Rectangle {
                        color: "grey"
                        radius: dp(5)
                        width: dp(26)
                        height: width
                        anchors.verticalCenter: parent.verticalCenter

                        Icon {
                          icon: IconType.usersecret
                          anchors.centerIn: parent
                          color: "white"
                        }
                      }

             onSelected: {
                 navStack.push(communityPrivacyComponent)
             }

             dividerLeftSpacing: 0
        }

         ListSeparator { title: qsTr("Cuenta")}

         AppListItem {
              text: qsTr("Datos")
              textFontSize: getTextSize(15)


              leftItem: Rectangle {
                         color: "#F39C12"
                         radius: dp(5)
                         width: dp(26)
                         height: width
                         anchors.verticalCenter: parent.verticalCenter

                         Icon {
                           icon: IconType.user
                           anchors.centerIn: parent
                           color: "white"
                         }
                       }

              rightItem: RedBubble {
                  width: dp(23)
                  height: dp(23)
                  radius: dp(15)

                  bubbleText: "!"
                  visible: (root.email.length === 0)

                  customColor: "#F9B623"

                  anchors.verticalCenter: parent.verticalCenter
              }

              onSelected: {
                  navStack.push(accountDataComponent)
              }
         }

         AppListItem {
              text: qsTr("Cuentas Vinculadas")
              textFontSize: getTextSize(15)


              leftItem: Rectangle {
                         color: "#EC7063"
                         radius: dp(5)
                         width: dp(26)
                         height: width
                         anchors.verticalCenter: parent.verticalCenter

                         Icon {
                           icon: IconType.chain
                           anchors.centerIn: parent
                           color: "white"
                         }
                       }

              rightItem: RedBubble {
                  width: dp(23)
                  height: dp(23)
                  radius: dp(15)

                  bubbleText: "!"
                  visible: !root.isThisDeviceLinked

                  anchors.verticalCenter: parent.verticalCenter
              }

             dividerLeftSpacing: 0

             onSelected: {
                 navStack.push(linkedAccountsComponent)
             }
         }


         ListSeparator { title: qsTr("Pagos")}

         AppListItem {
              text: qsTr("Compras In-App")
              textFontSize: getTextSize(15)


              leftItem: Rectangle {
                         color: "#2ECC71"
                         radius: dp(5)
                         width: dp(26)
                         height: width
                         anchors.verticalCenter: parent.verticalCenter

                         Icon {
                           icon: IconType.dollar
                           anchors.centerIn: parent
                           color: "white"
                         }
                       }

              onSelected: {
                  navStack.push(inAppPurchasesComponent)
              }
         }

         AppListItem {
              text: qsTr("Subscripción")
              textFontSize: getTextSize(15)


              leftItem: Rectangle {
                         color: "#F0BF5F"
                         radius: dp(5)
                         width: dp(26)
                         height: width
                         anchors.verticalCenter: parent.verticalCenter

                         Icon {
                           icon: IconType.starhalffull
                           anchors.centerIn: parent
                           color: "white"
                         }
                       }

              onSelected: {
                  navStack.push(subscriptionsSettingsExternalComponent)
              }
         }

         AppListItem {
              text: qsTr("Subscripción store")
              textFontSize: getTextSize(15)


              leftItem: Rectangle {
                         color: "#F0BF5F"
                         radius: dp(5)
                         width: dp(26)
                         height: width
                         anchors.verticalCenter: parent.verticalCenter

                         Icon {
                           icon: IconType.staro
                           anchors.centerIn: parent
                           color: "white"
                         }
                       }

              onSelected: {
                  navStack.push(subscriptionsStoreExternalComponent)
              }
         }


         AppListItem {
              text: qsTr("Canjear código")
              textFontSize: getTextSize(15)


              leftItem: Rectangle {
                         color: "#E179EA"
                         radius: dp(5)
                         width: dp(26)
                         height: width
                         anchors.verticalCenter: parent.verticalCenter

                         Icon {
                           icon: IconType.gift
                           anchors.centerIn: parent
                           color: "white"
                         }
                       }

             dividerLeftSpacing: 0
         }

         ListSeparator { title: qsTr("Bromas")}

         AppListItem {
              text: qsTr("Preferencias")
              textFontSize: getTextSize(15)


              leftItem: Rectangle {
                         color: "#EC7063"
                         radius: dp(5)
                         width: dp(26)
                         height: width
                         anchors.verticalCenter: parent.verticalCenter

                         Icon {
                           icon: IconType.phone
                           anchors.centerIn: parent
                           color: "white"
                         }
                       }
         }

         AppListItem {
              text: qsTr("Número Saliente (PRO)")
              textFontSize: getTextSize(15)


              leftItem: Rectangle {
                         color: "#474247"
                         radius: dp(5)
                         width: dp(26)
                         height: width
                         anchors.verticalCenter: parent.verticalCenter

                         Icon {
                           icon: IconType.bolt
                           anchors.centerIn: parent
                           color: "#F1C40F"
                         }
                       }

             dividerLeftSpacing: 0
         }


         ListSeparator { title: qsTr("Redes")}

         AppListItem {
              text: qsTr("Instagram")
              textFontSize: getTextSize(15)


              leftItem: AppImage {
                      width: dp(26)
                      anchors.verticalCenter: parent.verticalCenter

                      fillMode: Image.PreserveAspectFit

                      source: "../../../../assets/social/instagram_2.svg"
                  }
         }

         AppListItem {
              text: qsTr("YouTube")
              textFontSize: getTextSize(15)




              leftItem:

                      AppImage {
                          width: dp(26)
                          anchors.verticalCenter: parent.verticalCenter

                          fillMode: Image.PreserveAspectFit

                          source: "../../../../assets/social/youtube_4.svg"
                      }




             dividerLeftSpacing: 0
         }


         ListSeparator { title: qsTr("Más")}

         AppListItem {
              text: qsTr("Información y Ayuda")
              textFontSize: getTextSize(15)


              leftItem: Rectangle {
                         color: "#037BFC"
                         radius: dp(5)
                         width: dp(26)
                         height: width
                         anchors.verticalCenter: parent.verticalCenter

                         Icon {
                           icon: IconType.info
                           anchors.centerIn: parent
                           color: "white"
                         }
                       }
         }

         AppListItem {
              text: qsTr("Invita a un amigo")
              textFontSize: getTextSize(15)


              leftItem: Rectangle {
                         color: "#FE2C55"
                         radius: dp(5)
                         width: dp(26)
                         height: width
                         anchors.verticalCenter: parent.verticalCenter

                         Icon {
                           icon: IconType.heart
                           anchors.centerIn: parent
                           color: "white"
                         }
                       }

             dividerLeftSpacing: 0
         }

        // Separador Final
        ListSeparator {
            title: qsTr("")

            Component.onCompleted: {
               style.compactStyle = true // Evitar doble linea separadora
            }
        }

      }

    }

     ScrollIndicator {
         flickable: scroller
     }

    Rectangle {
        id: rect

        width: parent.width
        height: 1

        anchors.bottom: parent.bottom

        color: separatorColor

        visible: Theme.isAndroid // Only for Android
    }

    /** Componentes **/

    Component {
        id: myProfileComponent

        MyProfile {}
    }

    Component {
        id: communityVisibilityComponent

        Visibility {}
    }

    Component {
        id: communityPrivacyComponent

        Privacy {}
    }

    Component {
        id: accountDataComponent

        AccountData {}
    }

    Component {
        id: linkedAccountsComponent

        LinkedAccounts {}
    }

    Component {
        id: inAppPurchasesComponent

        InAppPurchases {}
    }
}
