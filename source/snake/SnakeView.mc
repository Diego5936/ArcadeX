import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.Lang;

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

        // Draw score
        dc.setColor(Graphics.COLOR_GREEN, Color.none);
        dc.drawText(Layout.centerX(dc), dc.getHeight() * 0.03, 
                    Graphics.FONT_TINY, "Score: " + Snake.score, Graphics.TEXT_JUSTIFY_CENTER);

        // Grid
        var gridSize = Snake.gridSize;
        var tileSize = Layout.getSquareGridTileSize(dc, gridSize);
        var gridWidth = tileSize * gridSize;
        var gridHeight = tileSize * gridSize;
        var gridPos = Layout.getGridStartPosition(dc, gridWidth, gridHeight);
        var marginX = gridPos[:x];
        var marginY = gridPos[:y];

        dc.setColor(Graphics.COLOR_WHITE, Color.none);
        dc.drawRectangle(marginX, marginY, gridWidth, gridHeight);

        // Snake's head
        var head = Snake.headPos as Dictionary;
        dc.setColor(Graphics.COLOR_GREEN, Color.none);
        dc.fillRectangle(marginX + (head[:x] * tileSize), marginY + (head[:y] * tileSize), tileSize, tileSize);

        // Snake's body
        for (var i = 0; i < Snake.snakeSegments.size(); i++) {
            var segment = (Snake.snakeSegments as Array)[i];
            dc.fillRectangle(marginX + ((segment as Dictionary)[:x] * tileSize), marginY + 
                            ((segment as Dictionary)[:y] * tileSize), tileSize, tileSize);
        }

        // Food
        var food = Snake.foodPos as Dictionary;
        dc.setColor(Graphics.COLOR_RED, Color.none);
        dc.fillRectangle(marginX + (food[:x] * tileSize), marginY + (food[:y] * tileSize), tileSize, tileSize);
    }
}