find_package(Qt6 REQUIRED COMPONENTS Core Quick)

qt_add_qml_module(myplasmoidplugin
    URI de.agundur.myplasmoid
    VERSION 1.0
    SOURCES
        FileReader.cpp FileReader.h
    NO_PLUGIN_OPTIONAL
)

target_link_libraries(myplasmoidplugin PRIVATE Qt6::Core Qt6::Quick)

install(TARGETS myplasmoidplugin
    LIBRARY DESTINATION ${KDE_INSTALL_QMLDIR}/de/agundur/myplasmoid
)
install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/de/agundur/myplasmoid/qmldir
    ${CMAKE_CURRENT_BINARY_DIR}/de/agundur/myplasmoid/myplasmoidplugin.qmltypes
    DESTINATION ${KDE_INSTALL_QMLDIR}/de/agundur/myplasmoid
)
