import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.System;

class ArcadeXDelegate extends WatchUi.InputDelegate {
    function initialize() {
        InputDelegate.initialize();
    }

    function onTap(click as WatchUi.ClickEvent) {
        var position = click.getCoordinates();
        var x = position[0];
        var y = position[1];

        // Get view counterpart
        // Returns as [view, delegate] so separate
        var viewPair = WatchUi.getCurrentView();
        var view = viewPair[0] as ArcadeXView;

        if (view != null) {
            var button = view.getMainButton() as Dictionary;

            var tap = x >= button[:x] and x <= button[:x] + button[:w] and
                        y >= button[:y] and y <= button[:y] + button[:h];
                   
            if (!tap) {
                return false;
            }

            var currentGame = view.games[view.gameIdx];
                
            if (currentGame.equals("2048")) {
                WatchUi.pushView(new Menu2048View(), new Menu2048Delegate(), WatchUi.SLIDE_IMMEDIATE);
                return true;
            }
            else if (currentGame.equals("Snake")) {
                WatchUi.pushView(new MenuSnakeView(), new MenuSnakeDelegate(), WatchUi.SLIDE_IMMEDIATE);
                return true;
            }
            else {
                System.println(currentGame + " is not implemented yet!");
            }
        }
        else {
            System.println("Current view (ArcadeX) view is null.");
        }

        return true;
    }

    function onSwipe(swipe as WatchUi.SwipeEvent) as Boolean {
        var viewPair = WatchUi.getCurrentView();
        var view = viewPair[0] as ArcadeXView;
        if (view == null) {
            return false;
        }

        var direction = swipe.getDirection();
        if (direction == WatchUi.SWIPE_UP) {
            view.scroll(+1);
            return true;
        }
        else if (direction == WatchUi.SWIPE_DOWN) {
            view.scroll(-1);
            return true;
        }

        return false;
    }
}