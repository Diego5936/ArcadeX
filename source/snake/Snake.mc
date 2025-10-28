import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Math;

module Snake {
    var gridSize = 15; // HAS to be odd to have a center

    var headPos as Dictionary or Null;
    var snakeSegments as Array or Null;
    var foodPos as Dictionary or Null;

    var direction;
    var nextDirection;

    function initialize() {
        var center = gridSize / 2;
        headPos= {:x => center, :y => center};
        snakeSegments = [];
        
        foodPos = spawnFood();
        direction = null;
        nextDirection = null;
    }

    // Sets food to a new position
    function spawnFood() as Dictionary{
        var validPos = false;
        var randomX = null;
        var randomY = null;

        while (!validPos) {
            randomX = Math.rand() % gridSize;
            randomY = Math.rand() % gridSize;
            
            validPos = !(randomX == headPos[:x] && randomY != headPos[:y]);
        }

        return {:x => randomX, :y => randomY};
    }

    function move() {
        if (nextDirection != null) {
            var hasBody = snakeSegments.size() > 0;

            if (!(hasBody and isOpposite(direction, nextDirection))) {
                direction = nextDirection;
            }
            nextDirection = null;
        }

        if (direction == null) {
            return;
        }

        // Find new position
        var dx = 0;
        var dy = 0;

        if (direction.equals("up")) {
            dy = -1; // negative y = up on screen
        }
        else if (direction.equals("down")) {
            dy = 1;
        }
        else if (direction.equals("right")) {
            dx = 1;
        }
        else if (direction.equals("left")) {
            dx = -1;
        }

        var curHead = headPos as Dictionary;
        var newHead = {
            :x => curHead[:x] + dx,
            :y => curHead[:y] + dy
        };

        // Check for collisions
        if (checkCollisions(newHead)) {
            System.println("Game Over!");
            return;
        }

        // Check if food was eaten
        var ate = (foodPos != null &&
                newHead[:x] == foodPos[:x] &&
                newHead[:y] == foodPos[:y]);

        if (ate) {
            foodPos = spawnFood();
        }

        // Shift body
        var prevX = curHead[:x];
        var prevY = curHead[:y];

        for (var i = 0; i < snakeSegments.size(); i++) {
            var segment = snakeSegments[i] as Dictionary;
            var tempX = segment[:x];
            var tempY = segment[:y];
            segment[:x] = prevX;
            segment[:y] = prevY;
            prevX = tempX;
            prevY = tempY;
        }

        // Grow
        if (ate) {
            var newSegment = {:x => headPos[:x], :y => headPos[:y]};
            snakeSegments.add(newSegment);
        }

        // New head
        headPos = newHead;
    }

    function checkCollisions(head as Dictionary) as Boolean {
        // Wall
        if (head[:x] < 0 || head[:x] >= gridSize ||
            head[:y] < 0 || head[:y] >= gridSize) {
                return true;
            }

        // Self
        for (var i = 0; i < snakeSegments.size(); i++) {
            var segment = snakeSegments[i] as Dictionary;
            if (segment[:x] == head[:x] && segment[:y] == head[:y]) {
                return true;
            }
        }
        return false;
    }

    // Helper Functions
    function setNextDirection(dir as String) as Void {
        nextDirection = dir;
    }

    function isOpposite(a as String or Null, b as String) as Boolean {
    if (a == null) {
        return false;
    }
    
    return (a == "up" and b == "down") or
           (a == "down" and b == "up") or
           (a == "left" and b == "right") or
           (a == "right" and b == "left");
}
}