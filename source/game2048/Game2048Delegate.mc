import Toybox.WatchUi;
import Toybox.Lang;

class Game2048Delegate extends WatchUi.InputDelegate {

    function initialize() {
        InputDelegate.initialize();
    }

    function onFlick(flickEvent as WatchUi.FlickEvent) {
        var direction = flickEvent.getDirection();

        // Get view counterpart
        var viewPair = WatchUi.getCurrentView();
        var view = viewPair[0] as Game2048View;

        switch (direction) {
            case 0: // UP
                
                break;
            case 90: // RIGHT
            case 180: // DOWN
            case 270: // LEFT
            default:
                break;
        }

        return true;
    }
}