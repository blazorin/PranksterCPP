import QtQuick 2.0
import Felgo 3.0

Page {

    property var model: null


    title: qsTr("Encounter details")

    clip: true

    Flickable {
        id: scroller
        anchors.fill: parent
        contentWidth: parent.width
        contentHeight: contentCol.height + contentPadding
        bottomMargin: contentPadding

        Column {
            id: contentCol

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: contentPadding
            spacing: dp (30)

            AppText {
                text: model.price_formatted
                width: parent.width
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                font.pixelSize: sp(28)
            }

            AppText {
                text: model.title
                width: parent.width
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                font.pixelSize: sp(18)
            }

            AppImage {
                source: model.img_url
                width: parent.width
                height: model && width * model.img_height / model.img_width || 0 // Proporcional correcto
                anchors.horizontalCenter: parent.horizontalCenter
            }

            AppText {
                text: qsTr("%1 beds and %2 bathrooms").arg(model.bedroom_number).arg(model.bathroom_number)
                width: parent.width
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            }

            AppText {
                text: model.summary
                width: parent.width
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            }
        }

        ScrollIndicator {
            flickable: scroller
        }
    }
}
