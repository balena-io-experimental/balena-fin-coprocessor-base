# BalenaFin Co-Processor Base

### Build & Manually Flash

It is also possible to build the source and manually flash the Coprocessor however, in order to flash the Coprocessor you will need to either load the compiled firmware onto the Compute Module and flash it using OpenOCD or program the Coprocessor using an external programmer such as a [Segger JLink ](https://www.segger.com/products/debug-probes/j-link/).

#### Dependencies

 - cmake
 - make
 - arm-none-eabi-gcc*

If using a JLink programmer to externally flash:

 - [JLink tools](https://www.segger.com/jlink-software.html)

*Make sure this is in your `$PATH`

#### Building/Flashing

With the dependencies installed, run:

1. `make setup` to generate the build directory
2. `make balena` to execute the build

If using a JLink programmer to externally flash:

3. `make flash` to flash to a device

