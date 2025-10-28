import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.Timer;

import Snake;

class SnakeView extends WatchUi.View {
    var tickTimer as Timer.Timer or Null;
    
    function initialize() {
        View.initialize();
        Snake.initialize();

        // Start ticks
        tickTimer = new Timer.Timer();
        tickTimer.start(method(:onTick), 500, true);

    }

    function onUpdate(dc as Dc) as Void {   
        if (Snake.active) {
            drawState(dc);
        }
        else {
            Components.makeGameOver(dc, "snake", Graphics.COLOR_WHITE, Snake.score);
        }
    }

    function onTick() as Void {
        Snake.move();
        WatchUi.requestUpdate();
    }

    function onHide() as Void {
        if (tickTimer != null) {
            tickTimer.stop();
        }
    }

    function drawState(dc as Dc) as Void {
        // Background
        dc.setColor(Color.none, Graphics.COLOR_BLACK);
        dc.clear();

        // Grid
        var gridSize = Snake.gridSize;
        var marginX = Layout.workingBufferX;
        var marginY = Layout.workingBufferY;
        var tileWidth = (Layout.workingWidth(dc) - gridSize) / gridSize + 1;
        var tileHeight = (Layout.workingHeight(dc) - gridSize) / gridSize + 2;

        dc.setColor(Graphics.COLOR_WHITE, Color.none);
        dc.drawRectangle(marginX, marginY, tileWidth * gridSize, tileHeight * gridSize);

        // Snake's head
        var head = Snake.headPos as Dictionary;
        dc.setColor(Graphics.COLOR_GREEN, Color.none);
        dc.fillRectangle(marginX + (head[:x] * tileWidth), marginY + (head[:y] * tileHeight), tileWidth, tileHeight);

        // Snake's body
        for (var i = 0; i < Snake.snakeSegments.size(); i++) {
            var segment = (Snake.snakeSegments as Array)[i];
            dc.fillRectangle(marginX + ((segment as Dictionary)[:x] * tileWidth), marginY + 
                            ((segment as Dictionary)[:y] * tileHeight), tileWidth, tileHeight);
        }

        // Food
        var food = Snake.foodPos as Dictionary;
        dc.setColor(Graphics.COLOR_RED, Color.none);
        dc.fillRectangle(marginX + (food[:x] * tileWidth), marginY + (food[:y] * tileHeight), tileWidth, tileHeight);
    }
}