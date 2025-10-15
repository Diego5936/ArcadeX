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
            [0, 0, 0, 0],
            [0, 0, 0, 0]
        ];

        for (var row = 0; row < 4; row++) {
            for (var col = 0; col < 4; col++) {
                // Draw Tile
                dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
                dc.fillRectangle(x, y, tileWidth, tileHeight);
                drawTileNumber(dc, grid, x, y, row, col);

                x += tileWidth + spacing;
            }

            x = margin;
            y += tileHeight + spacing;
        }
    }

    function drawTileNumber(dc as Dc, grid, x, y, row, col) as Void {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_YELLOW);
        dc.drawText(x, y, Graphics.FONT_TINY, grid[row][col], Graphics.TEXT_JUSTIFY_CENTER);
    }
}