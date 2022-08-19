import QtQuick 2.0
import Felgo 3.0

AppText {
    id: copyText

    width: parent.width

    font.pixelSize: getTextSize(11)
    font.family: "Helvetica [Cronyx]"
    font.italic: true

    text: "© " + new Date().getFullYear().toString() + " - The Brothers"


    horizontalAlignment: Text.AlignHCenter
    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
    bottomPadding: dp(15)
}
