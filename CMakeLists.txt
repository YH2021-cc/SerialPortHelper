cmake_minimum_required(VERSION 3.16)

project(SerialPortHelper VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick SerialPort Core)
set(CMAKE_AUTORCC ON)

qt_add_executable(appSerialPortHelper
    main.cpp
    app_icon.rc
)

qt_add_qml_module(appSerialPortHelper
    URI SerialPortHelper
    VERSION 1.0
    QML_FILES
        Main.qml
    QML_FILES
         UI/SendAreaUi.qml
         UI/SerialPortSettingUi.qml
         UI/RecvAreaUi.qml
         UI/SPHComboBox.qml
         UI/SPHButton.qml
         UI/SPHIconButton.qml
         UI/SPHCheckBox.qml
         UI/SerialPortTitle.qml
         UI/SPHToolTip.qml
         UI/SPHMessage.qml
         UI/SPHMessageBox.qml
    RESOURCES
        resource.qrc
    SOURCES
        InterFace/SerialPortEngine.h
        InterFace/SerialPortEngine.cpp
        InterFace/SerialPortSetting.h
        InterFace/SerialPortSetting.cpp
        InterFace/SerialPortRecvArea.h
        InterFace/SerialPortRecvArea.cpp
        InterFace/SerialPortSendArea.h
        InterFace/SerialPortSendArea.cpp



)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appSerialPortHelper PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appSerialPortHelper
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appSerialPortHelper
    PRIVATE Qt6::Quick
    Qt6::SerialPort
    Qt6::Core
)

include(GNUInstallDirs)
install(TARGETS appSerialPortHelper
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
