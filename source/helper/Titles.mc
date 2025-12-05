import Toybox.Graphics;
import Toybox.Lang;

import Toybox.System;

module Titles {

    // ---------- Fonts ----------

    var fontSize = 5;
    const LETTERS = {
        "A" => [
            [0,1,1,1,0],
            [1,0,0,0,1],
            [1,0,0,0,1],
            [1,1,1,1,1],
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

        "D" => [
            [1,1,1,1,0],
            [1,0,0,0,1],
            [1,0,0,0,1],
            [1,0,0,0,1],
            [1,1,1,1,0]
        ],

        "E" => [
            [1,1,1,1,1],
            [1,0,0,0,0],
            [1,1,1,1,0],
            [1,0,0,0,0],
            [1,1,1,1,1]
        ],

        "G" => [
            [0,1,1,1,1],
            [1,0,0,0,0],
            [1,0,1,1,0],
            [1,0,0,0,1],
            [0,1,1,1,1]
        ],

        "K" => [
            [1,0,0,1,0],
            [1,0,1,0,0],
            [1,1,0,0,0],
            [1,0,1,0,0],
            [1,0,0,1,0]
        ],

        "M" => [
            [1,0,0,0,1],
            [1,1,0,1,1],
            [1,0,1,0,1],
            [1,0,0,0,1],
            [1,0,0,0,1]
        ],

        "O" => [
            [0,1,1,1,0],
            [1,0,0,0,1],
            [1,0,0,0,1],
            [1,0,0,0,1],
            [0,1,1,1,0]
        ],

        "P" => [
            [1,1,1,1,0],
            [1,0,0,0,1],
            [1,0,0,0,1],
            [1,1,1,1,0],
            [1,0,0,0,0]
        ],

        "R" => [
            [1,1,1,1,0],
            [1,0,0,0,1],
            [1,0,0,0,1],
            [1,1,1,1,0],
            [1,0,0,0,1]
        ],

        "S" => [
            [0,1,1,1,1],
            [1,0,0,0,0],
            [0,1,1,1,0],
            [0,0,0,0,1],
            [1,1,1,1,0]
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
        ],

        "V" => [
            [1,0,0,0,1],
            [1,0,0,0,1],
            [0,1,0,1,0],
            [0,1,0,1,0],
            [0,0,1,0,0]
        ],

        "X" => [
            [1,0,0,0,1],
            [0,1,0,1,0],
            [0,0,1,0,0],
            [0,1,0,1,0],
            [1,0,0,0,1]
        ]
    };

    // Draws pixel art with a shadown. Center aligned
    function drawPixelShadowedText(dc as Dc, centerX, centerY, text as String, color, shadow) {
        // Shadow first
        var offset = 2;
        drawPixelText(dc, centerX + offset, centerY + offset, text, shadow);

        // Main text on top
        drawPixelText(dc, centerX, centerY, text, color);
    }

    function drawPixelText(dc as Dc, centerX, centerY, text as String, color) {
        var textArr = text.toCharArray();
        var size = Layout.getPixelSize(dc, 1);

        var spacing = 5;
        var charWidth  = size * fontSize;
        var charHeight = size * fontSize;

        var n = text.length();
        if (n == 0) { return; }

        var advance = charWidth + spacing;
        var totalWidth  = (n * advance - spacing).toFloat();
        var totalHeight = charHeight.toFloat();

        // Top-left cords to center
        var startX = centerX.toFloat() - totalWidth  / 2.0;
        var startY = centerY.toFloat() - totalHeight / 2.0;

        for (var j = 0; j < n; j++) {
            var letter = textArr[j] as String;

            var posX = startX + j * advance;
            var posY = startY;

            drawLetter(dc, letter, color, Color.none, posX, posY, size);
        }
    }

    function drawLetter(dc as Dc, letter as String, color, border, x, y, size) {
        letter = letter.toString().toUpper();
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
                    if (border != Color.none) {
                        dc.setColor(border, Color.none);
                        dc.drawRectangle(px, py, size, size);
                    }
                }
            }
        }
    }

    // ---------- Runner ----------

    function drawHighScore(dc as Dc, gameName as String, borderColor) {
        var highScore = SaveManager.getHighScore(gameName);
        var borderY = dc.getHeight() * 0.30;

        dc.setColor(borderColor, Color.none);
        dc.drawRectangle(0, -10, dc.getWidth(), borderY);
        
        switch (gameName) {
            case "2048":
                Titles.score2048(dc, highScore, borderY);
                break;
            case "snake":
                Titles.scoreSnake(dc, highScore, borderY);
                break;
            case "stackup":
                Titles.scoreStackup(dc, highScore, borderY);
                break;
        }
    }

    // ---------- Game Titles ----------

    // --- 2048 ---
    function title2048(dc as Dc) {
        var title = ["2", "0", "4", "8"];
        var size = Layout.getPixelSize(dc, 14);
        var spacing = size + Layout.getPixelSize(dc, 1);

        var x = Layout.centerX(dc) - ((spacing * title.size()) / 2);
        var y = Layout.centerY(dc) - (size * 0.9);
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
            dc.drawText(posX + (size/2), posY + Layout.getPixelSize(dc, 1), Graphics.FONT_LARGE, value, Graphics.TEXT_JUSTIFY_CENTER);
        }
    }

    function score2048(dc as Dc, score, borderY) {
        var height = Layout.getPixelSize(dc, 8);
        var width = Layout.getPixelSize(dc, 8);

        if (score >= 1000) {
            width = Layout.getPixelSize(dc, 18);
        }
        else if (score >= 100) {
            width = Layout.getPixelSize(dc, 15);
        }
        else if (score >= 10) {
            width = Layout.getPixelSize(dc, 11);
        }

        var x = dc.getWidth() * 0.25;
        var y = borderY / 2.5;

        // Draw Title
        dc.setColor(Graphics.COLOR_WHITE, Color.none);
        dc.drawText(x, y, Graphics.FONT_SMALL, "BEST", Graphics.TEXT_JUSTIFY_LEFT);

        // Draw tile
        var buffer = Layout.getPixelSize(dc, 19);
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
    
    function titleSnake(dc as Dc) {
        var size = Layout.getPixelSize(dc, 1.5);
        var x = Layout.centerX(dc) - (SNAKE_TITLE[0].size() * size) / 2;
        var y = dc.getHeight() * 0.35;
        drawSnakeMatrix(dc, SNAKE_TITLE, x, y, size);
    }

    const SNAKE_SCORE = [
        [1,1,1,0,  0,  1,1,1,  0,  1,1,1,  0,  1,1,1],
        [1,0,0,1,  0,  1,0,0,  0,  1,0,0,  0,  0,1,0],
        [1,1,1,0,  0,  1,1,0,  0,  1,1,1,  0,  0,1,0],
        [1,0,0,1,  0,  1,0,0,  0,  0,0,1,  0,  0,1,0],
        [1,1,1,1,  0,  1,1,1,  0,  1,1,1,  0,  0,1,0]
    ];

    function scoreSnake(dc as Dc, score, borderY) {
        var size = Layout.getPixelSize(dc, 1);
        var x = dc.getWidth() * 0.25;
        var y = borderY * 0.50;
        drawSnakeMatrix(dc, SNAKE_SCORE, x, y, size);

        // Draw Score Number
        var bufferX = Layout.getPixelSize(dc, 20);
        var bufferY = Layout.getPixelSize(dc, 1.5);
        dc.setColor(Graphics.COLOR_GREEN, Color.none);
        dc.drawText(x + bufferX, y - bufferY, Graphics.FONT_SMALL, (score), Graphics.TEXT_JUSTIFY_LEFT);
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

    function titleStackup(dc as Dc) {
        var title = ["S", "T", "A", "C", "K", "U", "P"];

        var size = Layout.getPixelSize(dc, 1.5);
        var spacing = (size * fontSize) + Layout.getPixelSize(dc, 1);
        var word_space = 0;

        var x = Layout.centerX(dc) - ((spacing * title.size()) / 2);
        var y = Layout.centerY(dc) - (size * fontSize);

        for (var i = 0; i < title.size(); i++) {
            var letter = title[i] as String;
            
            if ( i == 5) { word_space = 2; }

            var posX = x + i * (spacing + word_space);
            drawLetter(dc, letter, LETTER_COLORS[letter], Graphics.COLOR_BLACK, posX, y, size);
        }
    }

    function scoreStackup(dc as Dc, score, borderY) {
        var scoreTitle = ["B", "E", "S", "T"];
        
        var size = Layout.getPixelSize(dc, 1);
        var spacing = (size * fontSize);

        var x = dc.getWidth() * 0.30;
        var y = borderY / 1.8;

        for (var i = 0; i < scoreTitle.size(); i++) {
            var letter = scoreTitle[i] as String;

            var posX = x + i * spacing;
            drawLetter(dc, letter, LETTER_COLORS[letter], Graphics.COLOR_BLACK, posX, y, size);
        }

        // Draw Score Number
        var bufferX = Layout.getPixelSize(dc, 23);
        var bufferY = Layout.getPixelSize(dc, 1.5);
        dc.setColor(Color.STACKS["O"], Color.none);
        dc.drawText(x + bufferX, y - bufferY, Graphics.FONT_SMALL, (score), Graphics.TEXT_JUSTIFY_LEFT);
    }
}