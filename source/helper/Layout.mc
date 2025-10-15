import Toybox.Graphics;
import Toybox.Lang;

module Layout {
    function centerX(dc as Dc) as Number {
        return dc.getWidth() / 2;
    }

    function centerY(dc as Dc) as Number {
        return dc.getHeight() / 2;
    }
}