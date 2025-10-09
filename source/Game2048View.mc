import Toybox.WatchUi;
import Toybox.Graphics;

class Game2048View extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    function onUpdate(dc as Dc) as Void {
        dc.clear();
        dc.drawText(dc.getWidth()/2, dc.getHeight()/2, Graphics.FONT_LARGE, "2048", Graphics.TEXT_JUSTIFY_CENTER);
    }
}