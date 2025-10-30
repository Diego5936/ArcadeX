import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.System;

class Menu2048Delegate extends WatchUi.InputDelegate {
    var view as Menu2048View or Null;

    function initialize() {
        InputDelegate.initialize();
    }

    function setView() {
        var viewPair = WatchUi.getCurrentView();
        view = viewPair[0] as Menu2048View;
    }

    // --- Action Functions ---
    function select() as Boolean {
        if (!ensureView()) {
            System.println("Scroll failed: view is null");
            return false;
        }

        GameRegistry.launch("2048", false);

        return true;
    }

    function ensureView() as Boolean {
        if (view == null) {
            setView();
        }
        return (view != null);
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