import Toybox.Application.Storage;
import Toybox.System;
import Toybox.Lang;

module SaveManager {
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
        if (scores == null) {
            loadScores();
        }

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
        if (scores == null) {
            loadScores();
        }

        if (scores.hasKey(gameName)) {
            return scores[gameName] as Number;
        }

        return 0;
    }      
}