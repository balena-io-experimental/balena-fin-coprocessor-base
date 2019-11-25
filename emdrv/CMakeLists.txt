# EFM32 Emlib CMake file
project(emdrv)

# find . -name '*.c' | sort -u
add_library(${PROJECT_NAME}
        config/nvm_config.c
        dmadrv/src/dmadrv.c
        gpiointerrupt/src/gpiointerrupt.c
        nvm/config/nvm_config.c
        nvm/src/nvm.c
        nvm/src/nvm_hal.c
        rtcdrv/src/rtcdriver.c
        sleep/src/sleep.c
        spidrv/src/spidrv.c
        tempdrv/src/tempdrv.c
        uartdrv/src/uartdrv.c
        ustimer/src/ustimer.c
      )

target_include_directories(
        ${PROJECT_NAME} PUBLIC 
        common/inc
        dmadrv/inc
        dmadrv/config
        gpiointerrupt/inc
        nvm/inc
        nvm/config
        rtcdrv/inc
        rtcdrv/config
        sleep/inc
        spidrv/inc
        spidrv/config
        tempdrv/inc
        tempdrv/config
        uartdrv/inc
        uartdrv/config
        ustimer/inc
        ustimer/config
        )

target_link_libraries(${PROJECT_NAME} emlib)