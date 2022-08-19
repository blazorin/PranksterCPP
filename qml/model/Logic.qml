import QtQuick 2.0
import Felgo 3.0

Item {

    signal demoSignal(string demoText)
    signal demoSignalWithCallback(string demoText, var callback)

    signal requestListings()
}
