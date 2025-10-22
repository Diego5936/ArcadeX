import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;

import Snake;

class SnakeView extends WatchUi.View {
    function initialize() {
        View.initialize();
        Snake.initialize();
    }

    function onUpdate(dc as Dc) as Void {   
        drawState(dc);
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
        var head = Snake.headPosition as Dictionary;
        dc.setColor(Graphics.COLOR_GREEN, Color.none);
        dc.fillRectangle(marginX + (head[:x] * tileWidth), marginY + (head[:y] * tileHeight), tileWidth, tileHeight);

        // Food
        var food = Snake.foodPosition as Dictionary;
        dc.setColor(Graphics.COLOR_RED, Color.none);
        dc.fillRectangle(marginX + (food[:x] * tileWidth), marginY + (food[:y] * tileHeight), tileWidth, tileHeight);
    }
}