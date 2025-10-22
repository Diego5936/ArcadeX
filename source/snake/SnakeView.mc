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
        var gridSize = 15;
        var marginX = Layout.workingBufferX;
        var marginY = Layout.workingBufferY;
        var tileWidth = (Layout.workingWidth(dc) - gridSize) / gridSize + 1;
        var tileHeight = (Layout.workingHeight(dc) - gridSize) / gridSize + 2;
        
        // var x = marginX;
        // var y = marginY;
        // for (var r = 0; r < gridSize; r++) {
        //     for (var c = 0; c < gridSize; c++) {
        //         System.println("tile " + r + "x" + c + ": x" + x + ", y" + y);
        //         dc.setColor(Graphics.COLOR_BLACK, Color.none);
        //         dc.fillRectangle(x, y, tileWidth, tileHeight);
        //         dc.setColor(Graphics.COLOR_WHITE, Color.none);
        //         dc.drawRectangle(x, y, tileWidth, tileHeight);

        //         x += tileWidth;
        //     }

        //     x = marginX;
        //     y += tileHeight;
        // }

        dc.setColor(Graphics.COLOR_WHITE, Color.none);
        dc.drawRectangle(marginX, marginY, tileWidth * gridSize, tileHeight * gridSize);

        // Snake's head
        var head = Snake.headPosition as Dictionary;
        dc.setColor(Graphics.COLOR_GREEN, Color.none);
        System.println(head[:x] + " " + head[:y]);
        dc.fillRectangle(marginX + (head[:x] * tileWidth), marginY + (head[:y] * tileHeight), tileWidth, tileHeight);
    }
}