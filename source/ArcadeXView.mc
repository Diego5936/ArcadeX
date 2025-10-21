import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Lang;

import Layout;

class ArcadeXView extends WatchUi.View {

    var game2048B as Dictionary = { :x => 0, :y => 0, :w => 0, :h => 0 }; // 2048 Button

    function initialize() {
        View.initialize();
    }

    function onUpdate(dc as Dc) as Void {
        // Background
        // setColor(foreground = text and shapes, background)
        dc.setColor(Color.none, Graphics.COLOR_BLACK);
        dc.clear();

        // Title
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.drawText(Layout.centerX(dc), Layout.centerY(dc) - 30, 
                    Graphics.FONT_LARGE, "ArcadeX", Graphics.TEXT_JUSTIFY_CENTER);

        // 2048 Button
        game2048B[:w] = 190;
        game2048B[:h] = 60;
        game2048B[:x] = Layout.centerX(dc) - (game2048B[:w] / 2);
        game2048B[:y] = Layout.centerY(dc) + 50;
        // rect
        dc.setColor(Graphics.COLOR_BLACK, Color.none);
        dc.fillRectangle(game2048B[:x], game2048B[:y], game2048B[:w], game2048B[:h]);
        dc.setColor(Graphics.COLOR_RED, Color.none);
        dc.drawRectangle(game2048B[:x], game2048B[:y], game2048B[:w], game2048B[:h]);
        // title
        dc.setColor(Graphics.COLOR_WHITE, Color.none);
        dc.drawText(Layout.centerX(dc), game2048B[:y] + 10,
                Graphics.FONT_TINY, "2048", Graphics.TEXT_JUSTIFY_CENTER);
    }

    function get2048Button() as Dictionary {
        return {
            :x => game2048B[:x], :y => game2048B[:y], :w => game2048B[:w], :h => game2048B[:h]
        };
    }
}