import Toybox.Graphics;
import Toybox.Math;
import Toybox.Lang;

import MathX;

module Layout {
    function centerX(dc) { return dc.getWidth() / 2; }
    function centerY(dc) { return dc.getHeight() / 2; }

    // ---------- Dynamic grid sizing ----------
    
    // Returns the maximum square size (in pixels) that fits perfectly in a circle
    function getMaxSquareSize(dc as Dc) as Number {
        var diameter = MathX.min(dc.getWidth(), dc.getHeight());
        // Using 0.7 as approximation of 1/√2
        return Math.round(diameter * 0.7);
    }

    // Calculates optimal tile size for a square grid
    // Returns tile size in pixels
    function getSquareGridTileSize(dc as Dc, gridSize as Number) as Number {
        var maxSquareSize = getMaxSquareSize(dc);
        return Math.round(maxSquareSize / gridSize);
    }

    // Calculates optimal tile size for a rectangular grid
    function getRectGridTileSize(dc as Dc, cols as Number, rows as Number) as Number {
        var diameter = MathX.min(dc.getWidth(), dc.getHeight());
        // Calculate diagonal of grid
        var diagonalFactor = Math.sqrt((cols * cols) + (rows * rows)) + 0.5;
        return Math.round(diameter / diagonalFactor);
    }

    // Returns centered start position for a grid
    // Returns Dictionary with :x and :y keys
    function getGridStartPosition(dc as Dc, gridWidth as Number, gridHeight as Number) as Dictionary {
        var startX = (dc.getWidth() - gridWidth) / 2;
        var startY = (dc.getHeight() - gridHeight) / 2;
        return {
            :x => startX,
            :y => startY
        };
    }

    // ---------- Title sizing ----------

    // Returns the title singular block size
    function getPixelSize(dc, n as Number or Float) as Number {
        if (n instanceof Number) {
            return Math.round(dc.getWidth() * 0.015) * n;
        }
        if (n instanceof Float) {
            return (dc.getWidth() * 0.015) * n;
        }
    }

    function getArtSize(dc) as Number {
        return Math.round(dc.getWidth() * 0.019);
    }

    // ---------- Touch Input ----------

    // Regions for touch input
    var leftX;
    var rightX;
    var topY;
    var bottomY;

    function setInputRegions(dc as Dc) {
        leftX = dc.getWidth() * 0.25;
        rightX = dc.getWidth() * 0.75;
        topY = dc.getHeight() * 0.25;
        bottomY = dc.getHeight() * 0.75;
    }

    function determineRegion(x, y) as String{
        var direction = "center";

        if (x <= leftX && y < bottomY && y > topY) {
            direction = "left";
        }
        else if (x >= rightX && y < bottomY && y > topY) {
            direction = "right";
        }
        else if (y <= topY && x > leftX && x < rightX) {
            direction = "up";
        }
        else if (y >= bottomY && x > leftX && x < rightX) {
            direction = "down";
        }

        return direction;
    }
}