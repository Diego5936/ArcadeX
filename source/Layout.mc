import Toybox.Graphics;
import Toybox.Lang;

module Layout {
    function centerX(dc as Dc) as Number {
        return dc.getWidth() / 2;
    }

    function centerY(dc as Dc) as Number {
        return dc.getHeight() / 2;
    }

    const TITLE_OFFSET_Y = -30;
    const BUTTON_OFFSET_Y = 50;

    function buttonRect(dc as Dc) as Dictionary {
        return {
            :x => centerX(dc) - 40,
            :y => centerY(dc) + BUTTON_OFFSET_Y - 20,
            :w => 80,
            :h => 40
        };
    }

    function isInRect(pos as Dictionary, rect as Dictionary) as Boolean {
        return pos[:x] >= rect[:x] and pos[:x] <= rect[:x] + rect[:w] and
               pos[:y] >= rect[:y] and pos[:y] <= rect[:y] + rect[:h];
    }

}