import QtQuick 2.0
import Felgo 3.0
import "pages/Native"
import "model"

// Many logic here

Item {

    id: root

// SETTINGS:

    // Auth properties
    property string bearerToken: ""
    property string serverUserId: ""

    property int accountId: 0

    property string username: ""

    property int subscriptionKind: 1
    property string subscriptionEndDate: (new Date().toLocaleDateString('es-ES'))

    property int avatarColorIndex: 0
    property int avatarIconIndex: 0

    property int gender: 0


    // Community

        // Visibility
        property bool hideExplicit: false
        property bool disableCommunity: false

        // Privacy
        property bool hidePubs: false
        property bool incognitoMode: false

    // Account

        // Data
        property string email: ""
        property bool receiveEmailPromos: true


        // Linking
        property bool isThisDeviceLinked: false

    // Pranks

        // Preferences
        property bool sharePranksAuto: false

        // Outgoing Number
        property string outgoingNumber: ""


// END SETTINGS

    anchors.fill: parent

    // Global
    property real animatedHeight: dp(400)

    Logic {
        id: logic
    }

    DataModel {
        id: dataModel
        dispatcher: logic
    }

    CppHelper {
        id: cppHelper
    }

    PropertyCrossMainPage {

    }

}
