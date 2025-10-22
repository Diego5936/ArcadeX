import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Lang;

import Layout;
import Components;

class ArcadeXView extends WatchUi.View {

    var buttons as Array = [];
    
    function initialize() {
        View.initialize();
    }

    function onUpdate(dc as Dc) as Void {
        // Background
        // setColor(foreground = text and shapes, background)
        dc.setColor(Color.none, Graphics.COLOR_BLACK);
        dc.clear();

        // Main Title
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.drawText(Layout.centerX(dc), Layout.workingTop, 
                    Graphics.FONT_LARGE, "ArcadeX", Graphics.TEXT_JUSTIFY_CENTER);

        // Buttons
        var games = ["2048", "Snake", "Tetris"];
        var initY = Layout.workingTop + 80;
        buttons = Components.makeMenuButtons(dc, games, initY);        
    }

    function getButtons() as Array {
        return buttons;
    }
}