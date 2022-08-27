import QtQuick 2.0
import Felgo 3.0

// Start Dash Line Helper
Rectangle {
    id: dashLineHelper

    width: 25
    height: 25

    radius: 15
    color: "black"
    visible: false

    //anchors.bottom: componenToAttach.bottom


    Component.onCompleted: {
        dashLineTimer.running = true // Start timer
    }

    Timer {
        id: dashLineTimer

        running: false
        repeat: true
        interval: 100
        triggeredOnStart: true

        onTriggered: {
            lineCenterRec.y = dashLineHelper.y + (dashLineHelper.height / 2.6)

            if (dashLayout.safeArea.height != dashLayout.height)
                lineCenterRec.y -= 1
        }
    }

}

// End Dash Line Helper
