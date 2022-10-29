#include "FilePicker.h"
#include <QDir>
#include <QStringList>

FilePicker::FilePicker(QObject *parent) : QObject{parent}
{
    m_fileList = new FileListModel(this);
}

const QString &FilePicker::currentDir() const
{
    return m_currentDir;
}

void FilePicker::setCurrentDir(const QString &newCurrentDir)
{
    if (m_currentDir == newCurrentDir)
        return;

    m_currentDir = newCurrentDir;

    QDir currentDir(m_currentDir);
    currentDir.setSorting(QDir::Name | QDir::IgnoreCase);
    QFileInfoList fileInfoList;

    foreach (const QFileInfo &fileInfo, currentDir.entryInfoList(QDir::Dirs | QDir::NoDot)) {
        fileInfoList.append(fileInfo);
    }
    foreach (const QFileInfo &fileInfo, currentDir.entryInfoList(QStringList() << "*.avi" << "*.mp4" << "*.mkv" << "*.wmv", QDir::Files)) {
        fileInfoList.append(fileInfo);
    }
    m_fileList->setFileList(fileInfoList);

    emit currentDirChanged(m_currentDir);
}

FileListModel *FilePicker::fileList() const
{
    return m_fileList;
}
