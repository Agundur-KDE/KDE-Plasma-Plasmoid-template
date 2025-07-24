import QtQuick
import QtQuick.Layouts
import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid

PlasmoidItem {
    preferredRepresentation: {
        const edge = Plasmoid.location;
        if (edge === PlasmaCore.Types.TopEdge || edge === PlasmaCore.Types.BottomEdge || edge === PlasmaCore.Types.LeftEdge || edge === PlasmaCore.Types.RightEdge)
            return compactRepresentation;

        return fullRepresentation;
    }
    Plasmoid.title: i18n("myplasmoid")
    Plasmoid.status: PlasmaCore.Types.ActiveStatus
    Plasmoid.backgroundHints: PlasmaCore.Types.DefaultBackground | PlasmaCore.Types.ConfigurableBackground
    toolTipMainText: Plasmoid.title

    fullRepresentation: FullRepresentation {
        id: full

        Layout.minimumWidth: 320
        Layout.minimumHeight: 300
        Component.onCompleted: {
            //Your setting from configNetwork.qml"
            console.log(i18n("setting from config:: %1").arg(Plasmoid.configuration.Host));
        }
    }

    compactRepresentation: MouseArea {
        id: compact

        DropArea {
            id: compactDrop

            z: 1
            anchors.fill: parent
            onEntered: (drag) => {
                if (drag.hasUrls) {
                    root.keepOpenDuringDrop = true;
                    expanded = !expanded;
                }
            }
        }

        MouseArea {
            //use "QT_QPA_PLATFORM=xcb plasmoidviewer -a package/" for testing on wayland
            //https://bugs.kde.org/show_bug.cgi?id=506106

            anchors.fill: parent
            z: 0
            onClicked: {
                expanded = !expanded;
                cursorShape:
                Qt.PointingHandCursor;
            }
        }

        Kirigami.Icon {
            source: Plasmoid.icon
            anchors.fill: parent
        }

    }

}
