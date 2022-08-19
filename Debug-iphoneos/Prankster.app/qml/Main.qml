import Felgo 3.0
import QtQuick 2.0
import "pages"
import "helper"

App {
    id: app

    licenseKey: "667E31EFE21D078D6C1F01A2815E6316BF1D581CCEFB24ACC6261D053CE4BA2690994FE9F236E181364BFA5668B1A29A2567745AD05805F85B48F16B214D5C6E739585133C4871167B0F2956FF7ACBA699F65856CE52EC35615BB89F89212ED2B64C421FAB004441D4D940C116F58D4E17D4D54075E8A263728CD1D6FC1132D33B133441C80F22EFCFC4DBB90875FBFC2FCF4D4EF473F03972EFAA1CF89DAC050A3C6A538CDFCB538365A53BFBD6624B479CD033DF15D9136356C91F8E7B5D6D066FD4873636F017CCB8ECE692250ECD9E9FE8FB64DF1104B8E62C53BCE78CEE556A5FC4B05EB4B7E323751A5D67C0B170B3118622231985C27F8A914A24D2096E4FC26E0BCA89C919FE576E778496E16247E0053C3A81002E44D551C4B5E9BAA6E5CE01FCC32D9953A6E57F6EBC9E012151D122FCA37CA8198957625179EDF937F9FA6667073E713EA50AC346A7ADF2BCC7B7E628A1C0655344F9C3D1F7B163F77F827AAB087D326488199412D09F65D7E57F153BE8F79BB012D1B5B1C8C1BF2F557612F96773C507DB7E87F849DE0BDBA44E900F5ADDDD1433880BBFD76536ED91CAE678E34E34C516130A9BF16CD2F8936BE900BE476490388219F14B89EC80BBD9EA72F76ADC3BD11CEBB23DEED3EF138378EC7C3C90EA63F4ABCD540366B7F4FC5DD0D77325148236891692E791"

    property var serverUrl : "http://0.0.0.0:1300/"
    readonly property color pagesBackColorGrey: "#F1F1F6"

    property bool isTablet: false

    // It is hidden by default and will overlay the QML items below if shown
    /*
    PluginMainItem {
        id: pluginMainItem
        z: 1           // display the plugin example above other items in the QML code below
        visible: false // set this to true to show the plugin example

        // keep only one instance of these plugin-pages alive within app
        // this prevents crashes due to destruction of plugin items when popping pages from the stack
        property alias soomlaPage: soomlaPage

        SoomlaPage {
            id: soomlaPage
            visible: false
            onPushed: soomlaPage.listView.contentY = soomlaPage.listView.originY
            onPopped: { soomlaPage.parent = pluginMainItem; visible = false }
        }
    }
    */

   onInitTheme: {
       // Set custom color for Navigation object (Theme)

       Theme.navigationTabBar.iconSize = Theme.navigationTabBar.iconSize * 1.13
       Theme.navigationTabBar.textSize = 12
       Theme.listSection.backgroundColor = pagesBackColorGrey

       if (app.width > 450) {
           Theme.navigationTabBar.iconSize = Theme.navigationTabBar.iconSize * 1.25
           Theme.navigationTabBar.height = 60
           Theme.navigationTabBar.textSize = 14

           isTablet = true
       }
       // Tablet

       if (Theme.isIos) {
           return
       }

       Theme.navigationTabBar.backgroundColor = "#F0F0F0"
       Theme.navigationTabBar.titleOffColor = "#A8A8A8"
       Theme.navigationTabBar.titleColor = "#0381FF"
       Theme.navigationTabBar.dividerColor = "#B4C2C2"
       Theme.listSection.textColor = "#A8A8A8"
       Theme.listSection.fontBold = false
       Theme.listSection.fontCapitalization = Font.AllUppercase


   }

    PropertyCrossMainItem { } // Main initializator



}
