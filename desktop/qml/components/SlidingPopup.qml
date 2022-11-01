import QtQuick 2.4
//import QtQuick.Window 2.0
//import QtQuick.Controls 2.15

FocusScope {
    id: dialog
    property alias title: titleText.text
    property bool destroyOnClosing: false

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

        if (destroyOnClosing) {
            dialog.destroy(5000);
        }
    }

    Rectangle {
        id: content
        color: "white"
        anchors {
            fill: parent
            topMargin: 45
        }
    }

    Rectangle  {
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: 45
        color: "white"

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

        Rectangle {
            id: bottomLine
            color: "lightgray"
            height: 1
            anchors {
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }
        }

        Text {
            id: titleText
            anchors {
                top: topLine.bottom
                left: parent.left
                right: parent.right
                bottom: bottomLine.top
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        IconButton {
            id: closeButton
            iconSource: "qrc:/icon/down.svg"
            height: titleText.height
            width: titleText.height
            anchors {
                right: parent.right
            }
            onClicked: {
                dialog.reject()
            }
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
