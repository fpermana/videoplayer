import QtQuick 2.12
import QtQuick.Controls 2.5

Page {
    id: aboutPage
    title: qsTr("About")

    ListModel {
        id: detailModel

        ListElement {
            title: "Application License"
            detail: "This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 2 of the License.<br />This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.<br />You should have received a copy of the GNU General Public License along with this program; if not, see <a href=\"http://www.gnu.org/licenses\">http://www.gnu.org/licenses</a>."
        }
    }

    ListView {
        id: detailListView
        anchors.fill: parent
        header: Item {
            width: aboutPage.width
            height: childrenRect.height + 60
            Column {
                spacing: 10
                height: childrenRect.height
                anchors {
                    left: parent.left
                    right: parent.right
                }

                Image {
                    id: iconImage
                    source: "qrc:/icon/video.svg"
                    anchors.horizontalCenter: parent.horizontalCenter

                    sourceSize.width: parent.width/5
                    horizontalAlignment: Image.AlignHCenter
                    fillMode: Image.PreserveAspectFit
                }

                Label {
                    text: "Video Player Version 1.0"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Label {
                    text: "© Fandy Permana 2022"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Component.onCompleted: {
                    anchors.verticalCenter = parent.verticalCenter
                }
            }
        }

        model: detailModel

        delegate: ItemDelegate {
            width: detailListView.width
            height: contentColumn.height + 30
            Column {
                id: contentColumn
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: 20
                }

                Component.onCompleted: {
                    anchors.verticalCenter = parent.verticalCenter
                }

                Label {
                    text: qsTr(model.title)
                    width: parent.width
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignJustify
                    verticalAlignment: Text.AlignVCenter
                    height: paintedHeight + 15
                }
                Label {
                    text: qsTr(model.detail)
                    width: parent.width
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignJustify
                    textFormat: Text.RichText
                }
            }
        }
    }

    ToolButton {
        icon.source: "qrc:/icon/back.svg"
        anchors {
            top: parent.top
            right: parent.right
        }
        onClicked: {
            appStackView.pop()
        }
    }
}
