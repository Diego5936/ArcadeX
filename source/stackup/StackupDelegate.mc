import Toybox.WatchUi;
import Toybox.Lang;

import Stackup;

class StackupDelegate extends WatchUi.InputDelegate {
    function initialize() {
        InputDelegate.initialize();
    }

    function onSwipe(swipeEvent as WatchUi.SwipeEvent) {
        if (!Stackup.active){
            return true;
        }
        
        var direction = swipeEvent.getDirection();

        // if (direction == SWIPE_RIGHT && !(current != null && current.equals("left"))) { 
        //     Snake.setNextDirection("right");
        //     /* Right swipe by watch default is to go back
        //     if the swipe starts all the way on the left it will default to back
        //     if the swipe is from the center of the watch to the right, then the action occurs */
        // }
        // else if (direction == SWIPE_UP && !(current != null && current.equals("down"))) { 
        //     Snake.setNextDirection("up");
        // } 
        // else if (direction == SWIPE_DOWN && !(current != null && current.equals("up"))) { 
        //     Snake.setNextDirection("down");
        // } 
        // else if (direction == SWIPE_LEFT && !(current != null && current.equals("right"))) {
        //     Snake.setNextDirection("left");
        // }
        
        WatchUi.requestUpdate();
        return true;
    }

    function onBack() as Boolean {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
}