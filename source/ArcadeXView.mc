import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Lang;

import Layout;
import Components;

class ArcadeXView extends WatchUi.View {
    var mainButton as Dictionary or Null;
    var favIcon as Dictionary or Null;
    var gameIdx;
    
    function initialize() {
        View.initialize();

        // Load favorite game
        SaveManager.loadFavGame();
        if (SaveManager.favGame == null) {
            SaveManager.setFavGame(0);
        }
        gameIdx = SaveManager.favGame;
    }

    function onUpdate(dc as Dc) as Void {
        // Background
        // setColor(foreground = text and shapes, background)
        dc.setColor(Color.none, Graphics.COLOR_BLACK);
        dc.clear();

        // Main Title
        Titles.pixelShadowedText(dc, 60, 83, 8, "ARCADEX", Color.NEON["pink"], Color.NEON["blue"]);

        // Buttons
        makeScrollingWheel(dc);
    }

    function makeScrollingWheel(dc as Dc) {
        // Favorite icon
        var icon = gameIdx == SaveManager.favGame ? Drawings.FILLED_HEART : Drawings.EMPTY_HEART;
        favIcon = Drawings.drawPixelArt(dc, 13, Layout.centerY(dc) + 10, 6, icon);

        // Main button
        var iconSpace = 20;
        var mainBW = 300;
        mainButton = {:w => mainBW - iconSpace, :h => 70,
                        :x => Layout.centerX(dc) - (mainBW / 2) + iconSpace,
                        :y => Layout.centerY(dc)};
        var mainButtonFormat = {:background => Graphics.COLOR_BLACK,
                                :border => Color.NEON["blue"], 
                                :text => Graphics.COLOR_WHITE,
                                :font => Graphics.FONT_LARGE};

        Components.makeRect(dc, mainButton, mainButtonFormat, GameRegistry.GAMES[gameIdx][:title]);

        // Shadow buttons
        var shadowBW = 180;
        var shadowBH = 35;
        var shadowButtonFormat = {:background => Graphics.COLOR_BLACK,
                                :border => Color.NEON["blue"], 
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

    function getFavIcon() as Dictionary {
        return favIcon;
    }
}