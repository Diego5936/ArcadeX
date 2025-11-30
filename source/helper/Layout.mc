import Toybox.Graphics;
import Toybox.Math;
import Toybox.Lang;

module Layout {
    var workingTop = 50;

    function centerX(dc) { return dc.getWidth() / 2; }
    function centerY(dc) { return dc.getHeight() / 2; }
    // function radius(dc) { return Math.min(dc.getWidth(), dc.getHeight()) / 2; }  

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

    // Regions for touch input
    var leftX = 90;
    var rightX = 320;
    var topY = 95;
    var bottomY = 315;

    function determineRegion(x, y) as String{
        var direction = "center";

        if (x <= Layout.leftX && y < Layout.bottomY && y > Layout.topY) {
            direction = "left";
        }
        else if (x >= Layout.rightX && y < Layout.bottomY && y > Layout.topY) {
            direction = "right";
        }
        else if (y <= Layout.topY && x > Layout.leftX && x < Layout.rightX) {
            direction = "up";
        }
        else if (y >= Layout.bottomY && x > Layout.leftX && x < Layout.rightX) {
            direction = "down";
        }

        return direction;
    }
}