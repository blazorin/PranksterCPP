import QtQuick 2.0
import Felgo 3.0

AppButton {

    id: actionButton

    property alias minimumWidth: actionButton.minimumWidth

    property alias minimumHeight: actionButton.minimumHeight

    property alias textColor: actionButton.textColor

    property alias textColorPressed: actionButton.textColorPressed

    property alias textColorDisabled: actionButton.textColorDisabled

    property alias textSize: actionButton.textSize

    property alias iconSize: actionButton.iconSize

    property alias fontCapitalization: actionButton.fontCapitalization

    property alias fontBold: actionButton.fontBold

    property alias fontFamily: actionButton.fontFamily

    property alias textFont: actionButton.textFont

    property alias backgroundColor: actionButton.backgroundColor

    property alias backgroundColorPressed: actionButton.backgroundColorPressed

    property alias disabledColor: actionButton.disabledColor

    property alias borderColor: actionButton.borderColor

    property alias borderColorPressed: actionButton.borderColorPressed

    property alias borderColorDisabled: actionButton.borderColorDisabled

    property alias borderWidth: actionButton.borderWidth

    property alias radius: actionButton.radius

    property alias horizontalPadding: actionButton.horizontalPadding

    property alias verticalPadding: actionButton.verticalPadding

    property alias horizontalMargin: actionButton.horizontalMargin

    property alias verticalMargin: actionButton.verticalMargin

    property alias dropShadow: actionButton.dropShadow

    property alias flat: actionButton.flat

    property alias rippleEffect: actionButton.rippleEffect

    property alias pressed: actionButton.pressed

    property alias icon: actionButton.icon

    property alias textFormat: actionButton.textFormat

    property alias leftItem: actionButton.leftItem

    property alias rightItem: actionButton.rightItem

    property alias iconLeft: actionButton.iconLeft

    property alias iconRight: actionButton.iconRight

    property alias wordWrap: actionButton.wordWrap

    property alias text: actionButton.text

    property var onClickedCallback: ({})

    property int customVerticalPadding: 0

    property bool disabledColorRemoved: false

    Component.onCompleted: {
        actionButton.borderColor = actionButton.backgroundColor
        actionButton.textColorPressed = actionButton.textColor
        actionButton.borderColorPressed = actionButton.backgroundColorPressed

        if (!disabledColorRemoved)
            actionButton.disabledColor = actionButton.backgroundColorPressed
        else
            actionButton.disabledColor = actionButton.backgroundColor

        actionButton.borderColorDisabled = actionButton.disabledColor

        actionButton.radius = dp(10)
        actionButton.textFormat = Text.StyledText
        actionButton.flat = false

        if (customVerticalPadding != 0)
            actionButton.verticalPadding = customVerticalPadding
        else
            actionButton.verticalPadding = 13


        // Text size calculation
        actionButton.textSize = getTextSize(actionButton.textSize)

        if (actionButton.width > 450) {

            actionButton.width = 450
            verticalPadding = 12

        }

    }
}
