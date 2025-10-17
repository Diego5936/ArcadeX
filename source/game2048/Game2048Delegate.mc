import Toybox.WatchUi;
import Toybox.Lang;

class Game2048Delegate extends WatchUi.InputDelegate {

    function initialize() {
        InputDelegate.initialize();

    }

    function onSwipe(swipeEvent as WatchUi.SwipeEvent) {
        var direction = swipeEvent.getDirection();

        // Get view counterpart
        var viewPair = WatchUi.getCurrentView();
        var view = viewPair[0] as Game2048View;

        // RIGHT
        // It will only 
        if (direction == SWIPE_RIGHT) { 
            System.println("RIGHT");
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