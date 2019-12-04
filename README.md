# BalenaFin Co-Processor Base [![build](https://img.shields.io/badge/release-beta-brightgreen.svg)]()

This base project is designed to provide a quick and platform independent method of building projects for the balenaFin coprocessor.

## Dependencies

 - cmake
 - make
 - [arm-none-eabi-gcc](https://launchpad.net/gcc-arm-embedded/+download)
 - [JLink](https://www.segger.com/jlink-software.html)

## Usage

This project can either be used standalone or as a submodule, for example see [balena-fin-coprocessor-firmata](https://github.com/balena-io/balena-fin-coprocessor-firmata).

### Standalone

1. Download this repository
2. Change the project name and device in the CMakeLists.txt file
3. Move source  and include files into the src and inc directories
4. Add source files to the CMakeLists.txt file

### Submodule

1. Add the submodule to main project using:  
   `git submodule add https://github.com/balena-io-playground/balena-fin-coprocessor-base.git`  
   `git submodule update`  
2. Copy the CMakeLists.txt file from this project (balena-sdk) to the top level of the main project
3. Update the project name and BASE_LOCATION variables in the new CMakeLists.txt
4. Add source files (and cmake libraries) to the CMakeLists.txt file

## Building

To build the project, the following flow can be used:

```bash
make setup
make bgm1
```
This will create a `builds` folder, and create another folder named `bgm1` inside that which will have your `.bin`, `.hex`, and `.map` files.

## Debugging

Debugging using a Segger J-Link device (such as on Silabs Dev Kits) requires two processes, a GDB server that connects to the target and provides a local interface as well as a GDB instance that connects to this interface. Open two terminal sessions and run:

1. `make debug-server` or `make ds` from the first session to start the debug server and connect to the target
2. `make debug` or `make d` from the second session to launch GDB in Terminal User Interface (TUI) mode

This can then be used with the GDB interface to interact with the running application.

## Updating

### Add devices / Update the SDK:

1. Grab the Silabs Gecko SDK (likely will need to download Simplicity Studio and extract this).
2. Copy the `cmsis`, `device`, `drivers`, `emdrv` and `emlib` folders from the SDK into this repo.
3. Add provide entry point for building specified device, i.e. `make bgm111`
4. Add fixes to the `.cmake` files through the repo to correct any new naming inconsistencies (ie. `EFM32G210F128` vs. `EFR32FG13P231F512GM48`.
5. Open a PR against the `master`

## Licensing

TBD - pending Silabs license query. 

Based on [efm32-base](https://github.com/ryankurte/efm32-base) under MIT license.





