import Toybox.WatchUi;
import Toybox.Lang;

import Game2048;

class Game2048Delegate extends WatchUi.InputDelegate {
    function initialize() {
        InputDelegate.initialize();
    }

    function onSwipe(swipeEvent as WatchUi.SwipeEvent) {
        var direction = swipeEvent.getDirection();

        if (direction == SWIPE_RIGHT) { 
            Game2048.slideHorizontally("right");
            Game2048.spawnNewTile();
            WatchUi.requestUpdate();
            return true; // Consume event, avoid default back when sliding right
            /* It will only truly consume the event
            if the swipe is from the center of the watch to the right
            if the swipe starts all the way on the left it will default */
        }

        if (direction == SWIPE_UP) { 
            Game2048.slideVertically("up");
            
        } 
        else if (direction == SWIPE_DOWN) { 
            Game2048.slideVertically("down");
        } 
        else if (direction == SWIPE_LEFT) {
            Game2048.slideHorizontally("left");
        }

        Game2048.spawnNewTile();
        WatchUi.requestUpdate();

        return true;
    }

    function onBack() as Boolean {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
}