import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.Lang;

import Stackup;

class StackupView extends WatchUi.View {
    var tickTimer as Timer.Timer or Null;
    var tileSize = 18;
    
    function initialize() {
        View.initialize();
        Stackup.initialize();

        // Start ticks
        tickTimer = new Timer.Timer();
        tickTimer.start(method(:onTick), 500, true);
    }

    function onUpdate(dc as Dc) as Void {   
        if (Stackup.active) {
            drawState(dc);
        }
        else {
            Components.makeGameOver(dc, "stackup", Graphics.COLOR_WHITE, Stackup.score);
        }
    }

    function onTick() as Void {
        Stackup.fall();
        WatchUi.requestUpdate();
    }

    function onHide() as Void {
        if (tickTimer != null) {
            tickTimer.stop();
        }
    }

    // --- Draw Funcs ---
    function drawState(dc as Dc) as Void {
        // Background
        dc.setColor(Color.none, Graphics.COLOR_BLACK);
        dc.clear();

        drawGrid(dc);
        drawPreview(dc);

        var baseX = Stackup.originX + Stackup.posX * tileSize;
        var baseY = Stackup.originY + Stackup.posY * tileSize;
        drawPiece(dc, Stackup.curMatrix, baseX, baseY, tileSize, Graphics.COLOR_PINK);
    }

    function drawGrid(dc as Dc) {
        // Grid setup
        var rowsN = Stackup.rowsN;
        var colsN = Stackup.colsN;

        // Working area
        var workX = Layout.workingBufferX;
        var workY = Layout.workingBufferY;
        var workW = Layout.workingWidth(dc);
        var workH = Layout.workingHeight(dc);

        // Grid dimensions and center
        var gridW = colsN * tileSize;
        var gridH = rowsN * tileSize;
        var startX = workX + ((workW - gridW) / 2);
        var startY = workY + ((workH - gridH) / 2);       
        Stackup.originX = startX;
        Stackup.originY = startY;

        // Draw static grid
        var x = startX;
        var y = startY;   
        for (var r = 0; r < rowsN; r++) {
            for (var c = 0; c < colsN; c++) {
                // Draw Tile
                dc.setColor(Graphics.COLOR_BLACK, Color.none);
                dc.fillRectangle(x, y, tileSize, tileSize);
                dc.setColor(Graphics.COLOR_LT_GRAY, Color.none);
                dc.drawRectangle(x, y, tileSize, tileSize);

                x += tileSize;
            }
            x = startX;
            y += tileSize;
        }
    }

    function drawPreview(dc as Dc) {       
        var rectSize = 75;
        var x = 315;
        var y = Layout.centerY(dc) - (rectSize / 2);
        
        // Draw Title
        dc.setColor(Graphics.COLOR_WHITE, Color.none);
        dc.drawText(x, y - 40, Graphics.FONT_XTINY, "NEXT", Graphics.TEXT_JUSTIFY_LEFT);

        // Draw container
        dc.setColor(Graphics.COLOR_DK_GRAY, Color.none);
        dc.fillRectangle(x, y, rectSize, rectSize);
        dc.setColor(Graphics.COLOR_WHITE, Color.none);
        dc.drawRectangle(x, y, rectSize, rectSize);

        // Draw Piece
        var nextPiece = Stackup.SHAPES[Stackup.nextPiece] as Array;
        var pieceSize = 20;
        drawPiece(dc, nextPiece, x, y, pieceSize, Graphics.COLOR_PURPLE);
    }

    function drawPiece(dc as Dc, matrix as Array, baseX, baseY, size, color) {
        for (var r = 0; r < matrix.size(); r++) {
            var row = (matrix as Array)[r] as Array;
            for (var c = 0; c < row.size(); c++) {
                if (row[c] == 1) {
                    // Translate grid coords to screen coords
                    var px = baseX + c * size;
                    var py = baseY + r * size;

                    // Draw
                    dc.setColor(color, Color.none);
                    dc.fillRectangle(px, py, size, size);
                    dc.setColor(color, Color.none);
                    dc.drawRectangle(px, py, size, size);
                }
            }
        }
    }

}