import QtQuick 2.4
import QtQuick.Window 2.0
import QtQuick.Controls 2.15

Window {
    id: dialog
    property alias title: titleText.text

    default property alias children: content.data

    signal accepted
    signal rejected
    signal opened
    signal closed

    height: applicationWindow.height/2
    width: applicationWindow.width/2

    flags: Qt.Dialog | Qt.FramelessWindowHint
//    modality: Qt.ApplicationModal

    function accept() {
        applicationWindow.undim();
        dialog.accepted();
        dialog.close();
    }

    function reject() {
        applicationWindow.undim();
        dialog.rejected();
        dialog.close();
    }

    function open() {
        applicationWindow.dim();
        dialog.opened();
        dialog.show()
    }

    Text {
        id: titleText
        anchors {
            top: parent.top
            left: parent.left
            right: closeButton.left
        }
        horizontalAlignment: Text.AlignHCenter
    }

    ToolButton {
        id: closeButton
        icon.source: "qrc:/icon/close.svg"
        height: 20
        width: 20
        anchors {
            top: parent.top
            right: parent.right
        }
        onClicked: {
            dialog.reject()
        }
    }

    Rectangle {
        id: content
        anchors {
            top: titleText.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
    }

    MouseArea {
        parent: overlay
        anchors.fill: parent
        onClicked: {
            dialog.reject()
        }
        enabled: dialog.visible
        visible: dialog.visible
    }
}
