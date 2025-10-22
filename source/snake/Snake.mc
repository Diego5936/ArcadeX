import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Math;

module Snake {
    var gridSize = 15; // HAS to be odd to have a center

    var headPos as Dictionary or Null;
    var snakeSegments;
    var foodPos as Dictionary or Null;

    var direction;

    function initialize() {
        var center = gridSize / 2;
        headPos= {:x => center, :y => center};
        snakeSegments = [];
        
        foodPos = spawnFood();
        direction = null;
    }

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
        if (direction == null) {
            return;
        }

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
        if (newHead[:x] == foodPos[:x] && newHead[:y] == foodPos[:y]) {
            foodPos = spawnFood();
        }

        headPos = newHead;
    }

    function checkCollisions(head as Dictionary) as Boolean {
        // Wall
        if (head[:x] < 0 || head[:x] >= gridSize ||
            head[:y] < 0 || head[:y] >= gridSize) {
                return true;
            }

        // Self
        return false;
    }
}