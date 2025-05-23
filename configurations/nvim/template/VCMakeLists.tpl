;; cmake
cmake_minimum_required(VERSION 3.23)

set(VCPKG_ROOT "/opt/vcpkg" CACHE STRING "Vcpkg root directory")
set(CMAKE_TOOLCHAIN_FILE "${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake" CACHE STRING "Vcpkg toolchain file")

project({{_lua:vim.fn.expand("%:h:t")_}})
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# find_package()

file(GLOB CPPFILES src/*.cpp)
file(GLOB HPPFILES src/*.hpp)

set(SOURCE_FILES ${CPPFILES} ${HPPFILES})

add_executable({{_lua:vim.fn.expand("%:h:t")_}} ${SOURCE_FILES})
# target_link_libraries({{_lua:vim.fn.expand("%:h:t")_}})
