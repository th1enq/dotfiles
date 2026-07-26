import QtQuick
import QtQuick.Controls
import "Singletons"

Item {
    id: root

    property real s: 1
    property alias text: field.text
    property int resultCount: 0
    property int totalCount: 0
    property bool normalMode: false
    property bool dPending: false
    readonly property alias input: field

    signal moved(int delta)
    signal first()
    signal last()
    signal clearRequested()
    signal accepted()
    signal dismissed()
    signal normalRequested()
    signal insertRequested()

    height: 28 * s

    function focusField() { field.forceActiveFocus(); }
    function clear() {
        field.text = "";
        dPending = false;
    }

    Text {
        id: glyph
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        width: 14 * root.s
        text: root.normalMode ? "N" : "I"
        color: root.normalMode ? Theme.vermLit : Theme.dim
        font.family: Theme.mono
        font.weight: Font.DemiBold
        font.pixelSize: 14 * root.s
        horizontalAlignment: Text.AlignHCenter
    }

    TextField {
        id: field
        anchors.left: glyph.right
        anchors.leftMargin: 12 * root.s
        anchors.right: counter.left
        anchors.rightMargin: 10 * root.s
        anchors.verticalCenter: parent.verticalCenter
        background: null
        padding: 0
        color: Theme.cream
        font.family: Theme.font
        font.pixelSize: 15 * root.s
        placeholderText: "Search apps"
        placeholderTextColor: Theme.faint
        selectByMouse: true
        selectionColor: Theme.verm
        readOnly: root.normalMode
        cursorDelegate: Rectangle {
            width: 1
            color: Theme.vermLit
            visible: !root.normalMode
        }

        Keys.onUpPressed: root.moved(-1)
        Keys.onDownPressed: root.moved(1)
        Keys.onPressed: (e) => {
            if (root.normalMode) {
                if (e.key === Qt.Key_J || e.key === Qt.Key_Down) {
                    root.dPending = false;
                    root.moved(1);
                    e.accepted = true;
                } else if (e.key === Qt.Key_K || e.key === Qt.Key_Up) {
                    root.dPending = false;
                    root.moved(-1);
                    e.accepted = true;
                } else if (e.key === Qt.Key_D) {
                    if (root.dPending) {
                        root.clearRequested();
                        root.dPending = false;
                    } else {
                        root.dPending = true;
                    }
                    e.accepted = true;
                } else if (e.key === Qt.Key_G && (e.modifiers & Qt.ShiftModifier)) {
                    root.dPending = false;
                    root.last();
                    e.accepted = true;
                } else if (e.key === Qt.Key_G) {
                    root.dPending = false;
                    root.first();
                    e.accepted = true;
                } else if (e.key === Qt.Key_I || e.key === Qt.Key_A || e.key === Qt.Key_Slash) {
                    root.dPending = false;
                    root.insertRequested();
                    e.accepted = true;
                } else if (e.key === Qt.Key_Return || e.key === Qt.Key_Enter) {
                    root.dPending = false;
                    root.accepted();
                    e.accepted = true;
                } else if (e.key === Qt.Key_Q || e.key === Qt.Key_Escape) {
                    root.dPending = false;
                    root.dismissed();
                    e.accepted = true;
                } else {
                    root.dPending = false;
                }
            } else if (e.key === Qt.Key_Return || e.key === Qt.Key_Enter) {
                root.accepted();
                e.accepted = true;
            } else if (e.key === Qt.Key_Escape) {
                root.normalRequested();
                e.accepted = true;
            }
        }
    }

    Rectangle {
        anchors.left: field.left
        anchors.right: field.right
        anchors.top: field.bottom
        anchors.topMargin: 2 * root.s
        height: 1
        color: root.normalMode ? Theme.vermLit : Theme.faint
        opacity: root.normalMode ? 0.55 : 0
        Behavior on opacity { NumberAnimation { duration: Motion.fast; easing.type: Easing.OutCubic } }
    }

    onNormalModeChanged: dPending = false

    Text {
        id: counter
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        text: root.resultCount + " / " + root.totalCount
        color: Theme.dim
        font.family: Theme.font
        font.pixelSize: 11.5 * root.s
        font.features: { "tnum": 1 }
    }
}
