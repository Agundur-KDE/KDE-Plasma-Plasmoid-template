import QtQuick
import QtQuick.Layouts
import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid

PlasmoidItem {
    id: root

    implicitWidth: Kirigami.Units.gridUnit * 30
    implicitHeight: Kirigami.Units.gridUnit * 25
    clip: true
    // Wechsel zwischen compact/full abhängig von der Größe
    preferredRepresentation: (width < 200 || height < 100) ? compactRepresentation : fullRepresentation

    fullRepresentation: FullRepresentation {
        focus: true
    }

    compactRepresentation: CompactRepresentation {
        focus: true
    }

}
