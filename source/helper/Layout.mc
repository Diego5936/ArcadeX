import Toybox.Graphics;
import Toybox.Lang;

module Layout {
    function centerX(dc as Dc) as Number {
        return dc.getWidth() / 2;
    }

    function centerY(dc as Dc) as Number {
        return dc.getHeight() / 2;
    }

    // Due to the watches being circular,
    // the working buffer is the margin necessary for a square to not be cut off 
    var workingBuffer = 40;

    function workingWidth(dc as Dc) as Number {
        return dc.getWidth() - (workingBuffer * 2);
    }

    function workingHeight(dc as Dc) as Number {
        return dc.getHeight() - (workingBuffer * 2);
    }
}