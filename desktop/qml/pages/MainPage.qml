import QtQuick 2.12
import QtQuick.Controls 2.5
import "../components"

Page {
    id: root

    title: qsTr("Video Player")

    Connections {
        target: openFileSlidingPopup

        function onFileClicked(fileurl) {
            console.log(fileurl)
            if(appStackView.currentItem === root) {
                videoItem.stop()
                videoItem.mediaSource = fileurl
                videoItem.start()
            }
        }
    }

//    Loader {
//        id: videoLoader
//    }

//    Component.onCompleted: {
//        videoLoader.source = "qrc:/qml/components/VideoItem.qml"
//        videoLoader.item.mediaSource = "qrc:/video/noodle.mp4"
//    }

    VideoItem {
        id: videoItem
        anchors.fill: parent
    }
}
