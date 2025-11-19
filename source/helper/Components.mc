import Toybox.Graphics;
import Toybox.Lang;

import SaveManager;
import Layout;

module Components {
    // Makes a titled box
    /* Takes in:
        rect as Dictionary {[:x] X-position, [:y] Y-position, [:w] Width, [:h] Height}\
        format as Dictionary {[:background], [:border], [:text], [:font]}
        title of the rect
    */
    function makeRect(dc as Dc, rect as Dictionary, format as Dictionary, title as String) {
        // Rect fillc
        dc.setColor(format[:background], Color.none);
        dc.fillRectangle(rect[:x], rect[:y], rect[:w], rect[:h]);

        // Rect border
        dc.setColor(format[:border], Color.none);
        dc.drawRectangle(rect[:x], rect[:y], rect[:w], rect[:h]);

        // Title
        var titleX = rect[:x] + (rect[:w] / 2);
        dc.setColor(format[:text], Color.none);
        dc.drawText(titleX, rect[:y],
                format[:font], title, Graphics.TEXT_JUSTIFY_CENTER);
    }

    function makeStartButton(dc as Dc, label as String, backColor, border, textColor) as Dictionary {
        var screenW = dc.getWidth();
        var screenH = dc.getHeight();

        // Button sizes
        var x = 0;
        var y = screenH * 0.60;
        var w = screenW;
        var h = screenH - y + 10;

        // Draw "semicircle" in the bottom half
        dc.setColor(backColor, Color.none);
        dc.fillRectangle(x, y, w, h);

        // Border
        dc.setColor(border, Color.none);
        dc.drawRectangle(x, y, w, h);
        
        // Text
        dc.setColor(textColor, Color.none);
        dc.drawText(Layout.centerX(dc), screenH - (h / 1.3), Graphics.FONT_MEDIUM, 
                    label, Graphics.TEXT_JUSTIFY_CENTER);

        return { :x => x, :y => y, :w => w, :h => h };
    }

    function makeDualButtons(dc as Dc, selected, labels, b1, b2) as Array {
        // b1 is the format of the selected button, b2 is the format of the other
        var screenW = dc.getWidth();
        var screenH = dc.getHeight();

        // Button sizes
        var buttonY = screenH * 0.60;
        var bL = {:x => 0, :y => buttonY,
                    :w => screenW / 2, :h => screenH - buttonY + 10};
        var bR = {:x => screenW / 2, :y => buttonY,
                    :w => screenW / 2, :h => screenH - buttonY + 10};

        var bufferX = [13, -15];

        for (var i = 0; i < 2; i++) {
            var cur = (i == 0 ? bL as Dictionary : bR as Dictionary);
            var curf = (selected == i ? b1 as Dictionary : b2 as Dictionary);

            // Draw buttons
            dc.setColor(curf[:backColor], Color.none);
            dc.fillRectangle(cur[:x], cur[:y], cur[:w], cur[:h]);

            // Border
            dc.setColor(curf[:border], Color.none);
            dc.drawRectangle(cur[:x], cur[:y], cur[:w], cur[:h]);

            // Text
            dc.setColor(curf[:textColor], Color.none);
            dc.drawText(cur[:x] + (cur[:w] / 2) + bufferX[i], screenH - (cur[:h] / 1.3), Graphics.FONT_SMALL, 
                        (labels as Array)[i], Graphics.TEXT_JUSTIFY_CENTER);
        }

        return [bL, bR];
    }

    function makeGameOver(dc as Dc, gameName as String, textColor, score as Number) {
        // Game Over Title
        dc.setColor(textColor, Graphics.COLOR_TRANSPARENT);
        dc.drawText(Layout.centerX(dc), Layout.centerY(dc), 
                    Graphics.FONT_SYSTEM_LARGE, "GAME OVER", Graphics.TEXT_JUSTIFY_CENTER);

        // Draw Score
        var scoreTitle = ("Score: " + score);
        dc.drawText(Layout.centerX(dc), Layout.centerY(dc) + 50, 
                    Graphics.FONT_SYSTEM_LARGE, scoreTitle, Graphics.TEXT_JUSTIFY_CENTER);

        var highScore = SaveManager.getHighScore(gameName);
        var highScoreTitle = ("High: " + highScore);
        dc.drawText(Layout.centerX(dc), Layout.centerY(dc) + 100, 
                    Graphics.FONT_SYSTEM_LARGE, highScoreTitle, Graphics.TEXT_JUSTIFY_CENTER);
    }

    function drawHighScore(dc as Dc, gameName as String, borderColor) {
        var highScore = SaveManager.getHighScore(gameName);
        var borderY = 120;

        dc.setColor(borderColor, Color.none);
        dc.drawRectangle(0, -10, dc.getWidth(), borderY);
        
        switch (gameName) {
            case "2048":
                draw2048Score(dc, highScore, borderY);
                break;
            case "snake":
                drawSnakeScore(dc, highScore, borderY);
                break;
            case "stackup":
                drawStackupScore(dc, highScore, borderY);
                break;
        }
    }

    // ---------- Titles ----------
    const LETTERS = {
        "A" => [
            [0,1,1,1,0],
            [1,0,0,0,1],
            [1,1,1,1,1],
            [1,0,0,0,1],
            [1,0,0,0,1]
        ],

        "B" => [
            [1,1,1,1,0],
            [1,0,0,0,1],
            [1,1,1,1,0],
            [1,0,0,0,1],
            [1,1,1,1,0]
        ],

        "C" => [
            [0,1,1,1,1],
            [1,0,0,0,0],
            [1,0,0,0,0],
            [1,0,0,0,0],
            [0,1,1,1,1]
        ],

        "E" => [
            [1,1,1,1,1],
            [1,0,0,0,0],
            [1,1,1,1,0],
            [1,0,0,0,0],
            [1,1,1,1,1]
        ],

        "K" => [
            [1,0,0,1,0],
            [1,0,1,0,0],
            [1,1,0,0,0],
            [1,0,1,0,0],
            [1,0,0,1,0]
        ],

        "P" => [
            [1,1,1,1,0],
            [1,0,0,0,1],
            [1,1,1,1,0],
            [1,0,0,0,0],
            [1,0,0,0,0]
        ],

        "S" => [
            [1,1,1,1,1],
            [1,0,0,0,0],
            [1,1,1,1,1],
            [0,0,0,0,1],
            [1,1,1,1,1]
        ],

        "T" => [
            [1,1,1,1,1],
            [0,0,1,0,0],
            [0,0,1,0,0],
            [0,0,1,0,0],
            [0,0,1,0,0]
        ],

        "U" => [
            [1,0,0,0,1],
            [1,0,0,0,1],
            [1,0,0,0,1],
            [1,0,0,0,1],
            [0,1,1,1,0]
        ]
    };

    // 2048
    function draw2048Title(dc as Dc) {
        var title = ["2", "0", "4", "8"];
        var size = 85;
        var spacing = size + 7;

        var x = Layout.centerX(dc) - ((spacing * title.size()) / 2) + 3;
        var y = Layout.centerY(dc) - 70;
        var buffer = [0, 5, -2, 3];

        var colorMap = Color.TILES as Dictionary;
        var colors = [colorMap[256], colorMap[32], colorMap[512], colorMap[2048]];

        for (var i = 0; i < title.size(); i++) {
            var value = title[i] as String;
            var posX = x + i * spacing;
            var posY = y + buffer[i];

            // Draw Tile
            dc.setColor(colors[i], Color.none);
            dc.fillRectangle(posX, posY, size, size);
            dc.setColor(Graphics.COLOR_WHITE, Color.none);
            dc.drawRectangle(posX, posY, size, size);

            // Draw Number
            dc.setColor(Graphics.COLOR_WHITE, Color.none);
            dc.drawText(posX + (size/2), posY + 10, Graphics.FONT_LARGE, value, Graphics.TEXT_JUSTIFY_CENTER);
        }
    }

    function draw2048Score(dc as Dc, score, borderY) {
        var height = 50;
        var width = 50;

        if (score >= 1000) {
            width = 110;
        }
        else if (score >= 100) {
            width = 90;
        }
        else if (score >= 10) {
            width = 70;
        }

        var x = 100;
        var y = borderY - 65;

        // Draw Title
        dc.setColor(Graphics.COLOR_WHITE, Color.none);
        dc.drawText(x, y, Graphics.FONT_SMALL, "BEST : ", Graphics.TEXT_JUSTIFY_LEFT);

        // Draw tile
        y -= 2;
        var buffer = 135;
        dc.setColor(Color.TILES[2048], Color.none);
        dc.fillRectangle(x + buffer, y, width, height);
        dc.setColor(Graphics.COLOR_WHITE, Color.none);
        dc.drawRectangle(x + buffer, y, width, height);

        // Draw Score Number
        dc.setColor(Graphics.COLOR_WHITE, Color.none);
        dc.drawText(x + buffer + (width/2), y, Graphics.FONT_SMALL, score, Graphics.TEXT_JUSTIFY_CENTER);
    }

    // --- Snake ---
    const SNAKE_TITLE = [
        [0,0,  1,1,1,1,  1,1,  1,0,0,0,0,1,  0,0,  1,1,1,1,  0,  1,1,0,0,1,  0,0,  1,1,1,1,  1,1,0,2],
        [0,0,  1,0,0,0,  0,0,  1,1,0,0,0,1,  0,0,  1,0,0,1,  0,  1,1,0,1,1,  0,0,  1,0,0,0,  0,0,0,0],
        [0,0,  1,0,0,0,  0,0,  1,1,1,0,0,1,  0,0,  1,0,0,1,  0,  1,1,1,1,0,  0,0,  1,0,0,0,  0,0,0,0],
        [0,0,  1,1,1,1,  0,0,  1,0,1,1,0,1,  0,0,  1,1,1,1,  0,  1,1,1,0,0,  0,0,  1,1,1,0,  0,0,0,0],
        [0,0,  0,0,0,1,  0,0,  1,0,0,1,1,1,  0,0,  1,0,0,1,  0,  1,0,1,1,0,  0,0,  1,0,0,0,  0,0,0,0],
        [0,0,  0,0,0,1,  0,0,  1,0,0,0,1,1,  0,0,  1,0,0,1,  0,  1,0,0,1,1,  0,0,  1,0,0,0,  0,0,0,0],
        [1,1,  1,1,1,1,  0,0,  1,0,0,0,0,1,  1,1,  1,0,0,1,  1,  1,0,0,0,1,  1,1,  1,1,1,1,  0,0,0,0]
    ];
    
    function drawSnakeTitle(dc as Dc) {
        var size = 10;
        var x = 30;
        var y = Layout.centerY(dc) - 65;
        drawSnakeMatrix(dc, SNAKE_TITLE, x, y, size);
    }

    const SNAKE_SCORE = [
        [1,1,1,0,  0,  1,1,1,  0,  1,1,1,  0,  1,1,1],
        [1,0,0,1,  0,  1,0,0,  0,  1,0,0,  0,  0,1,0],
        [1,1,1,0,  0,  1,1,0,  0,  1,1,1,  0,  0,1,0],
        [1,0,0,1,  0,  1,0,0,  0,  0,0,1,  0,  0,1,0],
        [1,1,1,1,  0,  1,1,1,  0,  1,1,1,  0,  0,1,0]
    ];

    function drawSnakeScore(dc as Dc, score, borderY) {
        var size = 7;
        var x = 120;
        var y = borderY - 60;
        drawSnakeMatrix(dc, SNAKE_SCORE, x, y, size);

        // Draw Score Number
        dc.setColor(Graphics.COLOR_GREEN, Color.none);
        dc.drawText(x + 125, y - 7, Graphics.FONT_SMALL, (": " + score), Graphics.TEXT_JUSTIFY_LEFT);
    }

    function drawSnakeMatrix(dc as Dc, matrix, x, y, size) {
        for (var r = 0; r < matrix.size(); r++) {
            var row = (matrix as Array)[r] as Array;

            for (var c = 0; c < row.size(); c++) {
                if (row[c] == 0) { continue; }

                var color = Graphics.COLOR_GREEN;
                if (row[c] == 2) {
                    color = Graphics.COLOR_RED;
                }

                var px = x + c * size;
                var py = y + r * size;

                // Block fill
                dc.setColor(color, Color.none);
                dc.fillRectangle(px, py, size, size);

                // Outline
                dc.setColor(Graphics.COLOR_BLACK, Color.none);
                dc.drawRectangle(px, py, size, size);
            }
        }
    }


    // --- Stackup ---
    const LETTER_COLORS = {
        "A" => Color.STACKS["J"],
        "B" => Color.STACKS["I"],
        "C" => Color.STACKS["O"],
        "E" => Color.STACKS["O"],
        "K" => Color.STACKS["I"],
        "P" => Color.STACKS["Z"],
        "S" => Color.STACKS["S"],
        "T" => Color.STACKS["T"],
        "U" => Color.STACKS["L"],
    };

    function drawStackupTitle(dc as Dc) {
        var title = ["S", "T", "A", "C", "K", "U", "P"];

        var size = 10;
        var spacing = (size * 5) + 2;
        var word_space = 0;

        var x = 25;
        var y = Layout.centerY(dc) - 55;

        for (var i = 0; i < title.size(); i++) {
            var letter = title[i] as String;
            
            if ( i == 5) { word_space = 2; }

            var posX = x + i * (spacing + word_space);
            drawLetter(dc, letter, LETTER_COLORS[letter], posX, y, size);
        }
    }

    function drawStackupScore(dc as Dc, score, borderY) {
        var scoreTitle = ["B", "E", "S", "T"];
        
        var size = 7;
        var spacing = (size * 5) + 2;

        var x = 100;
        var y = borderY - 60;

        for (var i = 0; i < scoreTitle.size(); i++) {
            var letter = scoreTitle[i] as String;

            var posX = x + i * spacing;
            drawLetter(dc, letter, LETTER_COLORS[letter], posX, y, size);
        }

        // Draw Score Number
        dc.setColor(Color.STACKS["O"], Color.none);
        dc.drawText(x + 155, y - 7, Graphics.FONT_SMALL, (": " + score), Graphics.TEXT_JUSTIFY_LEFT);
    }

    function drawLetter(dc as Dc, letter as String, color, x, y, size) {
        if (!LETTERS.hasKey(letter)) { return; }

        var matrix = LETTERS[letter] as Array;

        for (var r = 0; r < matrix.size(); r++) {
            var row = (matrix as Array)[r] as Array;

            for (var c = 0; c < row.size(); c++) {
                if (row[c] == 1) {
                    var px = x + c * size;
                    var py = y + r * size;

                    // Block fill
                    dc.setColor(color, Color.none);
                    dc.fillRectangle(px, py, size, size);

                    // Outline
                    dc.setColor(Graphics.COLOR_BLACK, Color.none);
                    dc.drawRectangle(px, py, size, size);
                }
            }
        }
    }
}