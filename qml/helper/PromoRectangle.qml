import QtQuick 2.0
import Felgo 3.0

Rectangle {

    id: rect

    property alias text: freePrankText.text
    property alias textElem: freePrankText

    property alias textColor: freePrankText.color
    property alias bgColor: rect.color

    property bool bold: false
    property int textSizeInt: 0

    width: freePrankText.width + 15
    height: freePrankText.height + 15

    Component.onCompleted: {
        if (textSizeInt == 0)
            textSizeInt = 12

        if (radius == 0)
            radius = 15
    }


    AppText {
        id: freePrankText

        anchors.centerIn: parent

        font.pixelSize: getTextSize(textSizeInt)
        font.bold: bold

    }
}
