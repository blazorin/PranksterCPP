import QtQuick 2.0
import Felgo 3.0
import "../pages/Native"

Item {


    property alias dispatcher: logicConnection.target
    property bool loading

    property var listings: []
    property int numTotalListings
    property int currentPage: 1

    // Welcome Pages feature texts
    property var welcomeFeatures: ["Selecciona una broma", "Selecciona un contacto", "Nosotros hacemos la llamada", "Escúchala en directo mientras se graba", "¿Listo para ser un Prankster?"]
    //property int cachedWelcomTextY: 0

    // Conectar signals
    Connections {
        id: logicConnection

        onDemoSignal: (text) => {
           console.debug("Hello from DemoSignal: " + text)
        }

        onDemoSignalWithCallback: (text, callback) => {
           console.debug("Hello from DemoSignal: " + text)

           callback("OK")
        }

        onRequestListings: {
            var requestRaw = httpClient.webRequest("https://my-json-server.typicode.com/lukasz-felgo/property-cross/db", 0, "");

            var obj = JSON.parse(requestRaw)

            if (obj.response === null || obj.response.listings === null)
                return

            listings = mapListingsToListingsModel(obj.response.listings)
            numTotalListings = obj.response.total_results

        }
    }

    function mapListingsToListingsModel(source) {
        return source.map(function(data) {
                return {
                    text: data.price_formatted,
                    detailText: data.title,
                    image: data.thumb_url,
                    model: data
                }
            }
        )
    }

}
