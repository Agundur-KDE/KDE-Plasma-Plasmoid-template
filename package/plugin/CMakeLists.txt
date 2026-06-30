find_package(Qt6 REQUIRED COMPONENTS Core Qml)

include(ECMQmlModule)

ecm_add_qml_module(myplasmoidplugin
    URI de.agundur.myplasmoid
    VERSION 1.0
    GENERATE_PLUGIN_SOURCE
)

target_sources(myplasmoidplugin PRIVATE
    FileReader.cpp FileReader.h
)

target_link_libraries(myplasmoidplugin PRIVATE Qt6::Core Qt6::Qml)

ecm_finalize_qml_module(myplasmoidplugin)
