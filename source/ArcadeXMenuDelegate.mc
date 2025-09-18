import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class ArcadeXMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item as Symbol) as Void {
        if (item == :one) {
            System.println("item 1");
        } else if (item == :two) {
            System.println("item 2");
        }
    }

}