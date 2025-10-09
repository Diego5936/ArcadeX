import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.System;
import Toybox.Lang;
import Layout;

class ArcadeXView extends WatchUi.View {

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
        var bx = Layout.centerX(dc) - 80;
        var by = Layout.centerY(dc) + Layout.BUTTON_OFFSET_Y - 20;
        var bw = 160;
        var bh = 40;

        dc.fillRectangle(bx, by, bw, bh);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.drawRectangle(bx, by, bw, bh);
        
        dc.drawText(Layout.centerX(dc), by + bh/2 - 5,
                Graphics.FONT_SMALL, "Start 2048", Graphics.TEXT_JUSTIFY_CENTER);
    }

    function onTap(position) as Boolean {
        var screen = System.getDeviceSettings();
        var w = screen[:displayWidth];
        var h = screen[:displayHeight];

        var btn = {
            :x => w/2 - 80,
            :y => h/2 + Layout.BUTTON_OFFSET_Y - 20,
            :w => 160,
            :h => 40
        };

        if (position[:x] >= btn[:x] and position[:x] <= btn[:x] + btn[:w] and
            position[:y] >= btn[:y] and position[:y] <= btn[:y] + btn[:h]) {
            WatchUi.pushView(new Game2048View(), new Game2048Delegate(), WatchUi.SLIDE_IMMEDIATE);
            return true;
        }

        return false;
    }
}