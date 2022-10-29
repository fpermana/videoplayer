#ifndef FILEPICKER_H
#define FILEPICKER_H

#include <QObject>
#include "FileListModel.h"

class FilePicker : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString currentDir READ currentDir WRITE setCurrentDir NOTIFY currentDirChanged)
    Q_PROPERTY(FileListModel* fileList READ fileList CONSTANT)

public:
    explicit FilePicker(QObject *parent = nullptr);

    const QString &currentDir() const;
    void setCurrentDir(const QString &newCurrentDir);

    FileListModel* fileList() const;

signals:
    void currentDirChanged(QString currentDir);

private:
    QString m_currentDir;

    FileListModel *m_fileList;
};

#endif // FILEPICKER_H
