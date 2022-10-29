import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import id.fpermana.videoplayer 1.0
import "components"

ApplicationWindow {
    id: applicationWindow
    visible: true
    minimumWidth: 960
    minimumHeight: 640
    title: qsTr("Video Player")
    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
//            Action {
//                text: qsTr("&Open...")
//                onTriggered: {
//                    console.log("open")
//                    openFileWindowPopup.open()
//                }
//            }
//            MenuSeparator { }
            Action {
                text: qsTr("&Quit")
                onTriggered: {
                    console.log("quit")
                    Qt.quit()
                }
            }
        }
        Menu {
            title: qsTr("&Help")
            Action {
                text: qsTr("&About")
                onTriggered: {
                    console.log("about")
                    onClicked: {
                        openFileSlidingPopup.close()
                        appStackView.push("qrc:/qml/pages/AboutPage.qml")
                    }
                }
            }
        }
    }

    Setting {
        id: setting
    }
    FilePicker {
        id: filePicker
    }

    StackView {
        id: appStackView
        initialItem: "qrc:/qml/pages/MainPage.qml"
        anchors.fill: parent
    }
//    OpenFileWindowPopup {
//        id: openFileWindowPopup
//    }
    OpenFileSlidingPopup {
        id: openFileSlidingPopup
        model: filePicker.fileList

        onDirClicked: {
            setting.lastDir = filepath
            filePicker.currentDir = filepath
        }
        onFileClicked: {
            setting.lastFile = fileurl
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
