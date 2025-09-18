import Toybox.WatchUi;

class ArcadeXBehaviorDelegate extends WatchUi.BehaviorDelegate{
    
    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        var menu = new WatchUi.Menu();
        var delegate;
        
        menu.setTitle("ArcadeX");
        menu.addItem("2048", :one);
        menu.addItem("Maze", :two);

        delegate = new ArcadeXMenuDelegate();
        WatchUi.pushView(menu, delegate, WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
}