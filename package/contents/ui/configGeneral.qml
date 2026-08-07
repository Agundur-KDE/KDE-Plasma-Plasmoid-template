/*
 * SPDX-FileCopyrightText: 2025 Agundur <info@agundur.de>
 *
 * SPDX-License-Identifier: GPL-2.0-only OR GPL-3.0-only OR LicenseRef-KDE-Accepted-GPL
 *
 */

import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami

KCM.SimpleKCM {
    property alias cfg_Greeting: greetingField.text

    Kirigami.FormLayout {
        QQC2.TextField {
            id: greetingField
            Kirigami.FormData.label: i18nc("@label:textbox", "Greeting:")
        }
    }
}
