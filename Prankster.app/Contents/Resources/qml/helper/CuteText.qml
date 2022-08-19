import QtQuick 2.0
import Felgo 3.0

AppText {
    id: cuteText

    property alias text: cuteText.text

    property int customFontSize: 0

    color: Theme.listSection.textColor

    Component.onCompleted: {
        if (customFontSize == 0)
            cuteText.fontSize = getTextSize(Theme.listSection.fontSize + 2)
        else
            cuteText.fontSize = getTextSize(customFontSize)

        ////cuteText.fontSize = cuteText.fontSize + getTextSize(5)
    }
}
