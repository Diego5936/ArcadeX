import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Lang;

class MenuSnakeView extends WatchUi.View {
    
    var playButton as Dictionary or Null;
    
    function initialize() {
        View.initialize();
    }

    function onUpdate(dc as Dc) as Void {
        // Background
        dc.setColor(Color.none, Graphics.COLOR_BLACK);
        dc.clear();

        // Title
        Titles.titleSnake(dc);
        Titles.drawHighScore(dc, "snake", Graphics.COLOR_GREEN);

        // New Game Button
        playButton = Components.makeStartButton(dc, "PLAY", Graphics.COLOR_GREEN, 
                                Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
    }
}