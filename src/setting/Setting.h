#ifndef SETTING_H
#define SETTING_H

#include <QSettings>

class Setting : public QSettings
{
    Q_OBJECT
    Q_PROPERTY(QString lastDir READ lastDir WRITE setLastDir NOTIFY lastDirChanged)
    Q_PROPERTY(QString lastFile READ lastFile WRITE setLastFile NOTIFY lastFileChanged)

public:
    explicit Setting(QObject *parent = nullptr);


    QString lastDir() const;
    void setLastDir(const QString &lastDir);

    QString lastFile() const;
    void setLastFile(const QString &lastFile);

public slots:
    void loadSetting();
    void saveSetting();
    void resetSetting();

signals:
    void lastDirChanged(QString lastDir);
    void lastFileChanged(QString lastFile);

private:
    QString m_lastDir;
    QString m_lastFile;
};

#endif // SETTING_H
