import QtQuick 2.0
import QtQuick.Controls 2.15

WindowPopup {
    id: root
    width: 400
    height: 194
    title: "Open File..."

    property alias model: listView.model

    signal dirClicked(string filepath)
    signal fileClicked(string fileurl)

    ListView {
        id: listView
        anchors.fill: parent
        clip: true

        delegate: Rectangle {
            height: 40
            width: root.width
            color: index % 2 ? "white" : "#ddebf7"

            Item {
                id: icon
                height: parent.height
                width: parent.height
                Image {
                    height: parent.height/2
                    width: parent.width/2
                    anchors.centerIn: parent
                    fillMode: Image.PreserveAspectFit
                    verticalAlignment: Image.AlignVCenter
                    source: model.isfile ? "qrc:/icon/file.svg" : (model.filename === ".." ? "qrc:/icon/up.svg" : "qrc:/icon/folder.svg")
                }
//                visible: filename !== ".."
            }

            Text {
                id: filenameText
                anchors {
                    left: icon.right
                    right: parent.right
                }
                height: parent.height
                text: model.filename
                verticalAlignment: Text.AlignVCenter
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if(model.isfile) {
                        fileClicked(model.fileurl)
                        close()
                    }
                    else {
                        dirClicked(model.absoluteFilepath)
                    }
                }
            }
        }
    }
}

