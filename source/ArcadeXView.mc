import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Lang;

import Layout;

class ArcadeXView extends WatchUi.View {

    var bx, by, bw, bh;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void { }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Background
        // setColor(foreground = text and shapes, background)
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();

        // Title
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.drawText(Layout.centerX(dc), Layout.centerY(dc) + Layout.TITLE_OFFSET_Y, 
                    Graphics.FONT_LARGE, "ArcadeX", Graphics.TEXT_JUSTIFY_CENTER);

        // Button
        bw = 190;
        bh = 60;
        bx = Layout.centerX(dc) - (bw / 2);
        by = Layout.centerY(dc) + Layout.BUTTON_OFFSET_Y;
        
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.fillRectangle(bx, by, bw, bh);
        dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
        dc.drawRectangle(bx, by, bw, bh);
        
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.drawText(Layout.centerX(dc), by + 10,
                Graphics.FONT_TINY, "Start 2048", Graphics.TEXT_JUSTIFY_CENTER);

        System.println("Drew everything.");
    }

    function getButtonRect() as Dictionary {
        return {
            :x => bx, :y => by, :w => bw, :h => bh
        };
    }
}