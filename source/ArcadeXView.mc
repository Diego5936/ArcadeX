import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Lang;

import Layout;
import Components;

class ArcadeXView extends WatchUi.View {
    var mainButton as Dictionary or Null;
    var gameIdx = 0;
    
    function initialize() {
        View.initialize();
    }

    function onUpdate(dc as Dc) as Void {
        // Background
        // setColor(foreground = text and shapes, background)
        dc.setColor(Color.none, Graphics.COLOR_BLACK);
        dc.clear();

        // Main Titles
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

        Components.makeRect(dc, mainButton, mainButtonFormat, GameRegistry.GAMES[gameIdx][:title]);

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
        Components.makeRect(dc, topButton, shadowButtonFormat, GameRegistry.GAMES[topIdx][:title]);

        // Bottom Button
        var bottomButton = {:w => shadowBW, :h => shadowBH,
                        :x => Layout.centerX(dc) - (shadowBW / 2),
                        :y => Layout.centerY(dc) + mainButton[:h] + 10};

        var bottomIdx = wrapIdx(gameIdx + 1);
        Components.makeRect(dc, bottomButton, shadowButtonFormat, GameRegistry.GAMES[bottomIdx][:title]);
    }

    // --- Helpers ---
    function scroll(direction as Number) {        
        gameIdx = wrapIdx(gameIdx + direction);
        WatchUi.requestUpdate();
    }

    function wrapIdx(idx as Number) as Number {
        var wrappedIdx = idx;
        var n = GameRegistry.GAMES.size();

        if (idx < 0) {
            wrappedIdx = n - 1;
        }
        if (idx > n - 1) {
            wrappedIdx = 0;
        }

        return wrappedIdx;
    }

    // --- Getters ---
    function getMainButton() as Dictionary {
        return mainButton;
    }
}