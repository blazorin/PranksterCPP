import QtQuick 2.0
import Felgo 3.0

AppListItem {
    id: listSwitch

     property alias text: listSwitch.text
     property alias dividerLeftSpacing: listSwitch.dividerLeftSpacing

     // Valor por defecto
     property bool switchEnabled: false


     property var onSwitch: ({})
     property alias switcher: switcher // allow access to this child element from outside

     textFontSize: getTextSize(16)
     detailTextFontSize: getTextSize(12)

     showDisclosure: false

     rightItem: AppSwitch {
         id: switcher

         anchors.verticalCenter: parent.verticalCenter

         backgroundColorOn: "#34C759"
         backgroundColorOnPressed: "#35D15C"

        onEnabledChanged: {
            if (switcher.enabled)
                switcher.backgroundColorOn = "#34C759"
            else
               switcher.backgroundColorOn = "#5BDE7C"
        }


         onToggled: {
             onSwitch(switcher.checked)
             console.debug("Switch: " + listSwitch.text + " => " + switcher.checked)
         }
     }

     Component.onCompleted: {
         if (switchEnabled)
             switcher.checked = true
         else
             switcher.checked = false
     }

     function toggleSwitch() {
         switcher.toggle()
     }

}
