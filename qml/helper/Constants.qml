pragma Singleton

import QtQuick 2.0

Item {

    // AdMob
    readonly property string admobBannerAdUnitId: "ca-app-pub-9155324456588158/9913032020"
    readonly property string admobInterstitialAdUnitId: "ca-app-pub-9155324456588158/9075427220"
    readonly property var admobTestDeviceIds: [ "d17ba18ff075e7c20c5ce081813d9666", "28CA0A7F16015163A1C70EA42709318A" ]

    // OneSignal
    readonly property string oneSignalAppId: "a23e646c-0d6f-4611-836e-5bf14ee96e98"
    readonly property string oneSignalGoogleProjectNumber: "522591647137"

    // Soomla
    property string soomlaSecret: "<your-game-secret>"
    property string soomlaAndroidPublicKey: "<android-public-key>"
    property string creditsCurrencyItemId: "net.vplay.demos.PluginDemo.credits"
    property string creditsPackItemId: "net.vplay.demos.PluginDemo.creditspack"
    property string goodieItemId: "net.vplay.demos.PluginDemo.goodie"
    property string noAdsItemId: "net.vplay.demos.PluginDemo.noads"

    // GameCenter
    property string gcLeaderboardID: "leaderboard_main"
    property string gcAchievementID: "achievement_1"

    // Facebook
    property string facebookAppId: "1014223965320966"

    // Amplitude
    readonly property string amplitudeApiKey: "47f92e5a607264e66bffa4aa3c94ce2a"
}
