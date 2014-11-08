# Mac OS X Makefile for PIC programming using SDCC
# Matt Sarnoff (msarnoff.org)
# November 7, 2014
#
# Run `make` to build the project as a .hex file.
# Run `make flash` to program the device.
#
# MPLAB X is required if using a PICkit 3 to program the device.
# This Makefile assumes it's installed in /Applications/microchip.

########## Project-specific definitions ##########

# Project name
OUT = blink

# Source files to compile
SRC = delay.c blink.c

# Either `pic14` for 14-bit devices or `pic16` for 16-bit devices
CC_FAMILY = pic14

# The SDCC-specific (case sensitive) part number of the chip
# (use `make list-devices` if not known)
CC_DEVICE = 16f1454

# The MDB-specific part number of the chip, used for programming with MDB
# (should be the actual PIC part number, e.g. PIC16LF1454)
MDB_DEVICE = PIC16LF1454



########## Build settings ##########

CFLAGS = --use-non-free --opt-code-speed -DNO_BIT_DEFINES
CC = sdcc
SDCC_DIR = /usr/local/share/sdcc
MPLABX_DIR = /Applications/microchip/mplabx
MDB = $(MPLABX_DIR)/mplab_ide.app/Contents/Resources/mplab_ide/bin/mdb.sh



########## Make rules ##########

OBJ = $(SRC:.c=.o)
HEX = $(OUT).hex

# Compile C file
.c.o:
	$(CC) $(CFLAGS) -m$(CC_FAMILY) -p$(CC_DEVICE) -c $<

# Link
$(HEX): $(OBJ)
	$(CC) -o $(HEX) $(CFLAGS) -m$(CC_FAMILY) -p$(CC_DEVICE) $(OBJ)

# Flash
flash: $(HEX)
	@echo "Device $(MDB_DEVICE)" \
		"\nSet system.disableerrormsg true" \
		"\nHwtool PICkit3 -p" \
		"\nSet programoptions.eraseb4program true" \
		"\nProgram \"$(HEX)\"" \
		"\nQuit\n" > __prog.cmd
	@$(MDB) __prog.cmd; status=$$?; rm -f __prog.cmd MPLABXLog.*; exit $$status

# List supported device types
list-devices:
	@touch ___.c
	@-$(CC) -m$(CC_FAMILY) -phelp ___.c
	@rm ___.c

# Clean
clean:
	rm -f $(SRC:.c=.asm) $(SRC:.c=.lst) $(SRC:.c=.o) $(HEX) $(OUT).cod $(OUT).lst

.PHONY: all flash clean list-devices

