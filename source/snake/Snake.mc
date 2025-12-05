import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Math;

import Toybox.System;

module Snake {

    // ---------- Initialization ----------

    var gridSize = 15; // HAS to be odd to have a center

    var headPos as Dictionary or Null;
    var snakeSegments as Array or Null;
    var foodPos as Dictionary or Null;

    var direction;
    var nextDirection;

    var active;
    var score;

    function initialize() {
        var center = gridSize / 2;
        headPos= {:x => center, :y => center};
        snakeSegments = [];
        
        foodPos = spawnFood();
        direction = null;
        nextDirection = null;

        active = true;
        score = 0;
    }

    // ---------- Input Logic ----------

    function handleInput(input as String) {
        if ((input.equals("enter") || input.equals("center")) && !active) {
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        }
        if (!active){ return; }

        if (input.equals("right") && !isOpposite(direction, "right")) {
            nextDirection = "right";
        }
        else if (input.equals("left") && !isOpposite(direction, "left")) {
            nextDirection = "left";
        }
        else if (input.equals("up") && !isOpposite(direction, "up")) {
            nextDirection = "up";
        }
        else if (input.equals("down") && !isOpposite(direction, "down")) {
            nextDirection = "down";
        }

        WatchUi.requestUpdate();
    }

    // ---------- Game Logic ----------

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

    // ---------- Movement Logic ----------

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
            active = false;
            SaveManager.setHighScore("snake", score);
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
            score++;
        }

        // New head
        headPos = newHead;
    }

    // ---------- Helper Functions ----------

    // Checks for collisions with walls or self
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

    // Check if two directions are opposites
    function isOpposite(a as String or Null, b as String or Null) as Boolean {
        if (a == null || b == null) {
            return false;
        }
        
        return (a.equals("up") && b.equals("down")) ||
            (a.equals("down") && b.equals("up")) ||
            (a.equals("left") && b.equals("right")) ||
            (a.equals("right") && b.equals("left"));
        }
}