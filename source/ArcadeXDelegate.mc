import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.System;

class ArcadeXDelegate extends WatchUi.InputDelegate {
    var view as ArcadeXView or Null;
    
    function initialize(v as ArcadeXView) {
        InputDelegate.initialize();
        view = v;
    }

    // --- Action Functions ---
    function select() as Boolean {
        return GameRegistry.launch(GameRegistry.GAMES[view.gameIdx][:id], true);
    }

    function scroll(direction as String) {
        if (direction.equals("up")) {
            view.scroll(-1);
        }
        else if (direction.equals("down")) {
            view.scroll(+1);
        }
    }

    // --- Input Handling ---
    function onTap(click as WatchUi.ClickEvent) {
        var position = click.getCoordinates();
        var x = position[0];
        var y = position[1];

        var button = view.getMainButton() as Dictionary;

        var tap = x >= button[:x] and x <= button[:x] + button[:w] and
                    y >= button[:y] and y <= button[:y] + button[:h];
                
        if (!tap) {
            return false;
        }

        return select();
    }

    function onSwipe(swipe as WatchUi.SwipeEvent) as Boolean {
        var direction = swipe.getDirection();

        if (direction == WatchUi.SWIPE_UP) {
            scroll("down");
            return true;
        }
        else if (direction == WatchUi.SWIPE_DOWN) {
            scroll("up");
            return true;
        }

        return false;
    }

    function onKeyPressed(key as WatchUi.KeyEvent) as Boolean {
        var keyCode = key.getKey();

        if (keyCode == WatchUi.KEY_UP) {
            scroll("up");
            return true; 
        }
        else if (keyCode == WatchUi.KEY_DOWN) {
            scroll("down");
            return true;
        }
        else if (keyCode == WatchUi.KEY_ENTER) {
            return select();
        }
        
        return false;
    }
}