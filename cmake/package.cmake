if (BUILD_LOG)
    install(FILES ${ABSEIL_LIB_DIR}/libabsl_base.so DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)
    install(FILES ${ABSEIL_LIB_DIR}/libabsl_base.so.2206.0.0 DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)

    install(FILES ${ABSEIL_LIB_DIR}/libabsl_debugging_internal.so DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)
    install(FILES ${ABSEIL_LIB_DIR}/libabsl_debugging_internal.so.2206.0.0 DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)

    install(FILES ${ABSEIL_LIB_DIR}/libabsl_failure_signal_handler.so DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)
    install(FILES ${ABSEIL_LIB_DIR}/libabsl_failure_signal_handler.so.2206.0.0 DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)

    install(FILES ${ABSEIL_LIB_DIR}/libabsl_examine_stack.so DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)
    install(FILES ${ABSEIL_LIB_DIR}/libabsl_examine_stack.so.2206.0.0 DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)

    install(FILES ${ABSEIL_LIB_DIR}/libabsl_stacktrace.so DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)
    install(FILES ${ABSEIL_LIB_DIR}/libabsl_stacktrace.so.2206.0.0 DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)

    install(FILES ${ABSEIL_LIB_DIR}/libabsl_raw_logging_internal.so DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)
    install(FILES ${ABSEIL_LIB_DIR}/libabsl_raw_logging_internal.so.2206.0.0 DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)

    install(FILES ${ABSEIL_LIB_DIR}/libabsl_spinlock_wait.so DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)
    install(FILES ${ABSEIL_LIB_DIR}/libabsl_spinlock_wait.so.2206.0.0 DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)

    install(FILES ${ABSEIL_LIB_DIR}/libabsl_symbolize.so DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)
    install(FILES ${ABSEIL_LIB_DIR}/libabsl_symbolize.so.2206.0.0 DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)

    install(FILES ${ABSEIL_LIB_DIR}/libabsl_demangle_internal.so DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)
    install(FILES ${ABSEIL_LIB_DIR}/libabsl_demangle_internal.so.2206.0.0 DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)

    install(FILES ${ABSEIL_LIB_DIR}/libabsl_malloc_internal.so DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)
    install(FILES ${ABSEIL_LIB_DIR}/libabsl_malloc_internal.so.2206.0.0 DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)
endif ()

