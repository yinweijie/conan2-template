cmake_minimum_required(VERSION 3.15)
project(compressor)

find_package(ZLIB REQUIRED)
find_package(nlohmann_json REQUIRED)
find_package(fmt REQUIRED)
find_package(Eigen3 REQUIRED)
find_package(Boost REQUIRED)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_executable(${PROJECT_NAME} src/main.cpp)
target_link_libraries(${PROJECT_NAME} 
    ZLIB::ZLIB
    nlohmann_json::nlohmann_json
    fmt::fmt
    Eigen3::Eigen
    boost::boost)