import QtQuick 2.0
import Felgo 3.0
import "../../../../../helper"

Page {

    id: myProfilePage

    title: qsTr("Mi Perfil")
    backgroundColor: pagesBackColorGrey

    property real marginCol: 25

    leftBarItem: GoBackButtonBarItem {
        id: backBtn
    }

    AppFlickable {
          id: scroller

          anchors.fill: parent

          contentWidth: parent.width
          contentHeight: contentColumn.height

          flickableDirection: Flickable.VerticalFlick

      Column {
          id: contentColumn
          anchors.left: parent.left
          anchors.right: parent.right
          anchors.top: parent.top
          anchors.topMargin: marginCol

          spacing: dp(10)

          Rectangle {
              id: avatarPersRec

              width: parent.width
              height: avatarRow.height + marginCol + 30

              radius: dp(35)

              anchors.left: parent.left
              anchors.right: parent.right

              anchors.leftMargin: dp(10)
              anchors.rightMargin: dp(10)


                Row {
                  id: avatarRow
                  spacing: 2

                  anchors.left: parent.left
                  anchors.right: parent.right
                  anchors.top: parent.top

                  anchors.margins: contentPadding


                  Rectangle {
                      id: subRec

                      color: dataModel.profileColors[avatarColorIndex]
                      radius: dp(20)
                      width: avatarRec.width + 7
                      height: avatarRec.height + 8

                      Rectangle {
                              id: avatarRec
                              anchors.centerIn: parent

                              color: pagesBackColor
                              radius: dp(20)
                              width: dp(130)
                              height: width

                              AppImage {
                                  id: avatar

                                  width: parent.width - dp(15)
                                  anchors.centerIn: parent
                                  fillMode: Image.PreserveAspectFit

                                  source: "../../../../../../assets/avatars/" + (gender == 0 ? "men" : "women") + "/"
                                          + avatarIconIndex + ".svg"

                                      AppButton {
                                          id: customBtn

                                          flat: true

                                          anchors.top: parent.bottom
                                          anchors.left: parent.left
                                          anchors.leftMargin: dp(7)
                                          anchors.topMargin: dp(27)

                                          width: parent.width
                                          text: "Personalizar"
                                          textSize: getTextSize(14)
                                          iconRight: IconType.pencil

                                          onClicked: {
                                              navigationStack.push(avatarSelectionComponent)
                                          }
                                      }
                                  }

                              Component.onCompleted: {
                                  if (isTablet) {
                                      avatarRec.width = avatarRec.width * 1.3
                                      customBtn.anchors.topMargin = dp(40)
                                  }
                              }
                      }
                  }

                  AppText {
                      width: parent.width - avatarRec.width

                      text: "Personaliza tu Avatar y el nombre de usuario público."

                      font.pixelSize: getTextSize(16)
                      color: Theme.listItem.detailTextColor

                      anchors.verticalCenter: parent.verticalCenter

                      wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                      leftPadding: dp(25)
                  }

            }
          }

             ListSeparator {
                 id: usernameSepartor


                 title: qsTr("Nombre de Usuario")
                 anchors.left: parent.left
                 anchors.right: parent.right

                 anchors.leftMargin: dp(20)
                 anchors.rightMargin: dp(20)
             }

             Row {
                 id: usernameRow

                 width: parent.width

                 anchors.left: parent.left
                 anchors.right: parent.right


                 anchors.leftMargin: dp(20)
                 anchors.rightMargin: dp(20)


                 spacing: 5

                 Rectangle {
                     id: atIconRect

                     width: atIcon.width + 4
                     height: atIcon.height + 4

                     color: "#EA5455"
                     radius: dp(10)

                     anchors.verticalCenter: parent.verticalCenter

                     Icon {
                        id: atIcon

                        icon: IconType.at
                        height: 20
                        width: 20
                        color: "white"

                        anchors.centerIn: parent

                        Component.onCompleted: {
                            atIcon.textItem.font.bold = true
                        }

                     }
                 }

                 // input
                 AppTextInput {
                   id: textInput
                   width: usernameRow.width - atIconRect.width - saveBtn.width - 10

                   placeholderText: qsTr("¿Cómo quieres llamarte?")
                   font.pixelSize: getTextSize(17, true)

                   // only allow letters and check length
                   validator: RegExpValidator {
                     regExp: /[A-Za-z0-9]+/
                   }

                   maximumLength: 18

                   onTextChanged: {
                       console.debug("[INFO] Username now: " + textInput.text)

                       if (textInput.text == "" || textInput.text == username)
                       {
                          saveBtn.canSave = false
                          return;
                       }

                       saveBtn.canSave = true
                   }

                   Component.onCompleted: {
                       textInput.text = username
                   }

                 }

                 SaveButtonBarItem {

                         id: saveBtn
                         handlerFunc: () => {
                             var cachedUsername = textInput.text

                             if (cachedUsername.length < 3)
                               {
                                   // Native dialog
                                   NativeDialog.confirm("Error", "El nombre de usuario debe de ser de al menos 3 carácteres.", function(){}, false)

                                  console.debug("[Warning] Invalid username: " + cachedUsername)
                                  return false
                               }



                             root.username = cachedUsername

                             textInput.deselect()
                             textInput.focus = false

                             console.debug("[Info] Updated username: " + cachedUsername)
                             return true
                         }

                         Component.onCompleted: {
                             saveBtn.registerBackButtonItem(backBtn, myProfilePage)
                         }
                     }

             }

      }

    }

    ScrollIndicator {
        flickable: scroller
    }

    Component {
        id: avatarSelectionComponent
        AvatarSelection {}
    }
}
