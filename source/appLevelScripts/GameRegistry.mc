import Toybox.WatchUi;
import Toybox.Lang;

module GameRegistry {

    // ---------- Games Library ----------

    var MAP = {
        "2048" => new Method(GameRegistry, :run2048),
        "snake" => new Method(GameRegistry, :runSnake),
        "stackup" => new Method(GameRegistry, :runStackup)
    };

    const GAMES = [
        { :id => "2048", :title => "2048" },
        { :id => "snake", :title => "Snake" },
        { :id => "stackup", :title => "Stack Up" }
        // { :id => "quickdash", :title => "Quick Dash" },
        // { :id => "minimaze", :title => "Mini Maze" },
        // { :id => "breakout", :title => "Breakout" },
        // { :id => "catchit", :title => "Catch It!" }
    ];



    // Public launch function
    function launch(id as String, menu as Boolean) as Boolean {
        if (!MAP.hasKey(id)) { return false; }
        
        var method = ((MAP as Dictionary)[id] as Method);
        method.invoke(menu);
        return true;

    }

    // ---------- Launchers ----------

    // Shared screen launcher
    function launchScreen(viewClass, delegateClass, passView, moveCallback as Method or Null) {
        var view = new viewClass();

        if (passView) {
            WatchUi.pushView(view, new delegateClass(view), WatchUi.SLIDE_IMMEDIATE);
        }
        else {
            WatchUi.pushView(view, new delegateClass(moveCallback), WatchUi.SLIDE_IMMEDIATE);
        }
    }

    // --- Individual Launchers ---
    function run2048(menu as Boolean) {
        if (menu) {
            launchScreen(Menu2048View, Menu2048Delegate, true, null);
        } 
        else {
            launchScreen(Game2048View, GameInputDelegate, false, new Method(Game2048, :handleMove));
        }
    }

    function runSnake(menu as Boolean) { 
        if (menu) {
            launchScreen(MenuSnakeView, MenuSnakeDelegate, true, null);
        } 
        else {
            launchScreen(SnakeView, GameInputDelegate, false, new Method(Snake, :handleMove));
        }
    } 

    function runStackup(menu as Boolean) { 
        if (menu) {
            launchScreen(MenuStackupView, MenuStackupDelegate, true, null);
        } 
        else {
            launchScreen(StackupView, GameInputDelegate, false, new Method(Stackup, :handleMove));
        }
    } 
}