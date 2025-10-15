import Toybox.Lang;
import Toybox.Math;

module Game2048 {
    function getStartingGrid() as Array {
        var grid = [
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0]
        ];

        for (var i = 0; i < 2; i++) {
            var emptyTile = getEmptyTile(grid);
            var row = emptyTile[0];
            var col = emptyTile[1];

            grid[row][col] = 2;
        }
        
        return grid;
    }

    function getEmptyTile(grid as Array) as Array {
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

        var randomIdx = Math.rand() % emptyTiles.size();
        return emptyTiles[randomIdx];
    }
}