import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid
import de.agundur.myplasmoid

PlasmoidItem {
    // fullRepresentation/compactRepresentation stay INLINE in this file
    // rather than in separate FullRepresentation.qml/CompactRepresentation.qml
    // files on purpose: QML ids are scoped to the file/component they're
    // declared in, so a separate file can't see `id: root` here — any
    // `root.something` reference inside it fails at runtime with
    // "root is not defined". Keep everything that needs `root` in this file.
    id: root

    // Example custom state — this is the kind of thing that needs `root.`
    // to reach from fullRepresentation below (Plasmoid.* properties don't
    // need it, they're already globally accessible).
    property int exampleCounter: 0

    preferredRepresentation: {
        const edge = Plasmoid.location;
        if (edge === PlasmaCore.Types.TopEdge || edge === PlasmaCore.Types.BottomEdge
                || edge === PlasmaCore.Types.LeftEdge || edge === PlasmaCore.Types.RightEdge)
            return compactRepresentation;
        return fullRepresentation;
    }

    Plasmoid.title: i18n("myplasmoid")
    Plasmoid.status: PlasmaCore.Types.ActiveStatus
    Plasmoid.backgroundHints: PlasmaCore.Types.DefaultBackground | PlasmaCore.Types.ConfigurableBackground
    toolTipMainText: Plasmoid.title

    fullRepresentation: ColumnLayout {
        Layout.minimumWidth: 320
        Layout.minimumHeight: 300
        anchors.margins: Kirigami.Units.largeSpacing
        spacing: Kirigami.Units.largeSpacing

        // FileReader watches the file and updates automatically on change.
        FileReader {
            id: reader
            path: Plasmoid.configuration.Host  // replace with your actual file path
        }

        PlasmaComponents.Label {
            text: i18n("FullRepresentation.qml — root.exampleCounter: %1", root.exampleCounter)
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

    compactRepresentation: Item {
        DropArea {
            anchors.fill: parent
            z: 1
            onEntered: (drag) => {
                if (drag.hasUrls)
                    expanded = !expanded;
            }
        }

        MouseArea {
            anchors.fill: parent
            z: 0
            cursorShape: Qt.PointingHandCursor
            onClicked: expanded = !expanded
        }

        Kirigami.Icon {
            source: Plasmoid.icon
            anchors.fill: parent
        }
    }
}
