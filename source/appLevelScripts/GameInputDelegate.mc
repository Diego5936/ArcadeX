import Toybox.WatchUi;
import Toybox.Lang;

import Game2048;

class GameInputDelegate extends WatchUi.InputDelegate {
    var moveCallback as Method;
    
    function initialize(moveCallback as Method) {
        InputDelegate.initialize();
        self.moveCallback = moveCallback;
    }

    function handleMove(direction as String) {
        if (moveCallback != null) {
            moveCallback.invoke(direction);
        }
    }

    // ---------- Input Handling ----------

    function onSwipe(swipe as WatchUi.SwipeEvent) as Boolean {
        var direction = swipe.getDirection();

        if (direction == SWIPE_RIGHT) { 
            handleMove("right");
            /* Right swipe by watch default is to go back
            if the swipe starts all the way on the left it will default to back
            if the swipe is from the center of the watch to the right, then the action occurs */
        }
        else if (direction == SWIPE_LEFT) {
            handleMove("left");
        }
        else if (direction == SWIPE_UP) { 
            handleMove("up");
        } 
        else if (direction == SWIPE_DOWN) { 
            handleMove("down");
        } 

        return true;
    }

    function onTap(click as WatchUi.ClickEvent) as Boolean {
        var position = click.getCoordinates();
        var x = position[0];
        var y = position[1];

        var direction = Layout.determineRegion(x, y);
        handleMove(direction);

        return true;
    }

    function onBack() as Boolean {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
}