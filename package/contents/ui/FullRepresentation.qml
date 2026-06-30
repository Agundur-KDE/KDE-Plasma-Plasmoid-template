import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents
import de.agundur.myplasmoid

ColumnLayout {
    anchors.fill: parent
    anchors.margins: Kirigami.Units.largeSpacing
    spacing: Kirigami.Units.largeSpacing

    // FileReader watches the file and updates automatically on change.
    FileReader {
        id: reader
        path: Plasmoid.configuration.Host  // replace with your actual file path
    }

    PlasmaComponents.Label {
        text: i18n("FullRepresentation.qml")
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: Kirigami.Theme.defaultFont.pointSize * 2
        Layout.fillWidth: true
        wrapMode: Text.Wrap
    }

    PlasmaComponents.Label {
        text: reader.content || i18n("(no file loaded)")
        Layout.fillWidth: true
        wrapMode: Text.Wrap
        font.pixelSize: Kirigami.Theme.defaultFont.pointSize
        opacity: 0.7
    }

    PlasmaComponents.Button {
        text: i18n("Reload")
        Layout.alignment: Qt.AlignHCenter
        onClicked: reader.reload()
    }
}
