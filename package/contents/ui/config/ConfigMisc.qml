import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami

KCM.SimpleKCM {
    id: root

    property string cfg_TargetProject
    property int cfg_RefreshInterval
    property string cfg_TargetProjectDefault: "Agundur"
    property int cfg_RefreshIntervalDefault: 60

    Kirigami.FormLayout {
        QQC2.TextField {
            id: update_TargetProject

            Kirigami.FormData.label: i18n("stringe")
            text: cfg_TargetProject
            onTextChanged: cfg_TargetProject = text
        }

        QQC2.SpinBox {
            id: update_RefreshInterval

            Kirigami.FormData.label: i18n("int")
            from: 10
            to: 3600
            value: cfg_RefreshInterval
            onValueChanged: cfg_RefreshInterval = value
        }

    }

}
