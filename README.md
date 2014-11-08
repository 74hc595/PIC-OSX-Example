# PIC Example Project for Mac OS X

This is an example demonstrating how to develop software for 8-bit [PIC
microcontrollers](http://microchip.com/pic/) in C using the open-source [Small
Device C Compiler (SDCC)](http://sdcc.sourceforge.net) and transfer it to a
device using the [PICkit 3](http://www.microchip.com/PICkit418446).

## Requirements

1. [Homebrew](http://brew.sh)
2. SDCC: install using Homebrew with the command `brew install sdcc`
3. [MPLAB X](http://www.microchip.com/mplabx/). Required to drive the PICkit 3.
   This project uses a makefile and does not require the use of the MPLAB GUI
   applications. The non-free XC8 compiler is not required either.

## Contents

This is a simple project that blinks an LED connected to an I/O pin on a
[PIC16F1454](http://www.microchip.com/PIC16F1454). It demonstrates compilation
of multiple files into a single executable, configuration of the device, and a
makefile target for programming the device using the `mdb.sh` command-line tool
buried in the MPLAB executable.

## Instructions for use

1. Edit the `Makefile` to suit your device. Set the `CC_FAMILY`, `CC_DEVICE`,
   and `MDB_DEVICE` variables appropriately.
2. Edit the device configuration words in `config.h`. SDCC does not support the
   `#pragma config` syntax for PICs with 14-bit instruction words (mid-range and
   enhanced mid-range devices), but the same effect can be achieved by ANDing
   together the feature flags defined in `pic14regs.h`.
3. Run `make`. The output is am `.hex` file.
4. To program the device with the new firmware, run `make flash`. This uses the
   `mdb.sh` utility that's bundled with MPLAB X to drive the PICkit 3.

One pitfall I ran into is that my PICkit 3 shipped with outdated firmware that
was not compatible with MPLAB X. Attempting to connect to the device gave the
error `"Your PICkit 3 firmware version 01.22.08 is too old. You must have
firmware version 01.26.10 or higher to use MPLAB X."` Attempts to update the
firmware through MPLAB X on a Mac also failed. Sadly, the only way I was able
to fix this was with a Windows computer. Download the [PICkit 3 Standalone Programmer](http://ww1.microchip.com/downloads/en/DeviceDoc/PICkit_3_Programmer_1_0_Setup_A.zip)
executable for Windows. After setup, the directory `C:\Program Files\Microchip\PICkit 3\` contains a firmware file named `PK3FW_xxxxxx.jam`. After using `PICkit 3.exe` to upgrade the firmware, it should be usable from Mac OS X. Note: the application will not work when run from Wine, as Wine does not support custom USB devices.
