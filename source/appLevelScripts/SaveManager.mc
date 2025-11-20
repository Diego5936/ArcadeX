import Toybox.Application.Storage;
import Toybox.System;
import Toybox.Lang;

module SaveManager {
    // --- Settings ---
    var favGameKey as String = "arcadex_favgame";
    var favGame as Number or Null;

    function loadFavGame() {
        favGame = Storage.getValue(favGameKey) as Number or Null;
    }

    function setFavGame(gameIdx as Number) as Void {
        favGame = gameIdx;
        Storage.setValue(favGameKey, favGame);
    }

    // --- High Scores ---
    var scoresKey as String = "arcadex_scores";
    var scores as Dictionary or Null;

    function loadScores() {
        scores = Storage.getValue(scoresKey) as Dictionary or Null;

        if (scores == null) {
            scores = {};
            Storage.setValue(scoresKey, scores);
        }
    }

    // Save or update a high score for a given game
    function setHighScore(gameName as String, newScore as Number) as Void {
        if (scores == null) { loadScores(); }

        var current = 0;
        if (scores.hasKey(gameName)) {
            current = scores[gameName] as Number;
        }

        if (newScore > current) {
            scores[gameName] = newScore;
            Storage.setValue(scoresKey, scores);
        }
    }

    // Retrieve the high score for a given game
    function getHighScore(gameName as String) as Number {
        if (scores == null) { loadScores(); }
        return scores.hasKey(gameName) ? scores[gameName] as Number : 0;
    }      

    // --- 2048 Grid ---
    var gridKey as String = "arcadex_2048_grid";
    var grid as Array or Null;

    // Do not auto-create grid, null == no saved grid
    function loadGrid() {
        grid = Storage.getValue(gridKey) as Array or Null;
    }

    function hasGrid() as Boolean {
        if (grid == null) { loadGrid(); }
        return grid != null;
    }

    // Delete saved grid
    function clearGrid() as Void {
        grid = null;
        Storage.deleteValue(gridKey);
    }

    // Create empty grid
    function resetGrid() {
        grid = [
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0]
        ];
        Storage.setValue(gridKey, grid);
    }

    function saveGrid(newGrid as Array) as Void {
        if (grid == null) { loadGrid(); }
        grid = newGrid;
        Storage.setValue(gridKey, grid);
    }

    function getGrid() as Array {
        if (grid == null) { loadGrid(); }
        return grid;
    }      
}