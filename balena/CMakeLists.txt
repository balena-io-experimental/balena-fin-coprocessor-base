# EFM32 Emlib CMake file
project(balena)

# find . -name '*.c' | sort -u
add_library(${PROJECT_NAME}
       src/balena.cpp)

target_include_directories(${PROJECT_NAME} PUBLIC 
        inc
        config)

if(${HAS_HARDWARE})
        target_link_libraries(${PROJECT_NAME} emlib emdrv hardware)
else()
        target_link_libraries(${PROJECT_NAME} emlib emdrv)
endif()