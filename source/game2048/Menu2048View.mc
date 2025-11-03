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
        dc.setColor(Color.none, Graphics.COLOR_LT_GRAY);
        dc.clear();

        // Title
        dc.setColor(Graphics.COLOR_BLACK, Color.none);
        dc.drawText(Layout.centerX(dc), Layout.centerY(dc) - 30, 
                    Graphics.FONT_LARGE, "!!2048!!", Graphics.TEXT_JUSTIFY_CENTER);

        // Decide menu state
        hasContinue = SaveManager.hasGrid();
        playButtons = null;
        playButton = null;

        if (hasContinue) {
            // Dual Buttons: New / Continue
            var labels = ["New", "Continue"];
            var selectedButton = {:backColor => Graphics.COLOR_YELLOW,
                                :border => Graphics.COLOR_BLACK,
                                :textColor => Graphics.COLOR_BLACK};
            var otherButton = {:backColor => Graphics.COLOR_WHITE,
                                :border => Graphics.COLOR_BLACK,
                                :textColor => Graphics.COLOR_BLACK};
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