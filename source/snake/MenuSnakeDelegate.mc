import Toybox.WatchUi;
import Toybox.Lang;

class MenuSnakeDelegate extends WatchUi.InputDelegate {
    var view as MenuSnakeView or Null;

    function initialize() {
        InputDelegate.initialize();
    }

    function setView() {
        var viewPair = WatchUi.getCurrentView();
        view = viewPair[0] as MenuSnakeView;
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

        WatchUi.pushView(new SnakeView(), new SnakeDelegate(), WatchUi.SLIDE_IMMEDIATE);

        return true;
    }

    // --- Input Handling ---
    function onTap(clickEvent as WatchUi.ClickEvent) {
        var position = clickEvent.getCoordinates();
        var x = position[0];
        var y = position[1];

        if (view == null) {
            setView();
        }

        var rect = view.playButton;

        var tapPlay = x >= rect[:x] and x <= rect[:x] + rect[:w] and 
                    y >= rect[:y] and y <= rect[:y] + rect[:h];

        if (!tapPlay) {    
            return false;
        }

        return select();
    }

    function onKeyPressed(key as WatchUi.KeyEvent) as Boolean {
        var keyCode = key.getKey();

        if (keyCode == WatchUi.KEY_ENTER) {
            return select();
        }
        
        return false;
    }
}