# BalenaFin Coprocessor Base

This repo is designed to provide a base library for developing applications for the balenaFin coprocessor. 
Please note that this repo is **not an example for the coprocessor** but rather a submodule for other projects.

## Dependencies

 - cmake
 - make
 - arm-none-eabi-gcc

If flashing a JLink development kit

 - JLink  

### Dockerfile

TBD

### Usage

1. Add the submodule to your project (using git) using:  
   `git submodule add https://github.com/balena-io-playground/balena-fin-coprocessor-base.git`  
   `git submodule update`  
2. Copy `CMakeLists.txt` from this project (balenafin) to the top level of your project
3. Update the `project name` and `BASE_LOCATION` variables in the new `CMakeLists.txt`
4. Add your source files (and any additional cmake libraries) to the `CMakeLists.txt` file

## Building

Once you have integrated this project with your project, you can build in the standard cmake manner.

1. `make setup` to setup the project
2. `make balena` to build and compile for the balenaFin

## Credit

This project is made possible by the work of Ryan Kurte from [EFM32 Base Project](https://github.com/ryankurte/efm32-base).

## Licensing

Due to the nature of this project pulling in a number of resources, the licenses vary depending on component.

### EFM32 Base Project

All reused components from [EFM32 Base Project](https://github.com/ryankurte/efm32-base) are available under the MIT license.

### CMSIS

The CMSIS Core falls under a fairly permissive ARM [license](cmsis/Include/arm_common_tables.h). 

### Silabs

The `device` and `emlib` components fall under the above ARM license (startup files) as well as a permissive Silicon Labs license, [for example](device/EFR32BG1B/Include/em_device.h).
Drivers are covered by the [Silabs License Agreement](drivers/Silabs_License_Agreement.txt). 



