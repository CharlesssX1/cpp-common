option(WITHOUT_CONSOLE_LOGGER "enable console logger or not" OFF)
include_directories(
        ${SPDLOG_INCLUDE_DIR}
        ${ABSEIL_INCLUDE_DIR}
)

link_directories(
        ${ABSEIL_LIB_DIR}
)

add_library(baselog SHARED logging.cpp)
target_link_libraries(baselog
        absl_base
        absl_debugging_internal
        absl_failure_signal_handler
        absl_examine_stack
        absl_stacktrace)
add_dependencies(baselog ABSEIL SPDLOG)

if (WITHOUT_CONSOLE_LOGGER)
    target_compile_definitions(baselog PRIVARE WITHOUT_CONSOLE_LOGGER)
endif ()

set_target_properties(baselog PROPERTIES PUBLIC_HEADER "${CMAKE_CURRENT_SOURCE_DIR}/logging.h")
INSTALL(TARGETS baselog
        LIBRARY DESTINATION ${CMAKE_INSTALL_PREFIX}/lib
        PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_PREFIX}/include/common/log
        )
