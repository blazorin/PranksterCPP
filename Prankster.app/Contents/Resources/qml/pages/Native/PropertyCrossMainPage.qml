import QtQuick 2.0
import QtQuick.Controls 1.2
import Felgo 3.0
import "Dashboard/Settings/Payments"
import "Dashboard/Store"

Page {

    id: rootPage

    readonly property real contentPadding: dp(Theme.navigationBar.defaultBarItemPadding)
    readonly property real defaultSpacing: dp(20)

    readonly property real rowBtnFirstDivisor: 2.8
    readonly property real rowBtnSecondDivisor: 1.6

    readonly property color searchBarBackColor: "#CCD1D1"

    readonly property color separatorColor: "#BCC9C9"

    //readonly property color avatarsBackColor: "#D7DBDD"

    readonly property string paperShadowColor: "#EBEAEA"

    readonly property color cuteColorSecondary: "#393B3D"

    property real topTitleMarginBig: 45

    property bool preLottiesOn: true // This helps enabling/disabling auth and welcome lotties during navStack logic
    property bool dashLayoutAtLeastOnce: false

    // End Auth properties

    // Start of animation properties (now done other way)
    /**
        property StackViewDelegate delegateWithBottomToTop
        property StackViewDelegate delegateDefault // filled by NavigationStack
    **/

    // End of animation properties

    useSafeArea: false

    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom

    NavigationStack {
        id: navStack

        //Split view
        leftColumnIndex: 1
        splitView: false

        Auth {}

        Component.onCompleted: {
            navStack.transitionDelegate = navStack.transitionDelegateiOS // force iOS delegate
            navStack.transitionDelegateAndroid.pushTransition = externalDelegate.pushTransition // custom push
            /**
                delegateDefault = navStack.transitionDelegate
                delegateWithBottomToTop = navStack.transitionDelegate

                Bottom to top set
                delegateWithBottomToTop.pushTransition = bottomToTopTransition
            **/
        }

        onTransitionFinished: {
           console.debug("NavStack updated, now is " + navStack.depth + " pages depth")
        }

        onPushed: {
            stopSubscriptionSettingsLottieTimer.running = true
        }

        onPopped: {
            adjustSubscriptionSettingsLottie()
        }


        property var cachedCleanUpPage: null
        // Necessary for Pages with lotties because of CPU
        function pushWithCleanUp(source, options, currentOptions) {
            navStack.clearAndPush(source, currentOptions)
            navStack.popAllExceptFirstAndPush(source, options)
        }

        function enableBottomToTop() {
          navStack.transitionDelegate = navStack.transitionDelegateAndroid
          console.debug("[INFO] Enabled Bottom To Top transition")
          //navStack.transitionDelegateAndroid.pushTransition = externalDelegate.pushTransition
        }

        function disableBottomToTop() {
           navStack.transitionDelegate = navStack.transitionDelegateiOS
           console.debug("[INFO] Disabled Bottom To Top transition")
        }


        StackViewDelegate {
            id: externalDelegate

            pushTransition:
                StackViewTransition {
                     NumberAnimation {
                        target: enterItem
                        property: "y"
                        from: (enterItem.height > 0 ? (enterItem.height - (enterItem.height * 0.4)) : enterItem.height)
                        to: 0
                        duration: (Theme.isIos ? 193 : 230)

                       }
                }
            }



    }

    Component.onCompleted: {
        HttpNetworkActivityIndicator.activationDelay = 0
    }

    function getRelativeTextSize(fontSizeBase, obj) {
        var result = null


        result = sp(fontSizeBase * (obj.width / 435))


        //console.debug("r result: " + result)
        return result
    }

    // Use this now instead of getRelativeTextSize
    function getTextSize(size, ignoreTablet = false) {

        if (!ignoreTablet) {
            if (isTablet && size >= 17) {
                return (size * 1.2)
            }
            else if (isTablet && size < 17) {
                return (size * 0.8)
            }
        }

        return (size * 0.9)
    }

    Component {
        id: subscriptionsExternalComponent

        Subscription {}


    }

    Component {
        id: subscriptionsStoreExternalComponent

        SubscriptionStore {}
    }

    property int subscriptionsStoreExternalIndex: 0

    property var cachedSubscriptionSettingsPage: null

    property bool cachedSubscriptionSettingsLottieNeedPause: false

    function adjustSubscriptionSettingsLottie() {
        if (cachedSubscriptionSettingsPage != null) {

            if (cachedSubscriptionSettingsLottieNeedPause) {
                cachedSubscriptionSettingsPage.pauseSettingsLottie()
                cachedSubscriptionSettingsLottieNeedPause = false

                navStack.enableBottomToTop()
            }
            else {
                cachedSubscriptionSettingsPage.resumeSettingsLottie()

                navStack.disableBottomToTop()
            }

        }
    }

    Timer {
        id: stopSubscriptionSettingsLottieTimer

        running: false
        interval: 250
        repeat: false

        onTriggered: {
            adjustSubscriptionSettingsLottie()
        }
    }

}
