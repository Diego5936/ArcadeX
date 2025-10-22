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
}