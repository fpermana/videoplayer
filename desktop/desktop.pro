TARGET = videoplayer
TEMPLATE = app

QT += core qml quick quickcontrols2 multimedia

CONFIG += c++11

RC_FILE += resources.rc

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets
OBJECTS_DIR=generated_files #Intermediate object files directory
MOC_DIR=generated_files #Intermediate moc files directory
RCC_DIR=generated_files #Intermediate qrc files directory

include(../src/src.pri)

include(../3rdparty/singleapplication/singleapplication.pri)
DEFINES += QAPPLICATION_CLASS=QApplication

SOURCES += main.cpp

RESOURCES += qml.qrc \
    ../asset.qrc \
    ../icon.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    qml/components/OpenFileSlidingPopup.qml \
    qml/components/OpenFileWindowPopup.qml \
    qml/components/SeekControl.qml \
    qml/components/SlidingPopup.qml \
    qml/components/WindowPopup.qml \
    qml/components/VideoDummy.qml \
    qml/components/VideoItem.qml \
    qml/main.qml \
    qml/pages/AboutPage.qml \
    qml/pages/MainPage.qml
