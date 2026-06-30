/*
 * SPDX-FileCopyrightText: 2025 Agundur <info@agundur.de>
 * SPDX-License-Identifier: GPL-2.0-only OR GPL-3.0-only OR LicenseRef-KDE-Accepted-GPL
 */
#pragma once

#include <QFileSystemWatcher>
#include <QObject>
#include <QString>
#include <qqmlregistration.h>

class FileReader : public QObject
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(QString path    READ path    WRITE setPath  NOTIFY pathChanged)
    Q_PROPERTY(QString content READ content                NOTIFY contentChanged)
    Q_PROPERTY(bool    watching READ watching              NOTIFY pathChanged)

public:
    explicit FileReader(QObject *parent = nullptr);

    QString path()    const { return m_path; }
    QString content() const { return m_content; }
    bool    watching() const { return m_watcher.files().contains(m_path); }

    void setPath(const QString &path);

    Q_INVOKABLE void reload();

Q_SIGNALS:
    void pathChanged();
    void contentChanged();

private:
    void readFile();

    QString             m_path;
    QString             m_content;
    QFileSystemWatcher  m_watcher;
};
