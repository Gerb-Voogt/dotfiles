# Template for basic cmake project
# Run with:
#     $cmake -S . -G "Unix Makefiles" -B cmake
#     or 
#     $cmake -S . -B cmake
# --------------------------------
cmake_minimum_required(VERSION 3.8)
project(project_name)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Change path from /src if needed, or add more directories
file(GLOB_RECURSE sources
        "${CMAKE_SOURCE_DIR}/src/*.c"
        "${CMAKE_SOURCE_DIR}/src/*.cpp"
        )
# Add precompiler definitions like that:
add_definitions(-DSOME_DEFINITION)

add_executable(my_project ${sources})

# Add more include directories if needed
target_include_directories(my_project PUBLIC "{CMAKE_SOURCE_DIR}/include")
