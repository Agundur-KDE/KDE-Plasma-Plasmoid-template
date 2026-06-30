import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents

ColumnLayout {
    anchors.fill: parent
    anchors.margins: Kirigami.Units.largeSpacing
    spacing: Kirigami.Units.largeSpacing

    PlasmaComponents.Label {
        text: i18n("FullRepresentation.qml")
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: Kirigami.Theme.defaultFont.pointSize * 2
        Layout.fillWidth: true
        wrapMode: Text.Wrap
    }
}
