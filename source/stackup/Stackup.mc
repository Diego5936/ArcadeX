import Toybox.System;
import Toybox.Lang;
import Toybox.Math;

module Stackup {
    var active; 
    var score;

    var grid as Array or Null; // All static blocks
    var rowsN = 20;
    var colsN = 10;
    var originX = 0;
    var originY = 0;

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

    // --- Game logic ---

    // --- Piece Logic ---
    var bag as Array = [];
    var curPiece;
    var nextPiece;

    // Piece shape + position
    var curMatrix as Array or Null; 
    var posX;
    var posY;

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

    // --- Movement logic ---
    function fall() {
        if (!active) { return; }

        // Try moving down
        if (isValidPosition(posX, posY + 1, curMatrix)) {
            posY += 1;
        }
        else {
            // Landed
            mergePiece();

            // Check for full lines***************************************************************************************
        }
    }

    function hardFall() {
        if (!active) { return; }

        while (isValidPosition(posX, posY + 1, curMatrix)) {
            posY += 1;
        }

        mergePiece();
    }

    function rotate() {
        if (!active || curMatrix == null ) { return; }

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

    // --- Helpers ---
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
    }
}