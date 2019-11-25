project(hardware)

string(TOLOWER ${DEVICE} DEVICE_L)

if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/module/config/sl_module_${DEVICE_L}.h")
    message("${DEVICE_U} is a module, adding headers")
    set(MODULE 1)
else()
    message("${CMAKE_CURRENT_SOURCE_DIR}/module/config/sl_module_${DEVICE_L}.h")
endif()

if (${MODULE})
    set(HAS_HARDWARE TRUE PARENT_SCOPE)

    message("Board defined, adding hardware library for: ${CPU_FAMILY_U}_${BOARD}")

    add_library(${PROJECT_NAME} INTERFACE)

    if(DEFINED BOARD)
        message("HAS BOARD")
        target_include_directories(${PROJECT_NAME} INTERFACE
                halconfig/inc/hal-config
                # kit/${TEMP_BOARD}_${BOARD}/config
                kit/common/bsp
                kit/common/drivers
                kit/common/halconfig
                module/config)
    else()
        message("HAS MODULE")
        target_include_directories(${PROJECT_NAME} INTERFACE
                module/config)
    endif()
      
    return()
endif ()

message("No board defined, skipping hardware")
set(HAS_HARDWARE FALSE PARENT_SCOPE)
return()



