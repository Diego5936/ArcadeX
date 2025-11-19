import Toybox.Graphics;

module Color {
    var none = Graphics.COLOR_TRANSPARENT;

    // Home Screen Arcade Colors
    const NEON = {
        "pink"    => Graphics.createColor(1, 255, 51, 255),
        "blue"    => Graphics.createColor(1, 0, 255, 255),
        "green"   => Graphics.createColor(1, 0, 255, 128),
    };

    // 2048 Custom Colors
    const TILES = {
        2     => Graphics.createColor(1, 230, 230, 255), // Light blue
        4     => Graphics.createColor(1, 214, 214, 255), // Blue fade 1
        8     => Graphics.createColor(1, 188, 188, 255), // Blue fade 2
        16    => Graphics.createColor(1, 158, 158, 255), // Blue fade 3
        32    => Graphics.createColor(1, 116, 116, 255), // Blue fade 4
        64    => Graphics.createColor(1, 66, 66, 255),   // Blue
        128   => Graphics.createColor(1, 40, 180, 200),  // Teal
        256   => Graphics.createColor(1, 40, 200, 190),  // Aqua
        512   => Graphics.createColor(1, 40, 200, 160),  // Mint fade 1
        1024  => Graphics.createColor(1, 40, 220, 140),  // Mint fade 2
        2048  => Graphics.createColor(1, 66, 230, 120),  // Mint
        "big" => Graphics.createColor(1, 0, 0, 50)       // Dark blue
    };

    // Stackup piece colors
    const STACKS = {
        "I" => Graphics.createColor(1,  45, 200, 255), // Cyan
        "O" => Graphics.createColor(1, 255, 220,  50), // Yellow
        "T" => Graphics.createColor(1, 190,  90, 255), // Purple
        "S" => Graphics.createColor(1,  80, 220,  90), // Green
        "Z" => Graphics.createColor(1, 255,  90,  90), // Red
        "J" => Graphics.createColor(1,  70, 110, 255), // Blue
        "L" => Graphics.createColor(1, 255, 160,  60)  // Orange
    };
}