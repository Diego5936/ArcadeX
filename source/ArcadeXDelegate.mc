import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.System;

class ArcadeXDelegate extends WatchUi.InputDelegate {

    function initialize() {
        InputDelegate.initialize();
    }

    function onTap(clickEvent as WatchUi.ClickEvent) {
        var position = clickEvent.getCoordinates();
        var x = position[0];
        var y = position[1];

        // Get view counterpart
        // Returns as [view, delegate] so separate
        var viewPair = WatchUi.getCurrentView();
        var view = viewPair[0] as ArcadeXView;

        if (view != null) {
            var rect = view.get2048Button();

            var tap2048 = x >= rect[:x] and x <= rect[:x] + rect[:w] and 
                        y >= rect[:y] and y <= rect[:y] + rect[:h];

            if (tap2048) {
                WatchUi.pushView(new Menu2048View(), new Menu2048Delegate(), WatchUi.SLIDE_IMMEDIATE);
                return true;
            }
        }
        else {
            System.println("Current view (ArcadeX) view is null.");
        }

        return true;
    }
}