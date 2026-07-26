import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import "./shim"

ShellRoot {
    id: shellRoot

    property string activeTheme: Quickshell.env("QS_THEME") || "clockwork/orbital"
    property string themePath: Quickshell.env("QS_THEME_PATH") || (Quickshell.shellDir + "/themes_link/" + activeTheme)

    readonly property var sddm: sddmShim.sddm
    readonly property var config: sddmShim.config
    readonly property var userModel: sddmShim.userModel
    readonly property var sessionModel: sddmShim.sessionModel
    readonly property var keyboard: sddmShim.keyboard
    readonly property bool isWayland: Quickshell.env("XDG_SESSION_TYPE") !== "x11"
    property bool authenticated: false
    property bool sessionLocked: false
    property bool isTesting: Quickshell.env("QS_TESTING") === "1"

    function lock() {
        authenticated = false;
        sessionLocked = true;
    }

    SddmShim {
        id: sddmShim
        themePath: shellRoot.themePath
    }

    Connections {
        target: sddmShim.sddm
        function onLoginSucceeded() {
            shellRoot.authenticated = true;

            if (Quickshell.env("XDG_CURRENT_DESKTOP") === "Hyprland" || Quickshell.env("HYPRLAND_INSTANCE_SIGNATURE") !== "") {
                Quickshell.execDetached(["hyprctl", "keyword", "misc:allow_session_lock_restore", "1"]);
            }
            Quickshell.execDetached(["loginctl", "unlock-session"]);

            quitTimer.interval = shellRoot.activeTheme.indexOf("clockwork") >= 0 && sddmShim.config.enableWindup === "true" ? 500 : 100;
            quitTimer.restart();
        }
    }

    Timer {
        id: quitTimer
        interval: 100
        onTriggered: shellRoot.sessionLocked = false
    }

    IpcHandler {
        target: "lock"
        function lock(): void {
            shellRoot.lock();
        }
    }

    Component {
        id: themeComponent
        Loader {
            anchors.fill: parent
            source: "file://" + shellRoot.themePath + "/Main.qml"

            onLoaded: item.forceActiveFocus()
            onStatusChanged: if (status === Loader.Error) console.error("FAILED to load theme:", source)
        }
    }

    Loader {
        id: waylandLoader
        active: shellRoot.isWayland
        sourceComponent: Component {
            WlSessionLock {
                locked: shellRoot.sessionLocked
                surface: Component {
                    WlSessionLockSurface {
                        color: "black"

                        PinchHandler { target: null }
                        WheelHandler { target: null }

                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.AllButtons
                            hoverEnabled: true
                            onWheel: (wheel) => { wheel.accepted = true }
                        }

                        Loader {
                            anchors.fill: parent
                            sourceComponent: themeComponent
                        }
                    }
                }
            }
        }
    }

    Loader {
        id: x11Loader
        active: !shellRoot.isWayland
        sourceComponent: Component {
            Variants {
                model: Quickshell.screens
                delegate: Window {
                    id: window
                    required property var modelData
                    screen: modelData
                    width: shellRoot.isTesting ? 1280 : screen.width
                    height: shellRoot.isTesting ? 720 : screen.height
                    visible: shellRoot.sessionLocked

                    onClosing: (close) => {
                        close.accepted = shellRoot.authenticated || shellRoot.isTesting;
                    }

                    flags: Qt.WindowStaysOnTopHint | Qt.FramelessWindowHint | Qt.MaximizeUsingFullscreenGeometryHint
                    color: "black"

                    Loader {
                        anchors.fill: parent
                        sourceComponent: themeComponent
                    }
                }
            }
        }
    }
}
