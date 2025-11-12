import Toybox.WatchUi;
import Toybox.Lang;

import Stackup;

class StackupDelegate extends WatchUi.InputDelegate {
    function initialize() {
        InputDelegate.initialize();
    }

    function onTap(clickEvent as WatchUi.ClickEvent) {
        if (!Stackup.active){ return true; }
         System.println("tapped THAT BIH");

        Stackup.rotate();

        WatchUi.requestUpdate();
        return true;
    }

    function onSwipe(swipeEvent as WatchUi.SwipeEvent) {
        if (!Stackup.active){ return true; }
        
        var direction = swipeEvent.getDirection();

        if (direction == WatchUi.SWIPE_DOWN) {
            Stackup.hardFall();
        }
        
        WatchUi.requestUpdate();
        return true;
    }

    function onBack() as Boolean {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
}