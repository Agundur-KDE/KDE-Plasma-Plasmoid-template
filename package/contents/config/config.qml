/*
 * SPDX-FileCopyrightText: 2025 Agundur <info@agundur.de>
 *
 * SPDX-License-Identifier: GPL-2.0-only OR GPL-3.0-only OR LicenseRef-KDE-Accepted-GPL
 *
 */

import QtQuick 2.15
import org.kde.plasma.configuration 2.0

ConfigModel {
    ConfigCategory {
        name: i18nc("@title", "General")
        icon: "preferences-general"
        source: "configGeneral.qml"
    }

}
