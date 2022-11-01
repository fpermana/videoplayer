import QtQuick 2.0

Rectangle {
    id: root
    height: 40
    width: 40

    property alias iconSource: icon.source
    signal clicked

    color: mouseArea.pressed ? "grey" : "white"

    Image {
        id: icon
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
        height: 25
        width: 25
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
