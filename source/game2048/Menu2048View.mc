import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Lang;

import Layout;

class Menu2048View extends WatchUi.View {

    var playButton as Dictionary or Null;

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

        // New Game Button
        playButton = Components.makeStartButton(dc, "Start", Graphics.COLOR_YELLOW, 
                                Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
    }
}