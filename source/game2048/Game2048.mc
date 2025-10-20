import Toybox.Lang;
import Toybox.Math;
import Toybox.System;

module Game2048 {
    var grid = [];

    function setStartingGrid() {
        grid = [
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0]
        ];

        var emptyTiles = getEmptyTiles(grid);

        for (var i = 0; i < 2; i++) {
            var randomIdx = Math.rand() % emptyTiles.size();
            var emptyTile = emptyTiles[randomIdx] as Array;
            var row = emptyTile[0];
            var col = emptyTile[1];

            var newGrid = grid as Array;
            var curRow = newGrid[row] as Array;
            curRow[col] = 2;

            emptyTiles.remove(emptyTile);
        }
    }

    function getEmptyTiles(grid as Array) as Array {
        var emptyTiles = [];

        for (var row = 0; row < 4; row++) {
            // Super strict type inference
            var curRow = grid[row] as Array;

            for (var col = 0; col < 4; col++) {
                if (curRow[col] == 0) {
                    emptyTiles.add([row, col]);
                }
            }
        }

        return emptyTiles;
    }

    function slideRight() {
        var newGrid = grid as Array;
        for (var row = 0; row < 4; row++) {
            var curRow = newGrid[row] as Array;

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

            merged = merged.reverse();
            newGrid[row] = merged;
        }
    }
}