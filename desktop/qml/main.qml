import QtQuick 2.15
//import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import id.fpermana.videoplayer 1.0
import "components"

Window {
    id: applicationWindow
    visible: true
    minimumWidth: 960
    minimumHeight: 640
    title: qsTr("Video Player")

    flags: Qt.Window | Qt.FramelessWindowHint

    Rectangle {
        id: topMenu
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        Text {
            text: applicationWindow.title
            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
                leftMargin: 10
            }

            verticalAlignment: Text.AlignVCenter
        }

        height: 40
        color: "gray"

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            property real startX: 0
            property real startY: 0
            onPressed: {
                startX = mouseX
                startY = mouseY
            }
            onPositionChanged: {
                if(pressed) {
                    applicationWindow.x += (mouseX - startX)
                    applicationWindow.y += (mouseY - startY)
                }
            }
        }

        Row {
            id: toolButton
            anchors {
                right: parent.right
                top: parent.top
                bottom: parent.bottom
            }
            layoutDirection: Qt.RightToLeft

            IconButton {
                iconSource: "qrc:/icon/close.svg"
                onClicked: {
                    Qt.quit()
                }
            }
            IconButton {
                anchors.verticalCenter: parent.verticalCenter
                iconSource: "qrc:/icon/maximize.svg"

                onClicked: {
                    if(applicationWindow.height === applicationWindow.screen.desktopAvailableHeight && applicationWindow.width === applicationWindow.screen.desktopAvailableWidth)
                        applicationWindow.showNormal()
                    else
                        applicationWindow.showMaximized()
                }
            }
            IconButton {
                anchors.verticalCenter: parent.verticalCenter
                iconSource: "qrc:/icon/minimize.svg"
                onClicked: applicationWindow.showMinimized()
            }
        }
    }

    Setting {
        id: setting
    }
    FilePicker {
        id: filePicker
    }

    VideoItem {
        id: videoItem
        anchors.fill: parent
        anchors.topMargin: topMenu.height
    }

    OpenFileSlidingPopup {
        id: openFileSlidingPopup
        model: filePicker.fileList

        onDirClicked: {
            setting.lastDir = filepath
            filePicker.currentDir = filepath
        }
        onFileClicked: {
            setting.lastFile = fileurl
            videoItem.stop()
            videoItem.mediaSource = fileurl
            videoItem.start()
        }
    }

    Component.onCompleted: {
        setting.loadSetting();
//        console.log(setting.lastDir)
        filePicker.currentDir = setting.lastDir;
    }
    Component.onDestruction: {
        setting.saveSetting();
    }

    Rectangle {
        id: overlay
        anchors.fill: parent

        color: "black"
        opacity: 0

        states: State {
            name: "dim"
            PropertyChanges { target: overlay; opacity: 0.5 }
        }

        transitions: Transition {
            PropertyAnimation { target: overlay; properties: "opacity"; duration: 300 }
        }

        MouseArea {
            anchors.fill: parent
            enabled: overlay.state === "dim"
            visible: overlay.state === "dim"
            onClicked: undim()
        }
    }

    function dim() {
        overlay.state = "dim";
    }

    function undim() {
        overlay.state = "";
    }
}
