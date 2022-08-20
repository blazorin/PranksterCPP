import QtQuick 2.0
import Felgo 3.0

Row {
    id: featureRow

    property alias boldText: boldTextElem.text
    property alias mainText: mainText.text

    // Visibility
    property alias boldTextVisible: boldTextElem.visible

    property alias boldTextLeftPadding: boldTextElem.leftPadding
    property alias mainTextLeftPadding: mainText.leftPadding

    // Icon
    property alias icon: iconElem.icon
    property alias iconColor: iconElem.color


    property int textSizeInt: 0

    spacing: 0

    //anchors.horizontalCenter: parent.horizontalCenter

    /*
    AppImage {
       source: "../../../../../../assets/subscription/checkbox.svg"

       width: (!isTablet ? (dp(32)) : (dp(64)))
       //anchors.horizontalCenter: parent.horizontalCenter
       fillMode: Image.PreserveAspectFit

       anchors.verticalCenter: parent.verticalCenter

    }
    */


 Icon {

       id: iconElem

       //icon: IconType.phone
       size: mainText.height * 1.3

       //color: "#EC7063"

       }


    AppText {
        id: boldTextElem

        topPadding: dp(3)

        wrapMode: Text.WrapAtWordBoundaryOrAnywhere

        anchors.verticalCenter: parent.verticalCenter

        //text: qsTr(dataModel.getSubscriptionLottie().dailyPranks +  " ")
        font.pixelSize: getTextSize(textSizeInt, true)

        font.bold: true

        leftPadding: 12
    }

    AppText {
        id: mainText

        topPadding: dp(3)
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere

        anchors.verticalCenter: parent.verticalCenter

        //text: qsTr("bromas diarias")
        font.pixelSize: getTextSize(textSizeInt, true)

        leftPadding: boldTextVisible ? 5 : 10
    }

    Component.onCompleted: {
        if (textSizeInt == 0)
            textSizeInt = 19

    }
}
