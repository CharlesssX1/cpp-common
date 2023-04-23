include_directories(
    ${PROJECT_SOURCE_DIR}/log
)

link_directories(${ABSEIL_LIB_DIR})

add_executable(common-log-example ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp)
target_link_libraries(common-log-example baselog)
