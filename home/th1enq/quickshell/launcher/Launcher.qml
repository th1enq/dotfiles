import QtQuick
import Quickshell
import Quickshell.Io
import "Singletons"
import "lib/fuzzy.js" as Fuzzy

Item {
    id: root

    property real s: 1
    property bool shown: false
    property string query: ""
    property int selectedIndex: 0
    property bool vimNormal: false
    property var usage: ({})
    property point lastPointer: Qt.point(-1, -1)

    signal requestClose()

    readonly property string usageFile: (Quickshell.env("XDG_STATE_HOME") || (Quickshell.env("HOME") + "/.local/state")) + "/quickshell-launcher-usage.json"
    readonly property var allEntries: {
        var src = DesktopEntries.applications.values;
        var out = [];
        for (var i = 0; i < src.length; i++)
            if (src[i] && !src[i].noDisplay)
                out.push(src[i]);
        return out;
    }
    readonly property int totalCount: allEntries.length
    readonly property var results: Fuzzy.rank(allEntries, query, usage).slice(0, 22)
    readonly property int visibleRows: 8
    readonly property real cardW: 430 * s
    readonly property real rowH: 42 * s
    readonly property real contentH: Math.min(results.length, visibleRows) * rowH + Math.max(0, Math.min(results.length, visibleRows) - 1) * 4 * s

    implicitWidth: cardW
    implicitHeight: 62 * s + Math.max(contentH, 60 * s)
    readonly property real restingHeight: implicitHeight

    transformOrigin: Item.Top
    opacity: shown ? 1 : 0
    scale: shown ? 1 : 0.92
    Behavior on opacity { NumberAnimation { duration: Motion.window; easing.type: Easing.OutCubic } }
    Behavior on scale {
        NumberAnimation { duration: Motion.window; easing.type: Motion.easeMorph; easing.bezierCurve: Motion.morphCurve }
    }
    Behavior on implicitHeight {
        NumberAnimation { duration: Motion.morph; easing.type: Motion.easeMorph; easing.bezierCurve: Motion.morphCurve }
    }

    function stateDump() {
        var rs = [];
        for (var i = 0; i < Math.min(results.length, 12); i++) {
            var r = results[i] || {};
            rs.push({
                title: String(r.name || ""),
                subtitle: String(secondaryFor(r) || ""),
                type: "app",
                verb: "Open"
            });
        }
        return {
            query: query,
            resultCount: results.length,
            totalCount: totalCount,
            selectedIndex: selectedIndex,
            results: rs
        };
    }

    function secondaryFor(entry) {
        if (!entry)
            return "";
        if (entry.genericName && entry.genericName.length > 0)
            return entry.genericName;
        if (entry.categories && entry.categories.length > 0)
            return mapCategory(entry.categories);
        return "";
    }

    function mapCategory(raw) {
        var order = [
            ["TerminalEmulator", "TerminalEmulator"], ["WebBrowser", "Web Browser"],
            ["InstantMessaging", "Chat"], ["Audio", "Media"], ["AudioVideo", "Media"],
            ["Video", "Media"], ["Game", "Game"], ["Development", "Development"],
            ["Graphics", "Graphics"], ["Office", "Office"], ["Settings", "Settings"],
            ["System", "System"], ["Utility", "Tool"], ["Network", "Network"]
        ];
        var cats = String(raw).split(/[;,]/);
        for (var i = 0; i < order.length; i++)
            if (cats.indexOf(order[i][0]) >= 0)
                return order[i][1];
        return "";
    }

    function focusField() { search.focusField(); }

    function enterInsertMode() {
        vimNormal = false;
        search.focusField();
    }

    function enterNormalMode() {
        vimNormal = true;
        search.focusField();
    }

    function clearQuery() {
        query = "";
        selectedIndex = 0;
        search.clear();
        list.positionViewAtIndex(0, ListView.Beginning);
    }

    function move(delta) {
        if (results.length === 0)
            return;
        selectedIndex = Math.max(0, Math.min(results.length - 1, selectedIndex + delta));
        list.positionViewAtIndex(selectedIndex, ListView.Contain);
    }

    function first() {
        if (results.length === 0)
            return;
        selectedIndex = 0;
        list.positionViewAtIndex(selectedIndex, ListView.Beginning);
    }

    function last() {
        if (results.length === 0)
            return;
        selectedIndex = results.length - 1;
        list.positionViewAtIndex(selectedIndex, ListView.End);
    }

    function activate() {
        if (results.length === 0 || selectedIndex < 0 || selectedIndex >= results.length)
            return;
        var entry = results[selectedIndex];
        if (!entry)
            return;
        if (entry.id) {
            usage[entry.id] = (usage[entry.id] || 0) + 1;
            usageStore.setText(JSON.stringify(usage));
        }
        entry.execute();
        requestClose();
    }

    onShownChanged: {
        if (shown) {
            query = "";
            selectedIndex = 0;
            vimNormal = false;
            search.clear();
            Qt.callLater(focusField);
        }
    }
    onResultsChanged: {
        if (selectedIndex >= results.length)
            selectedIndex = 0;
    }

    FileView {
        id: usageStore
        path: root.usageFile
        blockLoading: true
        atomicWrites: true
        printErrors: false
    }

    Component.onCompleted: {
        var raw = usageStore.text();
        try {
            usage = raw && raw.length ? JSON.parse(raw) : ({});
        } catch (e) {
            usage = ({});
        }
    }

    Squircle {
        anchors.fill: parent
        radius: 26 * root.s
        power: 4
        color: Theme.cardTop
        borderColor: Theme.border
        borderWidth: 1
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {}
    }

    SearchRow {
        id: search
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 18 * root.s
        anchors.leftMargin: 24 * root.s
        anchors.rightMargin: 24 * root.s
        s: root.s
        normalMode: root.vimNormal
        resultCount: root.results.length
        totalCount: root.totalCount
        onTextChanged: {
            root.query = text;
            root.selectedIndex = 0;
        }
        onMoved: (d) => root.move(d)
        onFirst: root.first()
        onLast: root.last()
        onClearRequested: root.clearQuery()
        onAccepted: root.activate()
        onDismissed: root.requestClose()
        onNormalRequested: root.enterNormalMode()
        onInsertRequested: root.enterInsertMode()
    }

    Rectangle {
        id: divider
        anchors.top: search.bottom
        anchors.topMargin: 10 * root.s
        anchors.left: search.left
        anchors.right: search.right
        height: 1
        color: Theme.hair
    }

    Text {
        anchors.centerIn: list
        visible: root.results.length === 0
        text: root.query.length ? "No matches" : "No apps found"
        color: Theme.faint
        font.family: Theme.font
        font.pixelSize: 12 * root.s
    }

    ListView {
        id: list
        anchors.top: divider.bottom
        anchors.topMargin: 8 * root.s
        anchors.left: search.left
        anchors.right: search.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 16 * root.s
        spacing: 4 * root.s
        clip: true
        boundsBehavior: Flickable.StopAtBounds
        model: root.results.length

        delegate: Item {
            id: row
            required property int index

            width: list.width
            height: root.rowH

            readonly property var entry: root.results[index]
            readonly property bool selected: index === root.selectedIndex
            readonly property string secondary: root.secondaryFor(entry)

            Rectangle {
                anchors.fill: parent
                radius: 7 * root.s
                visible: row.selected || hover.containsMouse
                color: row.selected ? Theme.frameBg : Qt.rgba(1, 1, 1, 0.035)
                border.width: row.selected ? 1 : 0
                border.color: Theme.frameBorder
                Behavior on color { ColorAnimation { duration: Motion.highlight } }
            }

            MouseArea {
                id: hover
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onPositionChanged: (m) => {
                    var p = hover.mapToItem(null, m.x, m.y);
                    if (p.x !== root.lastPointer.x || p.y !== root.lastPointer.y) {
                        root.lastPointer = Qt.point(p.x, p.y);
                        root.selectedIndex = row.index;
                    }
                }
                onClicked: {
                    root.selectedIndex = row.index;
                    root.activate();
                }
            }

            Item {
                anchors.fill: parent
                anchors.leftMargin: 12 * root.s
                anchors.rightMargin: 12 * root.s

                Rectangle {
                    id: iconBg
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    width: 22 * root.s
                    height: 22 * root.s
                    radius: 5 * root.s
                    color: Qt.rgba(1, 1, 1, 0.06)
                    visible: !(icon.status === Image.Ready && icon.source != "")
                }

                Image {
                    id: icon
                    anchors.fill: iconBg
                    sourceSize.width: Math.round(32 * root.s)
                    sourceSize.height: Math.round(32 * root.s)
                    fillMode: Image.PreserveAspectFit
                    asynchronous: true
                    smooth: true
                    visible: status === Image.Ready && source != ""
                    source: row.entry && row.entry.icon ? Quickshell.iconPath(row.entry.icon, true) : ""
                }

                Text {
                    id: enterHint
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    text: "↵"
                    visible: row.selected
                    color: Theme.vermLit
                    font.family: Theme.font
                    font.pixelSize: 14 * root.s
                }

                Text {
                    id: secondaryText
                    anchors.right: enterHint.visible ? enterHint.left : parent.right
                    anchors.rightMargin: enterHint.visible ? 8 * root.s : 0
                    anchors.verticalCenter: parent.verticalCenter
                    width: Math.min(148 * root.s, Math.max(0, parent.width * 0.42))
                    text: row.secondary
                    color: row.selected ? Theme.dim : Theme.faint
                    font.family: Theme.font
                    font.pixelSize: 12.5 * root.s
                    horizontalAlignment: Text.AlignRight
                    elide: Text.ElideRight
                }

                Text {
                    anchors.left: iconBg.right
                    anchors.leftMargin: 10 * root.s
                    anchors.right: secondaryText.left
                    anchors.rightMargin: 10 * root.s
                    anchors.verticalCenter: parent.verticalCenter
                    text: row.entry ? row.entry.name : ""
                    color: Theme.cream
                    font.family: Theme.font
                    font.pixelSize: 15 * root.s
                    font.weight: row.selected ? Font.DemiBold : Font.Normal
                    elide: Text.ElideRight
                }
            }
        }
    }
}
