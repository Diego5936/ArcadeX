import Toybox.WatchUi;
import Toybox.Lang;

module GameRegistry {
    // --- Games Library ---
    var MAP = {
        "snake" => new Method(GameRegistry, :runSnake),
        "2048" => new Method(GameRegistry, :run2048)
    };

    const GAMES = [
        { :id => "2048", :title => "2048" },
        { :id => "snake", :title => "Snake" },
        { :id => "stackup", :title => "Stack Up" },
        { :id => "quickdash", :title => "Quick Dash" },
        { :id => "minimaze", :title => "Mini Maze" },
        { :id => "breakout", :title => "Breakout" },
        { :id => "catchit", :title => "Catch It!" }
    ];

    // Public launch function
    function launch(id as String, menu as Boolean) as Boolean {
        if (!MAP.hasKey(id)) { return false; }
        
        var method = ((MAP as Dictionary)[id] as Method);
        method.invoke(menu);
        return true;

    }

    // --- Launchers ---
    // Shared screen launcher
    function launchScreen(viewClass, delegateClass) {
        WatchUi.pushView(new viewClass(), new delegateClass(), WatchUi.SLIDE_IMMEDIATE);
    }

    function runSnake(menu as Boolean) { 
        if (menu) {
            launchScreen(MenuSnakeView, MenuSnakeDelegate);
        } 
        else {
            launchScreen(SnakeView, SnakeDelegate);
        }
    } 
    function run2048(menu as Boolean) {
        if (menu) {
            launchScreen(Menu2048View, Menu2048Delegate);
        } 
        else {
            launchScreen(Game2048View, Game2048Delegate);
        }
    }
}