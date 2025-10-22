import Toybox.WatchUi;
import Toybox.Lang;

import Snake;

class SnakeDelegate extends WatchUi.InputDelegate {
    function initialize() {
        InputDelegate.initialize();
    }

    function onSwipe(swipeEvent as WatchUi.SwipeEvent) {
        var direction = swipeEvent.getDirection();

        if (direction == SWIPE_RIGHT) { 
            Snake.direction = "right";
            /* Right swipe by watch default is to go back
            if the swipe starts all the way on the left it will default to back
            if the swipe is from the center of the watch to the right, then the action occurs */
        }
        else if (direction == SWIPE_UP) { 
            Snake.direction = "up";
            
        } 
        else if (direction == SWIPE_DOWN) { 
            Snake.direction = "down";
        } 
        else if (direction == SWIPE_LEFT) {
            Snake.direction = "left";
        }
        
        WatchUi.requestUpdate();

        return true;
    }

    function onBack() as Boolean {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
}