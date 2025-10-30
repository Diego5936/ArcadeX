import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.System;

class ArcadeXDelegate extends WatchUi.InputDelegate {
    var view as ArcadeXView or Null;
    
    function initialize() {
        InputDelegate.initialize();
    }

    function setView() {
        // Get view counterpart
        // Returns as [view, delegate] so separate
        var viewPair = WatchUi.getCurrentView();
        view = viewPair[0] as ArcadeXView;
    }

    function ensureView() as Boolean {
        if (view == null) {
            setView();
        }
        return (view != null);
    }


    // --- Action Functions ---
    function select() as Boolean {
        if (!ensureView()) {
            System.println("Scroll failed: view is null");
            return false;
        }

        return GameRegistry.launch(GameRegistry.GAMES[view.gameIdx][:id], true);
    }

    function scroll(direction as String) {
        if (!ensureView()) {
            System.println("Scroll failed: view is null");
            return;
        }

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

        if (view == null) {
            setView();
        }

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