import Toybox.WatchUi;
import Toybox.Lang;

import Game2048;

class GameInputDelegate extends WatchUi.InputDelegate {
    var moveCallback as Method;
    
    function initialize(moveCallback as Method) {
        InputDelegate.initialize();
        self.moveCallback = moveCallback;
    }

    function handleInput(input as String) {
        if (moveCallback != null) {
            moveCallback.invoke(input);
        }
    }

    // ---------- Input Handling ----------

    function onSwipe(swipe as WatchUi.SwipeEvent) as Boolean {
        var direction = swipe.getDirection();

        if (direction == SWIPE_RIGHT) { 
            handleInput("right");
            /* Right swipe by watch default is to go back
            if the swipe starts all the way on the left it will default to back
            if the swipe is from the center of the watch to the right, then the action occurs */
        }
        else if (direction == SWIPE_LEFT) {
            handleInput("left");
        }
        else if (direction == SWIPE_UP) { 
            handleInput("up");
        } 
        else if (direction == SWIPE_DOWN) { 
            handleInput("down");
        } 

        return true;
    }

    function onTap(click as WatchUi.ClickEvent) as Boolean {
        var position = click.getCoordinates();
        var x = position[0];
        var y = position[1];

        var direction = Layout.determineRegion(x, y);
        handleInput(direction);

        return true;
    }

    function onKey(key as KeyEvent) as Boolean{
        var code = key.getKey();

        if (code == WatchUi.KEY_ENTER) {
            handleInput("enter");
        }
        else {
            return false;
        }
        
        return true;
    }

    function onBack() as Boolean {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
}