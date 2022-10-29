import QtQuick 2.4
//import QtQuick.Window 2.0
import QtQuick.Controls 2.15

FocusScope {
    id: dialog
    property alias title: titleText.text

    default property alias children: content.data

    signal accepted
    signal rejected
    signal opened
    signal closed

    parent: applicationWindow.contentItem
    height: applicationWindow.height
    anchors { left: parent.left; right: parent.right; top: parent.bottom }

    function accept() {
        dialog.accepted();
        dialog.close();
    }

    function reject() {
        dialog.rejected();
        dialog.close();
    }

    function open() {
        dialog.state = "open";
        dialog.opened();
    }

    function close() {
        dialog.state = "";
    }

    Rectangle {
        id: content
        color: "white"
        anchors {
            fill: parent
            topMargin: titleText.height + topLine.height
        }
    }

    Rectangle {
        id: topLine
        color: "black"
        height: 2
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
    }

    Text {
        id: titleText
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        height: 40
    }

    ToolButton {
        id: closeButton
        icon {
            source: "qrc:/icon/down.svg"
            height: 20
            width: 20
        }
        height: titleText.height
        width: titleText.height
        anchors {
            top: parent.top
            right: parent.right
        }
        onClicked: {
            dialog.reject()
        }
    }

    MouseArea {
        z: -1
        anchors.fill: root
    }

    states: State {
        name: "open"
        AnchorChanges { target: root; anchors { top: parent.top; bottom: parent.bottom } }
    }

    transitions: Transition {
        AnchorAnimation { easing.type: Easing.OutQuart; duration: 300 }
    }
}
