import QtQuick 2.0
import Felgo 3.0


ListPage {

    id: listPageWrapper

    property var scrollPos: null
    property bool favouritesEnabled

    property bool loading

    rightBarItem: ActivityIndicatorBarItem {
        visible: HttpNetworkActivityIndicator.enabled
    }

    model: JsonListModel {
        id: listModel

        source: dataModel.listings
        fields: ["text", "detailText", "image", "model"]

    }

    title: qsTr("%1 of %2 encounters").arg(dataModel.listings.length).arg(dataModel.numTotalListings)

    Component.onCompleted: {
        loading = true

        logic.requestListings()
        loading = false
    }

    emptyText.text: qsTr("No listings available")

    delegate: SimpleRow {
        item: listModel.get(index)
        autoSizeImage: true

        imageMaxSize: dp(80)
        image.fillMode: Image.PreserveAspectCrop

        onSelected: navigationStack.popAllExceptFirstAndPush(detailPageComponent, {model: item.model})

    }

    listView.footer: VisibilityRefreshHandler {
        visible: dataModel.listings.length < dataModel.numTotalListings

        onRefresh: {
            scrollPos = listView.getScrollPosition()
            logic.requestListings()
        }
    }

    Component {
        id: detailPageComponent
        ListingDetailPage {}
    }

}
