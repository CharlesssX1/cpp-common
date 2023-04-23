include(ExternalProject)

set(ABSEIL_ROOT ${PROJECT_SOURCE_DIR}/thirdparty/abseil-cpp)
set(ABSEIL_NAME abseil-cpp-20220623.0.tar.gz)
set(ABSEIL_URL https://github.com/abseil/abseil-cpp/archive/refs/tags/20220623.0.tar.gz)
set(ABSEIL_BUILD_DIR ${ABSEIL_ROOT}/src/ABSEIL/build)
set(ABSEIL_CONFIGURE mkdir -p ${ABSEIL_BUILD_DIR} && cd ${ABSEIL_BUILD_DIR} && cmake .. -DCMAKE_CXX_STANDARD=17 -DABSL_CXX_STANDARD=17 -DCMAKE_INSTALL_PREFIX=${ABSEIL_ROOT} -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE -DABSL_ENABLE_INSTALL=ON -DBUILD_SHARED_LIBS=ON -DCMAKE_MODULE_LINKER_FLAGS=\"-Wl,--no-undefined -Wl,--no-undefined\")
set(ABSEIL_MAKE cd ${ABSEIL_BUILD_DIR} && make -j${PARALLELISM})
set(ABSEIL_INSTALL cd ${ABSEIL_BUILD_DIR} && make install)

set(ABSEIL_INCLUDE_DIR ${ABSEIL_ROOT}/include)
set(ABSEIL_LIB_DIR ${ABSEIL_ROOT}/lib)

if (EXISTS ${ABSEIL_INCLUDE_DIR})
    add_custom_target(ABSEIL)
else ()
    ExternalProject_Add(ABSEIL
            URL ${ABSEIL_URL}
            DOWNLOAD_NAME ${ABSEIL_NAME}
            PREFIX ${ABSEIL_ROOT}
            CONFIGURE_COMMAND ${ABSEIL_CONFIGURE}
            BUILD_COMMAND ${ABSEIL_MAKE}
            INSTALL_COMMAND ${ABSEIL_INSTALL}
            BUILD_ALWAYS FALSE
    )
endif ()

message("ABSEIL output with header directory: ${ABSEIL_INCLUDE_DIR}, library: ${ABSEIL_LIB_DIR}")
