import Toybox.Lang;

module MathX {
    // Returns the minimum of two numbers
    function min(a as Number, b as Number) as Number {
        if (a < b) {
            return a;
        }
        return b;
    }
}

