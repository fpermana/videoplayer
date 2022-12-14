/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Qt Mobility Components.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0
import QtMultimedia 5.0
//import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
//import id.fpermana.videoplayer 1.0

Item {
    id: root
    height: parent.height
    width: parent.width

    property alias duration: mediaPlayer.duration
    property alias mediaSource: mediaPlayer.source
    property alias metaData: mediaPlayer.metaData
    property alias playbackRate: mediaPlayer.playbackRate
    property alias position: mediaPlayer.position
    property alias volume: mediaPlayer.volume

    signal sizeChanged
    signal fatalError
    onHeightChanged: root.sizeChanged()

    VideoOutput {
        id: videoOutput
//        height: width
        source: mediaPlayer
        anchors {
            top : parent.top
            left: parent.left
            right: parent.right
            bottom: playbackMenu.top
        }

        MediaPlayer {
            id: mediaPlayer
            autoLoad: false
            loops: Audio.Infinite

            onError: {
                if (MediaPlayer.NoError != error) {
                    console.log("[qmlvideo] VideoItem.onError error " + error + " errorString " + errorString)
                    root.fatalError()
                }
            }
        }
    }

    Item {
        id: playbackMenu
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: 80
        RowLayout {
             anchors.fill: parent
             IconButton {
//                 icon.source: mediaPlayer.playbackState === MediaPlayer.PlayingState ? "qrc:/icon/pause.svg" : "qrc:/icon/play.svg"
                 iconSource: mediaPlayer.playbackState === MediaPlayer.PlayingState ? "qrc:/icon/pause.svg" : "qrc:/icon/play.svg"
                 onClicked: {
                     if(mediaPlayer.playbackState === MediaPlayer.PlayingState) {
                         mediaPlayer.pause()
                     }
                     else {
                         mediaPlayer.play()
                     }
                 }
             }
             IconButton {
//                 icon.source: "qrc:/icon/stop.svg"
                 iconSource: "qrc:/icon/stop.svg"
                 onClicked: {
                     mediaPlayer.stop()
                 }
             }
             SeekControl {
                 duration: mediaPlayer.duration
                 playPosition: mediaPlayer.position
                 onSeekPositionChanged: root.seek(seekPosition)
                 Layout.fillWidth: true
             }
             IconButton {
//                 icon.source: "qrc:/icon/dot-menu.svg"
                 iconSource: "qrc:/icon/dot-menu.svg"
                 onClicked: {
//                     console.log('open')
                     openFileSlidingPopup.open()

                 }
             }
         }
    }

//    FilePicker {
//        id: localFilePicker
//    }

    function start() { mediaPlayer.play() }
    function stop() { mediaPlayer.stop() }
    function seek(position) { mediaPlayer.seek(position); }
}
