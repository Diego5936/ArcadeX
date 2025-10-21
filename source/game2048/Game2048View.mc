import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Lang;

import Game2048;
import Layout;
import Color;

class Game2048View extends WatchUi.View {
    function initialize() {
        View.initialize();
        Game2048.setStartingGrid();
    }

    function onUpdate(dc as Dc) as Void {   
        drawGrid(dc);
    }

    function drawGrid(dc as Dc) as Void {
        // Background
        dc.setColor(Color.none, Graphics.COLOR_BLACK);
        dc.clear();

        var margin = Layout.workingBuffer;
        var spacing = 5;
        var x = margin;
        var y = margin + 10;
        var tileWidth = (Layout.workingWidth(dc) - (4 * spacing)) / 4;
        var tileHeight = (Layout.workingHeight(dc) - (4* spacing)) / 4;

        for (var row = 0; row < 4; row++) {
            var curRow = (Game2048.grid as Array)[row] as Array;

            for (var col = 0; col < 4; col++) {     
                var curTile = curRow[col];

                // Draw Tile
                var tileColor = setTileColor(curTile);
                dc.setColor(tileColor, Color.none);
                dc.fillRectangle(x, y, tileWidth, tileHeight);
                dc.setColor(Graphics.COLOR_WHITE, Color.none);
                dc.drawRectangle(x, y, tileWidth, tileHeight);

                // Draw Number
                if (curTile != 0) {
                    dc.setColor(Graphics.COLOR_BLACK, Color.none);
                    var fontSize = curTile > 512 ? Graphics.FONT_SYSTEM_TINY : Graphics.FONT_SYSTEM_SMALL;
                    dc.drawText(x + (tileWidth/2), y + (tileHeight/6), fontSize, curTile, Graphics.TEXT_JUSTIFY_CENTER);
                }
                
                x += tileWidth + spacing;
            }

            x = margin;
            y += tileHeight + spacing;
        }
    }

    function setTileColor(tileNumber) as Graphics.ColorType{
        switch(tileNumber) {
            case 0:
                return Graphics.COLOR_TRANSPARENT;
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