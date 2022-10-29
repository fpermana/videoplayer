#include "Setting.h"
#include "GlobalConstants.h"
#include <QApplication>
#include <QFont>
#include <QFontInfo>
#include <QDebug>
#include <QDir>

Setting::Setting(QObject *parent) : QSettings{QSettings::IniFormat, QSettings::UserScope, QString(SETTINGS_ORGANIZATION), QString(SETTINGS_APPLICATION),parent}
{
}

void Setting::loadSetting()
{
    setLastDir(value(LAST_DIR_KEY, QDir::currentPath()).toString());
    setLastFile(value(LAST_FILE_KEY, DEFAULT_FILE_VALUE).toString());
}

QString Setting::lastDir() const
{
    return m_lastDir;
}

void Setting::setLastDir(const QString &lastDir)
{
    if (m_lastDir == lastDir)
        return;

    m_lastDir = lastDir;
    emit lastDirChanged(m_lastDir);
}

QString Setting::lastFile() const
{
    return m_lastFile;
}

void Setting::setLastFile(const QString &lastFile)
{
    if (m_lastFile == lastFile)
        return;

    m_lastFile = lastFile;
    emit lastFileChanged(m_lastFile);
}

void Setting::saveSetting()
{
    setValue(LAST_DIR_KEY, m_lastDir);
    setValue(LAST_FILE_KEY, m_lastFile);
}

void Setting::resetSetting()
{
    setValue(LAST_DIR_KEY, QDir::currentPath());
    setValue(LAST_FILE_KEY, DEFAULT_FILE_VALUE);
}
