TEMPLATE = subdirs

equals(QT_MAJOR_VERSION, 5) {
    android {
        SUBDIRS += \
            android
    } else {
        SUBDIRS += \
            desktop
    }
}
