cmake_minimum_required(VERSION 3.23)

project({{_lua:vim.fn.expand("%:h:t")_}})
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

file(GLOB CPPFILES src/*.cpp)
file(GLOB HPPFILES src/*.hpp)

set(SOURCE_FILES ${CPPFILES} ${HPPFILES})

add_executable({{_lua:vim.fn.expand("%:h:t")_}} ${SOURCE_FILES})
