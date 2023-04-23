include(ExternalProject)

set(SPDLOG_ROOT ${PROJECT_SOURCE_DIR}/thirdparty/spdlog)
set(SPDLOG_NAME spdlog-1.9.2.tar.gz)
set(SPDLOG_URL https://github.com/gabime/spdlog/archive/refs/tags/v1.9.2.tar.gz)
set(SPDLOG_BUILD_DIR ${SPDLOG_ROOT}/src/SPDLOG/build)
set(SPDLOG_CONFIGURE mkdir -p ${SPDLOG_BUILD_DIR} && cd ${SPDLOG_BUILD_DIR} && cmake .. -DCMAKE_INSTALL_PREFIX=${SPDLOG_ROOT} -DSPDLOG_BUILD_EXAMPLE=OFF -DSPDLOG_BUILD_SHARED=ON)
set(SPDLOG_MAKE cd ${SPDLOG_BUILD_DIR} && make -j${PARALLELISM})
set(SPDLOG_INSTALL cd ${SPDLOG_BUILD_DIR} && make install)

set(SPDLOG_INCLUDE_DIR ${SPDLOG_ROOT}/include)
set(SPDLOG_LIB ${SPDLOG_ROOT}/lib/libspdlog.so)
set(SPDLOG_LIB_DIR ${SPDLOG_ROOT}/lib)

if (EXISTS ${SPDLOG_INCLUDE_DIR})
    add_custom_target(SPDLOG)
else ()
    ExternalProject_Add(SPDLOG
            URL ${SPDLOG_URL}
            DOWNLOAD_NAME ${SPDLOG_NAME}
            PREFIX ${SPDLOG_ROOT}
            CONFIGURE_COMMAND ${SPDLOG_CONFIGURE}
            BUILD_COMMAND ${SPDLOG_MAKE}
            INSTALL_COMMAND ${SPDLOG_INSTALL}
            BUILD_ALWAYS FALSE
    )
endif ()

message("spdlog output with header directory: ${SPDLOG_INCLUDE_DIR}, library: ${SPDLOG_LIB}")