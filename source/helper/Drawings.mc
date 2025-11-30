import Toybox.Graphics;
import Toybox.Lang;

//Draws pixel art shapes
module Drawings {
    /* COLOR LEGEND:
        0 = Transparent
        1 = Black
        2 = White
        3 = Red
        4 = Neon Blue
    */

    const FILLED_HEART = [
        [0,2,2,2,0,2,2,2,0],
        [2,4,3,3,2,3,3,3,2],
        [2,4,3,3,3,3,2,3,2],
        [2,4,4,3,3,3,2,3,2],
        [0,2,4,4,3,2,3,2,0],
        [0,0,2,4,4,3,2,0,0],
        [0,0,0,2,4,2,0,0,0],
        [0,0,0,0,2,0,0,0,0]        
    ];

    const EMPTY_HEART = [
        [0,2,2,2,0,2,2,2,0],
        [2,0,0,0,2,0,0,0,2],
        [2,0,0,0,0,0,2,0,2],
        [2,0,0,0,0,0,2,0,2],
        [0,2,0,0,0,2,0,2,0],
        [0,0,2,0,0,0,2,0,0],
        [0,0,0,2,0,2,0,0,0],
        [0,0,0,0,2,0,0,0,0]
    ];

    // Draws the given pixel art drawing on the screen. Center aligned
    function drawPixelArt(dc, centerX, centerY, size, drawing) as Dictionary {
        var matrix = drawing as Array;

        var rows = matrix.size();
        var cols = matrix[0].size();

        var width = cols * size;
        var height = rows * size;

        // Top left corner
        var startX = centerX - width  / 2.0;
        var startY = centerY - height / 2.0;

        for (var rowIdx = 0; rowIdx < rows; rowIdx += 1) {
            var row = matrix[rowIdx];
            
            for (var colIdx = 0; colIdx < cols; colIdx += 1) {
                var colorCode = (row as Array)[colIdx];

                if (colorCode != 0) {
                    dc.setColor(Color.PAINT[colorCode], Color.none);
                    dc.fillRectangle(startX + (colIdx * size), startY + (rowIdx * size), size, size);
                }
            }
        }

        return {
            :x => startX,
            :y => startY,
            :width => width,
            :height => height
        };
    }
}