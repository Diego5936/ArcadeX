import Toybox.System;
import Toybox.Lang;
import Toybox.Math;

module Stackup {
    // Game state
    var active; 
    var score;

    // Grid data
    var grid as Array or Null; // All static blocks
    var rowsN = 20;
    var colsN = 10;
    var originX = 0;
    var originY = 0;

    // Pieces
    var bag as Array = [];
    var curPiece;
    var nextPiece;
    var savedPiece;
    var savedUsed = false;

    // Piece shape + position
    var curMatrix as Array or Null; 
    var posX;
    var posY;

    function initialize() {
        active = true;
        score = 0;

        // Set grid as empty
        grid = [];
        for (var r = 0; r < rowsN; r++) {
            var row = [];
            for (var c = 0; c < colsN; c++) {
                row.add(0);
            }
            grid.add(row);
        }

        // Bag setup
        refillBag();
        curPiece = getNextPiece();
        nextPiece = getNextPiece();
        savedPiece = null;

        spawnPiece();
    }

    const SHAPES = {
        "I" => [
            [0,0,0,0],
            [1,1,1,1],
            [0,0,0,0],
            [0,0,0,0]
        ],

        "O" => [
            [1,1],
            [1,1]
        ],

        "T" => [
            [0,1,0],
            [1,1,1],
            [0,0,0]
        ],

        "S" => [
            [0,1,1],
            [1,1,0],
            [0,0,0]
        ],

        "Z" => [
            [1,1,0],
            [0,1,1],
            [0,0,0]
        ],

        "J" => [
            [1,0,0],
            [1,1,1],
            [0,0,0]
        ],

        "L" => [
            [0,0,1],
            [1,1,1],
            [0,0,0]
        ]
    };

    // ---------- Game logic ----------
    function land() {
        mergePiece();
        removeRows(checkCompleteRow());
    }

    function checkCompleteRow() as Array {
        var fullRows = [];

        for (var r = 0; r < rowsN; r++) {
            var isFull = true;
            var row = (grid as Array)[r] as Array;

            for (var c = 0; c < colsN; c++) {
                if (row[c] == 0) {
                    isFull = false;
                    break;
                }
            }

            if (isFull) {
                fullRows.add(r);
            }
        }

        return fullRows;
    }

    function removeRows(rowsToRemove as Array) {
        if (rowsToRemove.size() == 0) { return; }

        // Dic for fast checking
        var removeMap = {};
        for (var i = 0; i < rowsToRemove.size(); i++) {
            removeMap[rowsToRemove[i]] = true;
        }

        var newGrid = [];

        // Add all non-removed rows top-down
        for (var r = 0; r < rowsN; r++) {
            if (!removeMap.hasKey(r)) {
                newGrid.add((grid as Array)[r]);
            }
        }

        // Add empty rows at the top
        var cleared = rowsToRemove.size();
        for (var i = 0; i < cleared; i++) {
            var emptyRow = [];
            for (var c = 0; c < colsN; c++) {
                emptyRow.add(0);
            }

            var temp = [emptyRow];
            for (var k = 0; k < newGrid.size(); k++) {
                temp.add(newGrid[k]);
            }

            newGrid = temp;
        }

        
        grid = newGrid;
        score += cleared * 100;
    }

    // ---------- Piece Logic ----------
    // Instead of random selection, we use a shuffled bag method for fairness
    function refillBag() {
        bag = ["I", "O", "T", "S", "Z", "J", "L"];

        // Bag fisher-yates shuffle alg
        for (var i = bag.size() - 1; i > 0; i--) {
            var j = Math.rand() % (i + 1);
            var temp = (bag as Array)[i];
            (bag as Array)[i] = (bag as Array)[j];
            (bag as Array)[j] = temp;
        }
    }

    // Get next shape from bag
    function getNextPiece() as String{
        if (bag == null || bag.size() == 0) {
            refillBag();
        }

        var nextKey = (bag as Array)[0] as String;
        bag.remove(nextKey);
        return nextKey;
    }

    // Place the next piece on proper location
    function spawnPiece() {
        curMatrix = (SHAPES as Dictionary)[curPiece] as Array;

        var row = (curMatrix as Array)[0] as Array;
        var pieceW = row.size();
        posX = (colsN - pieceW) / 2;
        posY = 0;

        if (!isValidPosition(posX, posY, curMatrix)) {
            active = false;
        }
    }

    function savePiece() {
        if (savedUsed == true) { return; }

        savedUsed = true;
        if (savedPiece == null) {
            savedPiece = curPiece;
            curPiece = nextPiece;
            nextPiece = getNextPiece();
            spawnPiece();
        }
        else {
            var temp = curPiece;
            curPiece = savedPiece;
            savedPiece = temp;
            spawnPiece();
        }
    }

    // ---------- Movement logic ----------
    function fall() {
        // Try moving down
        if (isValidPosition(posX, posY + 1, curMatrix)) {
            posY += 1;
        }
        else {
            land();
        }
    }

    function hardFall() {
        while (isValidPosition(posX, posY + 1, curMatrix)) {
            posY += 1;
        }
        land();
    }

    function rotate() {
        if ( curMatrix == null ) { return; }

        var rows = curMatrix.size();
        var cols = curMatrix[0].size();

        var rotated = [];
        var val = 0;
        for (var c = 0; c < cols; c++) {
            var newRow = [];
            for (var r = rows - 1; r >= 0; r--) {
                val = ((curMatrix as Array)[r] as Array)[c];
                newRow.add(val);
            }
            rotated.add(newRow);
        }

        // Check location
        if (isValidPosition(posX, posY, rotated)) {
            curMatrix = rotated;
            return;
        }

        // Try wall kick
        var shifts = [-1, 1, -2, 2];
        for (var i = 0; i < shifts.size(); i++) {
            var dx = shifts[i];
            if (isValidPosition(posX + dx, posY, rotated)) {
                posX += dx;
                curMatrix = rotated;
                return;
            }
        }

        // If not valid, then do nothing
    }

    function moveHorizontally(direction as String) {
        var dx = direction.equals("right") ? 1 : -1;
        var newX = posX + dx;

        if (isValidPosition(newX, posY, curMatrix)) {
            posX = newX;
        }
    }

    // ---------- Helpers ----------
    function isValidPosition(x as Number, y as Number, matrix as Array) as Boolean {
        for (var r = 0; r < matrix.size(); r++) {
            var row = matrix[r] as Array;
            for (var c = 0; c < row.size(); c++) {
                if (row[c] == 1) {
                    var gx = x + c;
                    var gy = y + r;

                    // Bounds check
                    if (gx < 0 || gx >= colsN || gy >= rowsN) {
                        return false;
                    }

                    // Check if overlapping 
                    if (gy >= 0 && (((grid as Array)[gy] as Array)[gx] != 0)) {
                        return false;
                    }
                }
            }
        }
        return true;
    }

    // After piece has reached the bottom it locks it into the grid
    function mergePiece() {
        for (var r = 0; r < curMatrix.size(); r++) {
            var row = (curMatrix as Array)[r] as Array;
            for (var c = 0; c < row.size(); c++) {
                if (row[c] == 1) {
                    var gx = posX + c;
                    var gy = posY + r;
                    if (gy >= 0 && gy < rowsN) {
                        var gridR = (grid as Array)[gy] as Array;
                        gridR[gx] = curPiece;
                    }
                }
            }
        }

        // Spawn next piece
        curPiece = nextPiece;
        nextPiece = getNextPiece();
        spawnPiece();

        savedUsed = false;
    }
}