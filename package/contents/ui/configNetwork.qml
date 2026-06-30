/*
 * SPDX-FileCopyrightText: 2025 Agundur <info@agundur.de>
 *
 * SPDX-License-Identifier: GPL-2.0-only OR GPL-3.0-only OR LicenseRef-KDE-Accepted-GPL
 */

import QtQuick
import QtQuick.Controls as QtControls
import QtQuick.Layouts
import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami

KCM.SimpleKCM {
    property string cfg_Host

    Kirigami.FormLayout {
        QtControls.TextField {
            id: ipTextField
            inputMask: "000.000.000.000"
            Layout.fillWidth: true
            Kirigami.FormData.label: i18n("IP:")
            text: cfg_Host
            onEditingFinished: cfg_Host = text
        }
    }
}
