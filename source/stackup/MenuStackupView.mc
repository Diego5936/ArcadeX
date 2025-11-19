import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Lang;

class MenuStackupView extends WatchUi.View {
    var playButton as Dictionary or Null;
    
    function initialize() {
        View.initialize();
    }

    function onUpdate(dc as Dc) as Void {
        // Background
        dc.setColor(Color.none, Graphics.COLOR_BLACK);
        dc.clear();

        // Title
        Titles.titleStackup(dc);
        Components.drawHighScore(dc, "stackup", Graphics.COLOR_PURPLE);

        // New Game Button
        playButton = Components.makeStartButton(dc, "PLAY", Graphics.COLOR_PURPLE, 
                                Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
    }
}