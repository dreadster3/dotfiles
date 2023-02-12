cmake_minimum_required(VERSION 3.12)  
project({{_lua:vim.fn.expand("%:h:t")_}})               
set(CMAKE_CXX_STANDARD 20)     
set(CMAKE_compileco)

set(SOURCE_FILES main.cpp)

add_executable({{_lua:vim.fn.expand("%:h:t")_}} ${SOURCE_FILES})
