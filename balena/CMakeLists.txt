# EFM32 Emlib CMake file
project(balena)

# find . -name '*.c' | sort -u
add_library(${PROJECT_NAME}
       src/balena.cpp)

target_include_directories(${PROJECT_NAME} PUBLIC 
        inc
        config)

target_link_libraries(${PROJECT_NAME} emlib emdrv)