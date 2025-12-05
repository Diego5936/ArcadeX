import Toybox.Graphics;
import Toybox.Lang;

import SaveManager;
import Layout;
import Titles;

module Components {
    // Makes a titled box, Center aligned
    /* Takes in:
        rect as Dictionary {[:x] X-position, [:y] Y-position, [:w] Width, [:h] Height}
        format as Dictionary {[:background], [:border], [:text], [:font]}
        title of the rect
    */
    function makeTitleRect(dc as Dc, rect as Dictionary, format as Dictionary, title as String) {
        // Box
        makeRect(dc, rect, format);

        // Title
        var startY = rect[:y] - (rect[:h] / 2);

        dc.setColor(format[:text], Color.none);
        dc.drawText(rect[:x], startY + (rect[:h] * 0.10),
                format[:font], title, Graphics.TEXT_JUSTIFY_CENTER);
    }

    // Makes a rect, centered
    /* Takes in:
        rect as Dictionary {[:x] X-position, [:y] Y-position, [:w] Width, [:h] Height}\
        format as Dictionary {[:background], [:border]}
        title of the rect
    */
    function makeRect(dc as Dc, rect as Dictionary, colors as Dictionary) {
        var startX = rect[:x] - (rect[:w] / 2);
        var startY = rect[:y] - (rect[:h] / 2);

        // Rect fillc
        dc.setColor(colors[:background], Color.none);
        dc.fillRectangle(startX, startY, rect[:w], rect[:h]);

        // Rect border
        dc.setColor(colors[:border], Color.none);
        dc.drawRectangle(startX, startY, rect[:w], rect[:h]);
    }

    function makeStartButton(dc as Dc, label as String, backColor, border, textColor) as Dictionary {
        var screenW = dc.getWidth();
        var screenH = dc.getHeight();

        // Button sizes
        var x = 0;
        var y = screenH * 0.60;
        var w = screenW;
        var h = screenH * 0.50;

        // Draw "semicircle" in the bottom half
        dc.setColor(backColor, Color.none);
        dc.fillRectangle(x, y, w, h);

        // Border
        dc.setColor(border, Color.none);
        dc.drawRectangle(x, y, w, h);
        
        // Text
        dc.setColor(textColor, Color.none);
        dc.drawText(Layout.centerX(dc), screenH * 0.70, Graphics.FONT_MEDIUM, 
                    label, Graphics.TEXT_JUSTIFY_CENTER);

        return { :x => x, :y => y, :w => w, :h => h };
    }

    function makeDualButtons(dc as Dc, selected, labels, b1, b2) as Array {
        // b1 is the format of the selected button, b2 is the format of the other
        var screenW = dc.getWidth();
        var screenH = dc.getHeight();

        // Button sizes
        var y = screenH * 0.60;
        var w = screenW / 2;
        var h = screenH * 0.50;

        var bL = {:x => 0, :y => y, :w => w, :h => h};
        var bR = {:x => screenW / 2, :y => y, :w => w, :h => h};

        for (var i = 0; i < 2; i++) {
            var cur = (i == 0 ? bL as Dictionary : bR as Dictionary);
            var curf = (selected == i ? b1 as Dictionary : b2 as Dictionary);

            // Draw buttons
            dc.setColor(curf[:backColor], Color.none);
            dc.fillRectangle(cur[:x], cur[:y], cur[:w], cur[:h]);

            // Border
            dc.setColor(curf[:border], Color.none);
            dc.drawRectangle(cur[:x], cur[:y], cur[:w], cur[:h]);

            // Text
            dc.setColor(curf[:textColor], Color.none);
            dc.drawText(cur[:x] + cur[:w] * 0.45, screenH - cur[:h] * 0.65, Graphics.FONT_SMALL, 
                        (labels as Array)[i], Graphics.TEXT_JUSTIFY_CENTER);
        }

        return [bL, bR];
    }

    function makeGameOver(dc as Dc, gameName as String, textColor, score as Number) {
        var x = Layout.centerX(dc);
        var yP = 0.30;

        // --- Game Over --- 
        // Background
        
        var titleRect = {:x => x, :y => dc.getHeight() * yP, 
                        :w => dc.getWidth() * 0.40,
                        :h => dc.getHeight() * 0.20};
        var colors = {:background => Graphics.COLOR_BLACK,
                        :border => Color.NEON["red"]};
        makeRect(dc, titleRect, colors);
        
        // Title
        var titleY = dc.getHeight() * (yP - 0.05);
        Titles.drawPixelShadowedText(dc, Layout.centerX(dc), titleY, "GAME", 
                                    Graphics.COLOR_WHITE, Color.NEON["red"]);

        var pixel = Layout.getPixelSize(dc, 1);
        titleY += Titles.fontSize * pixel + pixel;
        Titles.drawPixelShadowedText(dc, Layout.centerX(dc), titleY, "OVER", 
                                    Graphics.COLOR_WHITE, Color.NEON["red"]);

        // --- Stats ---
        var highScore = SaveManager.getHighScore(gameName);

        var width = dc.getWidth() * 0.55;
        var height = dc.getHeight() * 0.15;
        if (score > 10000 || highScore >= 10000) {
            width = dc.getWidth() * 0.60;
        }

        var statsFormat = {:background => Graphics.COLOR_BLACK,
                                :border => Color.NEON["red"], 
                                :text => Graphics.COLOR_WHITE,
                                :font => Graphics.FONT_SMALL};

        // Score
        var scoreTitle = ("Score: " + score);
        var scoreY = dc.getWidth() * (yP + 0.2); 
        var scoreRect = {:w => width, :h => height,
                        :x => x, :y => scoreY};
        makeTitleRect(dc, scoreRect, statsFormat, scoreTitle);

        // HighScore
        var highScoreTitle = ("High: " + highScore);
        var highScoreRect = {:w => width, :h => height,
                        :x => x, :y => scoreY + height + Layout.getPixelSize(dc, 2)};
        makeTitleRect(dc, highScoreRect, statsFormat, highScoreTitle);
    }
}