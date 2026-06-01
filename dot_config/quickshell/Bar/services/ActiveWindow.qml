pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

Singleton {
    id: root

    readonly property Toplevel activeToplevel: ToplevelManager.activeToplevel

    readonly property string appId: {
        if (activeToplevel?.activated && activeToplevel?.appId)
            return activeToplevel.appId;
        return "";
    }

    readonly property string windowTitle: {
        if (activeToplevel?.activated && activeToplevel?.title)
            return activeToplevel.title;
        return "";
    }
}
