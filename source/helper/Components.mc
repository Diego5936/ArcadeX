import Toybox.Graphics;
import Toybox.Lang;

import Layout;

module Components {
    function makeMenuButtons(dc as Dc, games as Array, initY as Number) as Array {
        var buttons = [];
        
        var backgroundColor = Graphics.COLOR_BLACK;
        var borderColor = Graphics.COLOR_RED;
        var textColor = Graphics.COLOR_WHITE;

        var buttonWidth = 190;
        var buttonHeight = 60;
        var buttonX = Layout.centerX(dc) - (buttonWidth / 2);
        
        // Draw loop
        for (var i = 0; i < games.size(); i++) {
            var buttonY = initY + (i * buttonHeight) + (i * 10);
            
            // Rect fill
            dc.setColor(backgroundColor, Color.none);
            dc.fillRectangle(buttonX, buttonY, buttonWidth, buttonHeight);

            // Rect border
            dc.setColor(borderColor, Color.none);
            dc.drawRectangle(buttonX, buttonY, buttonWidth, buttonHeight);

            // Title
            dc.setColor(textColor, Color.none);
            dc.drawText(Layout.centerX(dc), buttonY + 10,
                    Graphics.FONT_TINY, games[i], Graphics.TEXT_JUSTIFY_CENTER);

            // Store button data
            buttons.add({
                :name => games[i],
                :w => buttonWidth,
                :h => buttonHeight,
                :x => buttonX,
                :y => buttonY
            });
        }

        return buttons;
    }

    function makeStartButton (dc as Dc, label as String, backColor, border, textColor) as Dictionary {
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
}