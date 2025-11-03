import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;

class Game2048View extends WatchUi.View {
    function initialize() {
        View.initialize();
        Game2048.initialize();
    }

    function onUpdate(dc as Dc) as Void {   
        if (Game2048.active) {
            drawGrid(dc);
        }
        else {
            Components.makeGameOver(dc, "game2048", Graphics.COLOR_WHITE, Game2048.score);
        }
    }

    function drawGrid(dc as Dc) as Void {
        // Background
        dc.setColor(Color.none, Graphics.COLOR_BLACK);
        dc.clear();

        var margin = Layout.workingBufferX;
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
                return Color.tfe2;
            case 4:
                return Color.tfe4;
            case 8:
                return Color.tfe8;
            case 16:
                return Color.tfe16;
            case 32:
                return Color.tfe32;
            case 64:
                return Color.tfe64;
            case 128:
                return Color.tfe128;
            case 256:
                return Color.tfe256;
            case 512:
                return Color.tfe512;
            case 1024:
                return Color.tfe1024;
            case 2048:
                return Color.tfe2048;
            default:
                return Color.tfeBig;
        }
    }
}