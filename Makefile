TCPREFIX = /usr/local/bin/arm-none-eabi-
CC      = $(TCPREFIX)gcc
LD      = $(TCPREFIX)ld -v
CP      = $(TCPREFIX)objcopy
OD      = $(TCPREFIX)objdump
GDBTUI  = $(TCPREFIX)gdbtui

prog = main.
ld = stm32.ld

# -mfix-cortex-m4-ldrd should be enabled by default for Cortex M3.
CFLAGS  = -I. -c -fno-common -O0 -g -mcpu=cortex-m4 -mthumb
LFLAGS  = -T stm32.ld -nostartfiles
CPFLAGS = -Obinary
ODFLAGS = -S

.PHONY: all
all: $(prog)bin
$(prog)o: $(prog)c
	$(CC)  $(CFLAGS) $(prog)c
$(prog)elf: $(prog)o $(ld)
	$(LD) $(LFLAGS) -o $(prog)elf $(prog)o 
$(prog)bin: $(prog)elf
	$(CP) $(CPFLAGS) $(prog)elf $(prog)bin
	$(OD) $(ODFLAGS) $(prog)elf>$(prog)lst
clean:
	rm -f *.o *.out *.bin *.elf