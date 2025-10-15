import Toybox.WatchUi;
import Toybox.Graphics;

import Layout;

class Game2048View extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    function onUpdate(dc as Dc) as Void {   
        drawGrid(dc);
    }

    function drawGrid(dc as Dc) as Void {
        // Background
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_LT_GRAY);
        dc.clear();

        var margin = Layout.workingBuffer;
        var spacing = 5;
        var x = margin;
        var y = margin + 10;
        var tileWidth = (Layout.workingWidth(dc) - (4 * spacing)) / 4;
        var tileHeight = (Layout.workingHeight(dc) - (4* spacing)) / 4;
        System.println("tileWidth = " + tileWidth);

        var grid = [
            [0, 0, 2, 0],
            [0, 0, 0, 0],
            [0, 4, 0, 16],
            [512, 1024, 8, 2048]
        ];

        for (var row = 0; row < 4; row++) {
            for (var col = 0; col < 4; col++) {
                // Draw Tile
                var tileColor = setTileColor(grid[row][col]);
                dc.setColor(tileColor, Graphics.COLOR_BLACK);
                dc.fillRectangle(x, y, tileWidth, tileHeight);
                // Draw Number
                dc.setColor(Graphics.COLOR_BLACK, tileColor);
                var fontSize = grid[row][col] > 512 ? Graphics.FONT_SYSTEM_TINY : Graphics.FONT_SYSTEM_SMALL;
                dc.drawText(x + (tileWidth/2), y + (tileHeight/6), fontSize, grid[row][col], Graphics.TEXT_JUSTIFY_CENTER);

                x += tileWidth + spacing;
            }

            x = margin;
            y += tileHeight + spacing;
        }
    }

    function setTileColor(tileNumber) as Graphics.ColorType{
        switch(tileNumber) {
            case 0:
                return Graphics.COLOR_BLACK;
            case 2:
                return Graphics.COLOR_WHITE;
            case 4:
                return Graphics.COLOR_YELLOW;
            case 8:
                return Graphics.COLOR_ORANGE;
            case 16:
                return Graphics.COLOR_RED;
            case 32:
                return Graphics.COLOR_WHITE;
            case 64:
                return Graphics.COLOR_BLUE;
            case 128:
                return Graphics.COLOR_DK_BLUE;
            case 256:
                return Graphics.COLOR_PURPLE;
            case 512:
                return Graphics.COLOR_GREEN;
            case 1024:
                return Graphics.COLOR_DK_GREEN;
            case 2048:
                return Graphics.COLOR_PINK;
            default:
                return Graphics.COLOR_BLACK;
        }
    }
}