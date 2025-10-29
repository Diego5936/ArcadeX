import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Lang;

import Layout;
import Components;

class ArcadeXView extends WatchUi.View {
    var mainButton as Dictionary or Null;
    var games as Array = ["Snake", "StackUp", "QuickDash", "MiniMaze", "Breakout", "Catch It!", "2048"];
    var gameIdx = 0;
    
    function initialize() {
        View.initialize();
    }

    function onUpdate(dc as Dc) as Void {
        // Background
        // setColor(foreground = text and shapes, background)
        dc.setColor(Color.none, Graphics.COLOR_BLACK);
        dc.clear();

        // Main Title
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.drawText(Layout.centerX(dc), Layout.workingTop, 
                    Graphics.FONT_LARGE, "ArcadeX", Graphics.TEXT_JUSTIFY_CENTER);

        // Buttons
        makeScrollingWheel(dc);
    }

    function makeScrollingWheel(dc as Dc) {
        // Main button
        var mainBW = 300;
        mainButton = {:w => mainBW, :h => 70,
                        :x => Layout.centerX(dc) - (mainBW / 2),
                        :y => Layout.centerY(dc)};
        var mainButtonFormat = {:background => Graphics.COLOR_BLACK,
                                :border => Graphics.COLOR_RED, 
                                :text => Graphics.COLOR_WHITE,
                                :font => Graphics.FONT_LARGE};

        Components.makeRect(dc, mainButton, mainButtonFormat, games[gameIdx]);

        // Shadow buttons
        var shadowBW = 180;
        var shadowBH = 35;
        var shadowButtonFormat = {:background => Graphics.COLOR_BLACK,
                                :border => Graphics.COLOR_RED, 
                                :text => Graphics.COLOR_WHITE,
                                :font => Graphics.FONT_XTINY};

        // Top Button
        var topButton = {:w => shadowBW, :h => shadowBH,
                        :x => Layout.centerX(dc) - (shadowBW / 2),
                        :y => Layout.centerY(dc) - shadowBH - 10};

        var topIdx = wrapIdx(gameIdx - 1);
        Components.makeRect(dc, topButton, shadowButtonFormat, games[topIdx]);

        // Bottom Button
        var bottomButton = {:w => shadowBW, :h => shadowBH,
                        :x => Layout.centerX(dc) - (shadowBW / 2),
                        :y => Layout.centerY(dc) + mainButton[:h] + 10};

        var bottomIdx = wrapIdx(gameIdx + 1);
        Components.makeRect(dc, bottomButton, shadowButtonFormat, games[bottomIdx]);
    }

    // --- Helpers ---
    function scroll(direction as Number) {        
        gameIdx = wrapIdx(gameIdx + direction);
        WatchUi.requestUpdate();
    }

    function wrapIdx(idx as Number) as Number {
        var wrappedIdx = idx;

        if (idx < 0) {
            wrappedIdx = games.size() - 1;
        }
        if (idx > games.size() - 1) {
            wrappedIdx = 0;
        }

        return wrappedIdx;
    }

    // --- Getters ---
    function getMainButton() as Dictionary {
        return mainButton;
    }
}