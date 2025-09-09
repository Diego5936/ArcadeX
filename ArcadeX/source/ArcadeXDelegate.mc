import Toybox.Lang;
import Toybox.WatchUi;

class ArcadeXDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new ArcadeXMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}