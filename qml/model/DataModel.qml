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

    // ProfileColors
    property var profileColors: ["#FA8072", "#F08080", "#E74C3C", "#DC143C", "#FF7F50", "#FF8C00", "#FFA500", "#FFD700",
        "#9370DB", "#8A2BE2", "#6A5ACD", "#EE82EE", "#FF00FF", "#3CB371", "#32CD32", "#00FF7F", "#00FA9A",
        "#98FB98", "#00BFFF", "#1E90FF", "#40E0D0", "#808080", "#696969"]

    property int menAvatarsIndexes: 31
    property int womenAvatarsIndexes: 20

    // Subcription Lotties data:
    property var subscriptionLotties: [

        {   height: 256,
            width: 256,
            name: "free",

            title: "Sin Subscripción",
            color: "#35CD79",

            dailyPranks: "0",
            rewardsMultiplier: "1",

            leftMargin: 20,
            rightMargin: 20
        },
        {
            height: 206,
            width: 370,
            name: "premium",

            title: "Premium",
            color: "#FDBA23",

            dailyPranks: "5",
            rewardsMultiplier: "2",

            leftMargin: 25,
            rightMargin: 15
        },
        {
            height: 246,
            width: 225,
            name: "unlimited",

            title: "Unlimited",
            color: "#A840FF",

            dailyPranks: "∞",
            rewardsMultiplier: "3",

            leftMargin: 0,
            rightMargin: 15
        }

    ]

    property var communityFeatures: ["¡Bienvenido a la Comunidad!", "¡Escucha bromas de otros y comparte las tuyas!", "Prankster es algo más\n que otra app de bromas.\n\nYa te lo habíamos dicho."]

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

    function getSubscriptionLottie(subscriptionKindToGet)
    {
        return subscriptionLotties[subscriptionKindToGet]
    }

}
