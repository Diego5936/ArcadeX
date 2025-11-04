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
        dc.setColor(Graphics.COLOR_BLACK, Color.none);
        dc.drawText(Layout.centerX(dc), Layout.centerY(dc) - 30, 
                    Graphics.FONT_LARGE, "STACKUP", Graphics.TEXT_JUSTIFY_CENTER);

        // New Game Button
        playButton = Components.makeStartButton(dc, "PLAY", Graphics.COLOR_PURPLE, 
                                Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
    }
}