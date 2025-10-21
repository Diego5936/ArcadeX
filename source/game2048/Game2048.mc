import Toybox.Lang;
import Toybox.Math;
import Toybox.System;

module Game2048 {
    var grid = [];

    // Initializes the global grid with two random '2' tiles
    function setStartingGrid() {
        grid = [
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0]
        ];

        var emptyTiles = getEmptyTiles();

        for (var i = 0; i < 2; i++) {
            var randomIdx = Math.rand() % emptyTiles.size();
            var emptyTile = emptyTiles[randomIdx] as Array;
            var row = emptyTile[0];
            var col = emptyTile[1];

            var curRow = (grid as Array)[row] as Array;
            curRow[col] = 2;

            emptyTiles.remove(emptyTile);
        }
    }

    // Adds a new tile after action
    // Odds: 90% '2', 10% '4'
    function spawnNewTile() {
        var emptyTiles = getEmptyTiles();

        // Find random location
        var randomIdx = Math.rand() % emptyTiles.size();
        var emptyTile = emptyTiles[randomIdx] as Array;
        var row = emptyTile[0];
        var col = emptyTile[1];

        // Find tile value
        var odds = Math.rand() % 100;
        var tileVal = odds > 90 ? 4 : 2;

        var curRow = (grid as Array)[row] as Array;
        curRow[col] = tileVal;
    }

    // Returns an array of the empty tiles in the global grid
    function getEmptyTiles() as Array {
        var emptyTiles = [];

        for (var row = 0; row < 4; row++) {
            // Super strict type inference
            var curRow = (grid as Array)[row] as Array;

            for (var col = 0; col < 4; col++) {
                if (curRow[col] == 0) {
                    emptyTiles.add([row, col]);
                }
            }
        }

        return emptyTiles;
    }

    // Slides left or right
    function slideHorizontally(direction as String) {
        var slideRight = direction.equals("right");

        for (var row = 0; row < 4; row++) {
            var curRow = (grid as Array)[row] as Array;

            // If left then reverse first to keep same merge logic
            if (!slideRight) {
                curRow = curRow.reverse();
            }

            // Filter out zeros
            var nonZero = [];
            for (var i = 0; i < curRow.size(); i++) {
                if (curRow[i] != 0) {
                    nonZero.add(curRow[i]);
                }
            }

            // Merge
            var merged = [];
            var i = nonZero.size() - 1;
            while (i >= 0) {
                if (i > 0 && nonZero[i] == nonZero[i - 1]) {
                    merged.add(nonZero[i] * 2);
                    i -= 2;
                } 
                else {
                    merged.add(nonZero[i]);
                    i -= 1;
                }
            }

            // Pad zeros
            while (merged.size() < 4) {
                merged.add(0);
            }

            // If slide right then reverse to complete
            if (slideRight) {
                merged = merged.reverse();
            }
            
            (grid as Array)[row] = merged;
        }
    }

    // Slides up or down
    function slideVertically(direction as String) {
        var slideDown = direction.equals("down");

        for (var col = 0; col < 4; col++) {
            // Transform column into array
            var curCol = [];
            for (var r = 0; r < 4; r++) {
                var curRow = (grid as Array)[r] as Array;
                curCol.add(curRow[col]);
            }

            // Up = reverse first
            if (!slideDown) {
                curCol = curCol.reverse();
            }

            // Filter out zeros
            var nonZero = [];
            for (var i = 0; i < curCol.size(); i++) {
                if (curCol[i] != 0) {
                    nonZero.add(curCol[i]);
                }
            }

            // Merge
            var merged = [];
            var i = nonZero.size() - 1;
            while (i >= 0) {
                if (i > 0 && nonZero[i] == nonZero[i - 1]) {
                    merged.add(nonZero[i] * 2);
                    i -= 2;
                } 
                else {
                    merged.add(nonZero[i]);
                    i -= 1;
                }
            }

            // Pad zeros
            while (merged.size() < 4) {
                merged.add(0);
            }

            // If slide down then reverse to complete
            if (slideDown) {
                merged = merged.reverse();
            }
            
            // Write back into grid
            for (var r = 0; r < 4; r++) {
                var curRow = (grid as Array)[r] as Array;
                curRow[col] = merged[r];
            }
        }
    }
}