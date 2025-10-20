import Toybox.WatchUi;
import Toybox.Lang;

import Game2048;

class Game2048Delegate extends WatchUi.InputDelegate {

    function initialize() {
        InputDelegate.initialize();
    }

    function onSwipe(swipeEvent as WatchUi.SwipeEvent) {
        var direction = swipeEvent.getDirection();

        // RIGHT
        if (direction == SWIPE_RIGHT) { 
            Game2048.slideRight();
            System.println("RIGHT");
            WatchUi.requestUpdate();
            return true; // Consume event, avoid default back
            /* It will only truly consume the event
            if the swipe is from the center of the watch to the right
            if the swipe starts all the way on the left it will default */
        }

        // UP
        if (direction == SWIPE_UP) { 
            System.println("UP");
        } 
        // DOWN
        else if (direction == SWIPE_DOWN) { 
            System.println("DOWN");
        } 
        // LEFT
        else if (direction == SWIPE_LEFT) {
            System.println("LEFT");
        }

        return true;
    }

    function onBack() as Boolean {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
}