import QtQuick 2.0
import Felgo 3.0

SimpleSection {

    id: section

    property alias title: section.title
    property alias style: section.style

    Component.onCompleted: {
        section.height = section.height / 1.4
    }
}
