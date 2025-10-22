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
            var buttons = view.getButtons();

            for (var i = 0; i < buttons.size(); i++) {
                var rect = buttons[i] as Dictionary;

                var tap = x >= rect[:x] and x <= rect[:x] + rect[:w] and
                            y >= rect[:y] and y <= rect[:y] + rect[:h];
                   
                if (!tap) {
                    continue;
                }
                
                if (rect[:name].equals("2048")) {
                    WatchUi.pushView(new Menu2048View(), new Menu2048Delegate(), WatchUi.SLIDE_IMMEDIATE);
                    return true;
                }
                else if (rect[:name].equals("Snake")) {
                    WatchUi.pushView(new MenuSnakeView(), new MenuSnakeDelegate(), WatchUi.SLIDE_IMMEDIATE);
                    return true;
                }
                else {
                    System.println("Tapped unknown button: " + rect[:name]);
                }
            }
        }
        else {
            System.println("Current view (ArcadeX) view is null.");
        }

        return true;
    }
}