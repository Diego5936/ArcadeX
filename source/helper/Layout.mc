import Toybox.Graphics;
import Toybox.Lang;

module Layout {
    var workingTop = 50;

    function centerX(dc as Dc) as Number {
        return dc.getWidth() / 2;
    }

    function centerY(dc as Dc) as Number {
        return dc.getHeight() / 2;
    }

    /* Due to the watches being circular, the working buffer is
    the margin necessary for a square to not be completely cut off */
    var workingBufferX = 56;
    var workingBufferY = 66;   

    function workingWidth(dc as Dc) as Number {
        return dc.getWidth() - (workingBufferX * 2);
    }

    function workingHeight(dc as Dc) as Number {
        return dc.getHeight() - (workingBufferY * 2);
    }
}