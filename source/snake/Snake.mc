import Toybox.Lang;

module Snake {
    var headPosition;
    var snakeSegments;
    var direction;

    function initialize() {
        headPosition = {:x => 7, :y => 7};
        snakeSegments = [];
        direction = null;
    }
}