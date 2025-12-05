import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.Lang;

import Stackup;

class StackupView extends WatchUi.View {
    var tickTimer as Timer.Timer or Null;
    var tileSize;
    
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

    // ---------- Draw Funcs ----------

    // Main
    function drawState(dc as Dc) as Void {
        // Background
        dc.setColor(Color.none, Graphics.COLOR_BLACK);
        dc.clear();

        // Calculate dynamic tile size for rectangular grid
        tileSize = Layout.getRectGridTileSize(dc, Stackup.colsN, Stackup.rowsN);

        drawGrid(dc);
        drawPieceGrid(dc, dc.getWidth() * 0.75, "NEXT", Stackup.nextPiece);
        drawPieceGrid(dc, dc.getWidth() * 0.08, "SAVE", Stackup.savedPiece);

        drawPiece(dc, Stackup.curPiece, Stackup.posX, Stackup.posY, tileSize, true);
    }

    // --- Sub-sections ---

    function drawGrid(dc as Dc) {
        // Grid setup
        var rowsN = Stackup.rowsN;
        var colsN = Stackup.colsN;

        // Grid dimensions and center
        var gridW = colsN * tileSize;
        var gridH = rowsN * tileSize;
        var gridPos = Layout.getGridStartPosition(dc, gridW, gridH);
        var startX = gridPos[:x];
        var startY = gridPos[:y];
        Stackup.originX = startX;
        Stackup.originY = startY;

        // Draw static grid
        var x = startX;
        var y = startY;   
        for (var r = 0; r < rowsN; r++) {
            for (var c = 0; c < colsN; c++) {
                var curTile = ((Stackup.grid as Array)[r] as Array)[c];
                var tileColor = Graphics.COLOR_BLACK;

                // Get color
                if (Stackup.SHAPES.hasKey(curTile)) {
                    var colorMap = Color.STACKS as Dictionary;
                    tileColor = colorMap[curTile];
                }

                // Draw tile
                dc.setColor(tileColor, Color.none);
                dc.fillRectangle(x, y, tileSize, tileSize);
                dc.setColor(Graphics.COLOR_LT_GRAY, Color.none);
                dc.drawRectangle(x, y, tileSize, tileSize);
                
                x += tileSize;
            }
            x = startX;
            y += tileSize;
        }
    }

    function drawPieceGrid(dc as Dc, x, title, piece){
        var pieceSize = Math.round(tileSize * 0.75);
        var rectSize = 4 * pieceSize + pieceSize;
        var y = Layout.centerY(dc) - (rectSize / 2);
        
        // Draw Title
        dc.setColor(Graphics.COLOR_WHITE, Color.none);
        dc.drawText(x, y - (rectSize / 2), Graphics.FONT_XTINY, title, Graphics.TEXT_JUSTIFY_LEFT);

        // Draw container
        dc.setColor(Graphics.COLOR_DK_GRAY, Color.none);
        dc.fillRectangle(x, y, rectSize, rectSize);
        dc.setColor(Graphics.COLOR_WHITE, Color.none);
        dc.drawRectangle(x, y, rectSize, rectSize);

        // Draw Piece
        if (piece == null) { return; }

        var matrix = (Stackup.SHAPES as Dictionary)[piece] as Array;

        var rows = matrix.size();
        var cols = matrix[0].size();

        var pieceW = cols * pieceSize;
        var pieceH = rows * pieceSize;

        var centerX = x + (rectSize / 2);
        var centerY = y + (rectSize / 2);

        var startX = centerX - (pieceW / 2);
        var startY = centerY - (pieceH / 2);
        
        drawPiece(dc, piece, startX, startY, pieceSize, false);
    }

    // ---------- Helper Draw ----------

    // If useGrid == true: x,y are grid coords, so convert to pixels
    // If useGrid == false: x,y are pixel coords, use as is
    function drawPiece(dc as Dc, pieceId as String, x, y, size, useGrid as Boolean) {
        var matrix;

        // Get piece
        if (useGrid && pieceId == Stackup.curPiece) {
            matrix = Stackup.curMatrix;
        }
        else {
            matrix = (Stackup.SHAPES as Dictionary)[pieceId] as Array;
        }

        // Get piece color
        var colorMap = Color.STACKS as Dictionary;
        var pieceColor = Graphics.COLOR_WHITE;
        if (colorMap.hasKey(pieceId)) {
            pieceColor = colorMap[pieceId] as Number;
        }

        // Calculate base position
        var baseX = useGrid ? Stackup.originX + x * size : x;
        var baseY = useGrid ? Stackup.originY + y * size : y;
        
        // Draw piece
        for (var r = 0; r < matrix.size(); r++) {
            var row = (matrix as Array)[r] as Array;
            for (var c = 0; c < row.size(); c++) {
                if (row[c] == 1) {
                    // Translate grid coords to screen coords
                    var px = baseX + c * size;
                    var py = baseY + r * size;

                    // Draw
                    dc.setColor(pieceColor, Color.none);
                    dc.fillRectangle(px, py, size, size);
                    dc.setColor(Graphics.COLOR_BLACK, Color.none);
                    dc.drawRectangle(px, py, size, size);
                }
            }
        }
    }

}