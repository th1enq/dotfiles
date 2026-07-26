pragma Singleton
import QtQuick
import Quickshell

Singleton {
    // Static Ricelin pill palette for the minimal app launcher.
    readonly property color brand:    "#c0442b"
    readonly property color verm:     brand
    readonly property color vermLit:  "#e0563b"
    readonly property color vermDeep: "#a3371f"
    readonly property color sun:      "#e0563b"
    readonly property color gold:     "#d9a441"
    readonly property color cream:    "#e6d6cb"
    readonly property color bright:   "#fff6f0"
    readonly property color dim:      "#8a7d74"
    readonly property color cardTop:  "#030504"
    readonly property color cardBot:  "#030504"
    readonly property color border:   Qt.rgba(230/255, 214/255, 203/255, 0.10)
    readonly property color lineStrong: Qt.rgba(236/255, 226/255, 205/255, 0.40)
    readonly property color shadow:   "#000000"
    readonly property color tileBg:   "#0b1017"
    readonly property color subtle:   "#b9a99e"
    readonly property color faint:    "#615b72"
    readonly property color iconDim:  "#cdbfb4"
    readonly property color hair:     Qt.rgba(230/255, 214/255, 203/255, 0.13)
    readonly property color sheen:    Qt.rgba(230/255, 214/255, 203/255, 0.07)
    readonly property color vermDim:  "#8a5440"
    readonly property color vermDimDeep: "#5a3526"
    readonly property color vermBurn: "#8a2c14"
    readonly property color tickRest: "#cbb6a3"
    readonly property color threadBg: Qt.rgba(230/255, 214/255, 203/255, 0.13)
    readonly property color flameCore: "#ffd2bf"
    readonly property color flameGlow: "#ff9e64"

    /**
     * Flame canvas ramp: literal hex strings (color type won't work), fed
     * directly to Canvas addColorStop/strokeStyle. A color property serializes
     * to #aarrggbb and corrupts the gradient render.
     */
    readonly property string flameInk:   "#e83b30"
    readonly property string flameEmber: "#7a2a1a"
    readonly property string flameBurn:  "#8f321d"
    readonly property string flameTip:   "#ffd2bf"
    readonly property color todayWarm: "#ff9e64"
    readonly property color ghost:     "#414868"
    // Rest-card sky: fixed day/night scene colours, deliberately independent of
    // the accent so the sun stays golden and the night cool on any wallpaper.
    readonly property color sunGold:  "#ffc777"
    readonly property color moonGlow: "#7aa2f7"
    readonly property color moonDisc: "#c8d3f5"
    readonly property color frameBg:     Qt.rgba(66/255, 82/255, 112/255, 0.22)
    readonly property color frameBorder: Qt.rgba(230/255, 214/255, 203/255, 0.10)
    readonly property color creamMenu:   Qt.rgba(230/255, 220/255, 203/255, 0.82)
    readonly property real shadowOpacity: 0.5
    // type stack + brutalist geometry, the website language.
    readonly property string display: "Fraunces"
    readonly property string font: Config.fontFamily.length > 0 ? Config.fontFamily : "Inter"
    readonly property string fontJp: "Zen Kaku Gothic New"
    readonly property string mono: "JetBrainsMono Nerd Font"
    readonly property int radius: 0
    readonly property real border2: 1
    readonly property int shadowStep: 6

    /**
     * MPRIS trackArtists arrives as a JS array from some players and as a
     * plain string from others (Spotify); calling join on the string throws
     * and kills the whole binding. Handles both, falls back to trackArtist.
     */
    function joinArtists(artists, single) {
        if (artists && typeof artists.join === "function" && artists.length > 0)
            return artists.join(", ");
        if (artists && String(artists).length > 0)
            return String(artists);
        return single ? String(single) : "";
    }
}
