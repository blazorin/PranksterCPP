import QtQuick 2.0
import Felgo 3.0
import "pages/Native"
import "model"

// Many logic here

Item {

    id: root

    // Auth properties
    property string bearerToken: ""
    property string serverUserId: ""

    property int subscriptionKind: 0
    property string subscriptionEndDate: ""

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
