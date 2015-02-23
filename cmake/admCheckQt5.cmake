
MACRO(checkQt5)
#        SET(QT5_CHECKED 1)
	IF (NOT QT5_CHECKED)
		OPTION(QT5 "" ON)

		MESSAGE(STATUS "Checking for Qt 5")
		MESSAGE(STATUS "*****************")
		IF (QT5)
		        MESSAGE(STATUS "  Checking for Qt5Core")
			FIND_PACKAGE(Qt5Core)	
		        MESSAGE(STATUS "  Checking for Qt5Widgets")
			FIND_PACKAGE(Qt5Widgets)	
                        IF(Qt5Core_FOUND AND Qt5Widgets_FOUND)
		                MESSAGE(STATUS "  Qt5 found ")
                                SET(QT5_FOUND 1)
                                SET(QT_INCLUDES ${Qt5Core_INCLUDE_DIRS} ${Qt5Widgets_INCLUDE_DIRS} ${Qt5Widgets_INCLUDE_DIRS}/QtWidgets)
                                SET(QT_QTCORE_LIBRARY ${Qt5Core_LIBRARIES})
                                SET(QT_QTGUI_LIBRARY  ${Qt5Widgets_LIBRARIES})
                                SET(QT_DEFINITIONS    ${Qt5Core_DEFINITIONS} ${Qt5Widgets_DEFINITIONS})
			        STRING(REGEX REPLACE "[\\]" "/" QT_INCLUDES "${QT_INCLUDES}")	# backslashes aren't taken care of properly on Windows
			        PRINT_LIBRARY_INFO("Qt 5" QT5_FOUND ": ${QT_INCLUDES} : ${QT_DEFINITIONS}" ": ${QT_QTCORE_LIBRARY} : ${QT_QTGUI_LIBRARY}")

			        MARK_AS_ADVANCED(LRELEASE_EXECUTABLE)
			        MARK_AS_ADVANCED(QT_MKSPECS_DIR)
			        MARK_AS_ADVANCED(QT_PLUGINS_DIR)
			        MARK_AS_ADVANCED(QT_QMAKE_EXECUTABLE)
                                # Version independant macros
                                MACRO(ADM_QT_WRAP_UI a)
                                        QT5_WRAP_UI(${a} ${ARGN})
                                ENDMACRO(ADM_QT_WRAP_UI a)
                                MACRO(ADM_QT_WRAP_CPP a)
                                        QT5_WRAP_CPP(${a} ${ARGN})
                                ENDMACRO(ADM_QT_WRAP_CPP a)
                                MACRO(ADM_QT_ADD_RESOURCES a)
                                        QT5_ADD_RESOURCES(${a} ${ARGN})
                                ENDMACRO(ADM_QT_ADD_RESOURCES a)
                                SET(QT_EXTENSION qt5)
                                SET(QT_LIBRARY_EXTENSION QT5)
                                SET(ADM_QT_VERSION 5)
                                if (Qt5_POSITION_INDEPENDENT_CODE)
                                       SET(CMAKE_POSITION_INDEPENDENT_CODE ON)
                                endif (Qt5_POSITION_INDEPENDENT_CODE)
                        ELSE(Qt5Core_FOUND AND Qt5Widgets_FOUND)
                                MESSAGE(STATUS "Some Qt5 components are missing")
                        ENDIF(Qt5Core_FOUND AND Qt5Widgets_FOUND)
                        
		ELSE (QT5)
			MESSAGE("${MSG_DISABLE_OPTION}")
		ENDIF (QT5)

		SET(QT5_CHECKED 1)

		MESSAGE("")
	ENDIF (NOT QT5_CHECKED)
ENDMACRO(checkQt5)