import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class ArcadeXApp extends Application.AppBase {
    function initialize() {
        AppBase.initialize();
    }

    // Run once at launch
    function getInitialView() as [Views] or [Views, InputDelegates] {
        var view = new ArcadeXView();
        return [view, new ArcadeXDelegate(view)];
    }

    function onStart(state as Dictionary?) as Void { }

    function onStop(state as Dictionary?) as Void { }
}

function getApp() as ArcadeXApp {
    return Application.getApp() as ArcadeXApp;
}