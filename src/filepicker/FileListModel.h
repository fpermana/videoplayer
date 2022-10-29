#ifndef FILELISTMODEL_H
#define FILELISTMODEL_H

#include <QAbstractListModel>
#include <QObject>
#include <QFileInfoList>

class FileListModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles  {
        FileNameRole = Qt::UserRole + 1,
        FilePathRole = Qt::UserRole + 2,
        AbsoluteFilePathRole = Qt::UserRole + 3,
        IsFileRole = Qt::UserRole + 4,
        IsDirRole = Qt::UserRole + 5,
        UrlStringRole = Qt::UserRole + 6,
    };
    Q_ENUM(Roles)

    explicit FileListModel(QObject *parent = nullptr);

    // QAbstractItemModel interface
public:
    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;

    const QFileInfoList &fileList() const;
    void setFileList(const QFileInfoList &newFileList);

private:
    QFileInfoList m_fileList;
};

#endif // FILELISTMODEL_H
