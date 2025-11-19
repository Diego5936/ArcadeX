import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;

import SaveManager;
import Layout;

class Menu2048View extends WatchUi.View {
    var playButtons as Array or Null; // for double buttons
    var playButton as Dictionary or Null; // for single button
    var hasContinue as Boolean = false;
    var selected as Number = 1;

    function initialize() {
        View.initialize();
    }

    function onUpdate(dc as Dc) as Void {
        // Background
        var background = Color.TILES["big"];
        dc.setColor(Color.none, background);
        dc.clear();

        // Title
        Components.draw2048Title(dc);
        Components.drawHighScore(dc, "2048", Graphics.COLOR_WHITE);

        // Decide menu state
        hasContinue = SaveManager.hasGrid();
        playButtons = null;
        playButton = null;

        if (hasContinue) {
            // Dual Buttons: New / Continue
            var labels = ["New", "Continue"];
            var selectedButton = {:backColor => Color.TILES[2048],
                                :border => Graphics.COLOR_WHITE,
                                :textColor => Graphics.COLOR_WHITE};
            var otherButton = {:backColor => background,
                                :border => Graphics.COLOR_WHITE,
                                :textColor => Graphics.COLOR_WHITE};
            playButtons = Components.makeDualButtons(dc, selected, labels, selectedButton, otherButton);
        }
        else {
            // Single Button: New
            playButton = Components.makeStartButton(dc, "New", 
                                            Graphics.COLOR_YELLOW, 
                                            Graphics.COLOR_BLACK, 
                                            Graphics.COLOR_BLACK);
        }
    }
}