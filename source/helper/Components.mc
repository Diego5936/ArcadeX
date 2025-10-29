import Toybox.Graphics;
import Toybox.Lang;

import Layout;
import SaveManager;

module Components {
    // Makes a titled box
    /* Takes in:
        rect as Dictionary {[:x] X-position, [:y] Y-position, [:w] Width, [:h] Height}\
        format as Dictionary {[:background], [:border], [:text], [:font]}
        title of the rect
    */
    function makeRect(dc as Dc, rect as Dictionary, format as Dictionary, title as String) {
        // Rect fillc
        dc.setColor(format[:background], Color.none);
        dc.fillRectangle(rect[:x], rect[:y], rect[:w], rect[:h]);

        // Rect border
        dc.setColor(format[:border], Color.none);
        dc.drawRectangle(rect[:x], rect[:y], rect[:w], rect[:h]);

        // Title
        var titleX = rect[:x] + (rect[:w] / 2);
        dc.setColor(format[:text], Color.none);
        dc.drawText(titleX, rect[:y],
                format[:font], title, Graphics.TEXT_JUSTIFY_CENTER);
    }

    function makeStartButton(dc as Dc, label as String, backColor, border, textColor) as Dictionary {
        var screenW = dc.getWidth();
        var screenH = dc.getHeight();

        // Button sizes
        var x = 0;
        var y = screenH * 0.60;
        var w = screenW;
        var h = screenH - y;

        // Draw "semicircle" in the bottom half
        dc.setColor(backColor, Color.none);
        dc.fillRectangle(x, y, w, h);

        // Border
        dc.setColor(border, Color.none);
        dc.drawRectangle(x, y, w, h);
        
        // Text
        dc.setColor(textColor, Color.none);
        dc.drawText(Layout.centerX(dc), screenH - (h / 1.3), Graphics.FONT_MEDIUM, 
                    label, Graphics.TEXT_JUSTIFY_CENTER);

        return { :x => x, :y => y, :w => w, :h => h };
    }

    function makeGameOver(dc as Dc, gameName as String, textColor, score as Number) {
        // Game Over Title
        dc.setColor(textColor, Graphics.COLOR_TRANSPARENT);
        dc.drawText(Layout.centerX(dc), Layout.centerY(dc), 
                    Graphics.FONT_SYSTEM_LARGE, "GAME OVER", Graphics.TEXT_JUSTIFY_CENTER);

        // Draw Score
        var scoreTitle = ("Score: " + score);
        dc.drawText(Layout.centerX(dc), Layout.centerY(dc) + 50, 
                    Graphics.FONT_SYSTEM_LARGE, scoreTitle, Graphics.TEXT_JUSTIFY_CENTER);

        var highScore = SaveManager.getHighScore(gameName);
        var highScoreTitle = ("High: " + highScore);
        dc.drawText(Layout.centerX(dc), Layout.centerY(dc) + 100, 
                    Graphics.FONT_SYSTEM_LARGE, highScoreTitle, Graphics.TEXT_JUSTIFY_CENTER);
    }
}