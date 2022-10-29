#include "FileListModel.h"
#include <QUrl>

FileListModel::FileListModel(QObject *parent)
    : QAbstractListModel{parent}
{

}


int FileListModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_fileList.count();
}

QVariant FileListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant(); // Return Null variant if index is invalid
    if (index.row() > (m_fileList.count()-1) )
        return QVariant();

    QFileInfo fileInfo = m_fileList.at(index.row());

    switch (role)
    {
    case FileNameRole:
        return QVariant::fromValue(fileInfo.fileName());
    case FilePathRole:
        return QVariant::fromValue(fileInfo.filePath());
    case AbsoluteFilePathRole:
        return QVariant::fromValue(fileInfo.absoluteFilePath());
    case IsFileRole:
        return QVariant::fromValue(fileInfo.isFile());
    case IsDirRole:
        return QVariant::fromValue(fileInfo.isDir());
    case UrlStringRole:
        return QVariant(QUrl::fromLocalFile(fileInfo.absoluteFilePath()).toString());
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> FileListModel::roleNames() const
{
    QHash<int, QByteArray> result = QAbstractListModel::roleNames();
    result.insert(FileNameRole, QByteArrayLiteral("filename"));
    result.insert(FilePathRole, QByteArrayLiteral("filepath"));
    result.insert(AbsoluteFilePathRole, QByteArrayLiteral("absoluteFilepath"));
    result.insert(IsFileRole, QByteArrayLiteral("isfile"));
    result.insert(IsDirRole, QByteArrayLiteral("isdir"));
    result.insert(UrlStringRole, QByteArrayLiteral("fileurl"));
    return result;
}

const QFileInfoList &FileListModel::fileList() const
{
    return m_fileList;
}

void FileListModel::setFileList(const QFileInfoList &newFileList)
{
    emit beginResetModel();
    m_fileList = newFileList;
    emit endResetModel();
}
