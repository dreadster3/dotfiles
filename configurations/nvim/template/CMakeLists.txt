cmake_minimum_required(VERSION 3.23)

project({{_lua:vim.fn.expand("%:h:t")_}})
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
if(CMAKE_EXPORT_COMPILE_COMMANDS)
  set(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES
      ${CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES})
endif()

file(GLOB_RECURSE sources
    "${CMAKE_SOURCE_DIR}/src/*.c"
    "${CMAKE_SOURCE_DIR}/src/*.cpp"
)

add_definitions(-DSOME_DEFINITION)

add_executable({{_lua:vim.fn.expand("%:h:t")_}} ${sources})

# Add more include directories if needed
target_include_directories({{_lua:vim.fn.expand("%:h:t")_}} PUBLIC "${CMAKE_SOURCE_DIR}/include")

# If you have precompiled headers you can add them like this
target_precompiled_headers({{_lua:vim.fn.expand("%:h:t")_}} PRIVATE "${CMAKE_SOURCE_DIR}/src/pch.h")
