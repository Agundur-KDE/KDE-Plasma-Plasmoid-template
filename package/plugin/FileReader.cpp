/*
 * SPDX-FileCopyrightText: 2025 Agundur <info@agundur.de>
 * SPDX-License-Identifier: GPL-2.0-only OR GPL-3.0-only OR LicenseRef-KDE-Accepted-GPL
 */
#include "FileReader.h"

#include <QFile>
#include <QTextStream>

FileReader::FileReader(QObject *parent)
    : QObject(parent)
{
    connect(&m_watcher, &QFileSystemWatcher::fileChanged, this, &FileReader::readFile);
}

void FileReader::setPath(const QString &path)
{
    if (m_path == path)
        return;

    if (!m_path.isEmpty())
        m_watcher.removePath(m_path);

    m_path = path;

    if (!m_path.isEmpty()) {
        m_watcher.addPath(m_path);
        readFile();
    }

    Q_EMIT pathChanged();
}

void FileReader::reload()
{
    readFile();
}

void FileReader::readFile()
{
    QFile f(m_path);
    QString newContent;

    if (f.open(QIODevice::ReadOnly | QIODevice::Text))
        newContent = QTextStream(&f).readAll();

    if (newContent == m_content)
        return;

    m_content = newContent;
    Q_EMIT contentChanged();
}
