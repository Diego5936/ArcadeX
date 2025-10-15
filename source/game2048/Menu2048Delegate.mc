import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.System;

class Menu2048Delegate extends WatchUi.InputDelegate {

    function initialize() {
        InputDelegate.initialize();
    }

    function onTap(clickEvent as WatchUi.ClickEvent) {
        var position = clickEvent.getCoordinates();
        var x = position[0];
        var y = position[1];

        // Get view counterpart
        var viewPair = WatchUi.getCurrentView();
        var view = viewPair[0] as Menu2048View;

        if (view != null) {
            var rect = view.getNewGameButton();

            var tapNewGB = x >= rect[:x] and x <= rect[:x] + rect[:w] and 
                            y >= rect[:y] and y <= rect[:y] + rect[:h];

            if (tapNewGB) {
                WatchUi.pushView(new Game2048View(), new Game2048Delegate(), WatchUi.SLIDE_IMMEDIATE);
                return true;
            }
        }
        else {
            System.println("Current view (Menu2048) view is null.");
        }

        return true;
    }
}