import QtQuick
import QtQuick.Layouts
import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.plasmoid

DropArea {
    width: 200
    height: 40

    PlasmaComponents.Label {
        text: i18n("CompactRepresentation.qml")
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: Kirigami.Theme.defaultFont.pointSize * 2
        Layout.fillWidth: true
        wrapMode: Text.Wrap
    }

}