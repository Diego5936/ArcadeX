import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Math;

module Snake {
    var gridSize = 15; // HAS to be odd to have a center

    var headPosition as Dictionary or Null;
    var snakeSegments;
    var foodPosition;

    var direction;

    function initialize() {
        var center = gridSize / 2;
        headPosition= {:x => center, :y => center};
        snakeSegments = [];
        
        foodPosition = spawnFood();
        direction = null;
    }

    function spawnFood() as Dictionary{
        var validPos = false;
        var randomX = null;
        var randomY = null;

        while (!validPos) {
            randomX = Math.rand() % gridSize;
            randomY = Math.rand() % gridSize;
            
            validPos = randomX != headPosition[:x] && randomY != headPosition[:y];
        }

        return {:x => randomX, :y => randomY};
    }
}