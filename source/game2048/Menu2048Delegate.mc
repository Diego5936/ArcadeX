import Toybox.WatchUi;
import Toybox.System;
import Toybox.Lang;

class Menu2048Delegate extends WatchUi.InputDelegate {
    var view as Menu2048View or Null;

    function initialize(v as Menu2048View) {
        InputDelegate.initialize();
        view = v;
    }

    // --- Action Functions ---
    // Choice: 0 = New, 1 = Continue
    function select(choice as Number) as Boolean {      
        if (choice != 1 ) {
            SaveManager.resetGrid();   
        }

        GameRegistry.launch("2048", false);
        return true;
    }

    // --- Input Handling ---
    function onTap(clickEvent as WatchUi.ClickEvent) {
        if (view == null) { return false; }

        var position = clickEvent.getCoordinates();
        var x = position[0];
        var y = position[1];

        if (view.hasContinue) {
            var newB = view.playButtons[0] as Dictionary;
            var contB = view.playButtons[1] as Dictionary;

            var tapNew = x >= newB[:x] and x <= newB[:x] + newB[:w] and 
                        y >= newB[:y] and y <= newB[:y] + newB[:h];
            var tapCont = x >= contB[:x] and x <= contB[:x] + contB[:w] and 
                        y >= contB[:y] and y <= contB[:y] + contB[:h];

            if (!tapNew && !tapCont) { return false; }
            var choice = tapNew ? 0 : 1;
            return select(choice);
        }
        else {
            var button = view.playButton as Dictionary;
            var tap = x >= button[:x] and x <= button[:x] + button[:w] and
                      y >= button[:y] and y <= button[:y] + button[:h];

            if (!tap) { return false; }
            return select(0);
        }
    }

    function onKeyPressed(key as WatchUi.KeyEvent) as Boolean {
        if (view == null) { return false; }

        var keyCode = key.getKey();
        if (keyCode == WatchUi.KEY_ENTER) {
            if (view.hasContinue) {
                return select(view.selected);
            }
            else {
                return select(0);
            }
        }
        else if (keyCode == WatchUi.KEY_UP || keyCode == WatchUi.KEY_DOWN) {
            view.selected = view.selected == 0 ? 1 : 0;
            System.println(view.selected);
            WatchUi.requestUpdate();
        }

        return false;
    }
}