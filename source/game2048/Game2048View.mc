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
        dc.setColor(Color.none, Color.TILES["big"]);
        dc.clear();

        // Draw score
        dc.setColor(Graphics.COLOR_WHITE, Color.none);
        dc.drawText(Layout.centerX(dc), dc.getHeight() * 0.03, 
                    Graphics.FONT_TINY, "Score: " + Game2048.score, Graphics.TEXT_JUSTIFY_CENTER);

        // Grid
        var gridSize = 4;
        var spacing = 5;
        var baseTileSize = Layout.getSquareGridTileSize(dc, gridSize);
        // Account for spacing between tiles: (gridSize - 1) spaces
        var totalSpacing = (gridSize - 1) * spacing;
        var availableSize = (baseTileSize * gridSize) - totalSpacing;
        var tileSize = Math.round(availableSize / gridSize);
        var gridWidth = (tileSize * gridSize) + totalSpacing;
        var gridHeight = gridWidth;
        var gridPos = Layout.getGridStartPosition(dc, gridWidth, gridHeight);
        var startX = gridPos[:x];
        var startY = gridPos[:y];

        var x = startX;
        var y = startY;

        for (var row = 0; row < 4; row++) {
            var curRow = (Game2048.grid as Array)[row] as Array;

            for (var col = 0; col < 4; col++) {     
                var curTile = curRow[col];

                // Draw Tile
                var tileColor = getTileColor(curTile);
                dc.setColor(tileColor, Color.none);
                dc.fillRectangle(x, y, tileSize, tileSize);
                dc.setColor(Graphics.COLOR_WHITE, Color.none);
                dc.drawRectangle(x, y, tileSize, tileSize);

                // Draw Number
                if (curTile != 0) {
                    dc.setColor(Graphics.COLOR_BLACK, Color.none);
                    var fontSize = curTile > 512 ? Graphics.FONT_SYSTEM_TINY : Graphics.FONT_SYSTEM_SMALL;
                    dc.drawText(x + (tileSize/2), y + (tileSize/6), fontSize, curTile, Graphics.TEXT_JUSTIFY_CENTER);
                }
                
                x += tileSize + spacing;
            }

            x = startX;
            y += tileSize + spacing;
        }
    }

    function getTileColor(tileNumber) as Graphics.ColorType{
        var colorMap = Color.TILES as Dictionary;

        if (tileNumber == 0) {
            return Graphics.COLOR_TRANSPARENT;
        }

        if (colorMap.hasKey(tileNumber)) {
            return colorMap[tileNumber];
        }
        
        return colorMap["big"];
    }
}