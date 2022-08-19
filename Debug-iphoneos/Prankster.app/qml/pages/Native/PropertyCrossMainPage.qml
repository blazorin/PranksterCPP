import QtQuick 2.0
import QtQuick.Controls 1.2
import Felgo 3.0


Page {

    id: rootPage

    readonly property real contentPadding: dp(Theme.navigationBar.defaultBarItemPadding)
    readonly property real defaultSpacing: dp(20)

    readonly property real rowBtnFirstDivisor: 2.8
    readonly property real rowBtnSecondDivisor: 1.6

    readonly property color searchBarBackColor: "#CCD1D1"
    readonly property color pagesBackColor: "#F5F5F5"

    //readonly property color avatarsBackColor: "#D7DBDD"

    readonly property string paperShadowColor: "#EBEAEA"

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

        property var cachedCleanUpPage: null
        // Necessary for Pages with lotties because of CPU
        function pushWithCleanUp(source, options, currentOptions) {
            navStack.clearAndPush(source, currentOptions)
            navStack.popAllExceptFirstAndPush(source, options)
        }

        function enableBottomToTop() {  

          navStack.transitionDelegate.pushTransition = externalDelegate.pushTransition
        }

        function disableBottomToTop() {
           navStack.transitionDelegate = navStack.transitionDelegateiOS
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
                        duration: 275
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
    function getTextSize(size) {
        if (isTablet) {
            return sp(size * 1.5)
        }

        return sp(size)
    }

}
