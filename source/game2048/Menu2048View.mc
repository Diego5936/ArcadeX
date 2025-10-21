import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Lang;

import Layout;

class Menu2048View extends WatchUi.View {

    var newGB as Dictionary = { :x => 0, :y => 0, :w => 0, :h => 0 }; // New Game Button

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
        newGB[:w] = 190;
        newGB[:h] = 60;
        newGB[:x] = Layout.centerX(dc) - (newGB[:w] / 2);
        newGB[:y] = Layout.centerY(dc) + 50;
        // rect
        dc.setColor(Graphics.COLOR_YELLOW, Color.none);
        dc.fillRectangle(newGB[:x], newGB[:y], newGB[:w], newGB[:h]);
        dc.setColor(Graphics.COLOR_BLACK, Color.none);
        dc.drawRectangle(newGB[:x], newGB[:y], newGB[:w], newGB[:h]);
        // title
        dc.setColor(Graphics.COLOR_BLACK, Color.none);
        dc.drawText(Layout.centerX(dc), newGB[:y] + 10,
                Graphics.FONT_TINY, "New Game", Graphics.TEXT_JUSTIFY_CENTER);
    }

    function getNewGameButton() as Dictionary {
        return {
            :x => newGB[:x], :y => newGB[:y], :w => newGB[:w], :h => newGB[:h]
        };
    }
}