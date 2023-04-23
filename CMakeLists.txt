cmake_minimum_required(VERSION 3.10.2)
project(common)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_POSITION_INDEPENDENT_CODE TRUE)

SET(CMAKE_CXX_FLAGS_DEBUG "$ENV{CXXFLAGS} -O0 -Wall -g -ggdb -Wl, --no-as-needed")
SET(CMAKE_CXX_FLAGS_RELEASE "$ENV{CXXFLAGS} -Wall -O2 -Wl, --no-as-needed")

option(BUILD_EXAMPLE "if ON, example will be built" ON)
option(BUILD_LOG "if ON, log module will bu built" ON)

if (BUILD_LOG)
    include(cmake/spdlog.cmake)
    include(cmake/abseil.cmake)
endif ()

if (BUILD_LOG)
    add_subdirectory(log)
endif ()

if (BUILD_EXAMPLE MATCHES ON)
    add_subdirectory(example)
endif ()

include(${PROJECT_SOURCE_DIR}/cmake/package.cmake)