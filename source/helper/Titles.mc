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

        "X" => [
            [1,0,0,0,1],
            [0,1,0,1,0],
            [0,0,1,0,0],
            [0,1,0,1,0],
            [1,0,0,0,1]
        ]
    };

    // Draws pixel art with a shadown. Center aligned
    function drawPixelShadowedText(dc as Dc, centerX, centerY, size, text as String, color, shadow) {
        // Shadow first
        var offset = 2;
        drawPixelText(dc, centerX + offset, centerY + offset, size, text, shadow);

        // Main text on top
        drawPixelText(dc, centerX, centerY, size, text, color);
    }

    function drawPixelText(dc as Dc, centerX, centerY, size, text as String, color) {
        var textArr = text.toCharArray();

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

    // ---------- Game Titles ----------
    // 2048
    function title2048(dc as Dc) {
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

    function score2048(dc as Dc, score, borderY) {
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
    
    function titleSnake(dc as Dc) {
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

    function scoreSnake(dc as Dc, score, borderY) {
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

    function titleStackup(dc as Dc) {
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
            drawLetter(dc, letter, LETTER_COLORS[letter], Graphics.COLOR_BLACK, posX, y, size);
        }
    }

    function scoreStackup(dc as Dc, score, borderY) {
        var scoreTitle = ["B", "E", "S", "T"];
        
        var size = 7;
        var spacing = (size * 5) + 2;

        var x = 100;
        var y = borderY - 60;

        for (var i = 0; i < scoreTitle.size(); i++) {
            var letter = scoreTitle[i] as String;

            var posX = x + i * spacing;
            drawLetter(dc, letter, LETTER_COLORS[letter], Graphics.COLOR_BLACK, posX, y, size);
        }

        // Draw Score Number
        dc.setColor(Color.STACKS["O"], Color.none);
        dc.drawText(x + 155, y - 7, Graphics.FONT_SMALL, (": " + score), Graphics.TEXT_JUSTIFY_LEFT);
    }
}