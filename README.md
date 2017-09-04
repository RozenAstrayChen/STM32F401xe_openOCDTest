# STM32F401xe_openOCDTest
This is test openOCD and Jlink that work on my OSX

### build

```
Rozen $ make
```
### remove 

```
Rozen $ make clean
```

### write image to flash

```
Rozen$ openocd -f board/st_nucleo_f401re.cfg
GNU ARM Eclipse 64-bits Open On-Chip Debugger 0.10.0-dev-00498-gbbfb673 (2016-10-28-19:13)
Licensed under GNU GPL v2
For bug reports, read
	http://openocd.org/doc/doxygen/bugs.html
Info : The selected transport took over low-level target control. The results might differ compared to plain JTAG/SWD
adapter speed: 2000 kHz
```
create other bash

```
Rozen$ telnet localhost 4444

Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
Open On-Chip Debugger
> poll
background polling: on
TAP: stm32f4x.cpu (enabled)
stm32f4x.cpu: target state: running
> reset halt
Unable to match requested speed 2000 kHz, using 1800 kHz
Unable to match requested speed 2000 kHz, using 1800 kHz
adapter speed: 1800 kHz
stm32f4x.cpu: target state: halted
target halted due to debug-request, current mode: Thread 
xPSR: 0x01000000 pc: 0x08000008 msp: 0x20001000
> flash probe 0
device id = 0x10016433
flash size = 512kbytes
flash 'stm32f2x' found at 0x08000000
> flash write_image erase /Users/Rozen_mac/code/embedded/OCD/test/main.bin 0x08000000
auto erase enabled
stm32f4x.cpu: target state: halted
target halted due to breakpoint, current mode: Thread 
xPSR: 0x61000000 pc: 0x20000046 msp: 0x20001000
wrote 16384 bytes from file /Users/Rozen_mac/code/embedded/OCD/test/main.bin in 0.616039s (25.972 KiB/s)
> reset
Unable to match requested speed 2000 kHz, using 1800 kHz
Unable to match requested speed 2000 kHz, using 1800 kHz
adapter speed: 1800 kHz
> exit

```


### use __arm-none-eabi-gdb__ Debugger:

```
Rozen$ arm-none-eabi-gdb main.elf 

GNU gdb (GNU Tools for ARM Embedded Processors) 7.10.1.20160923-cvs
Copyright (C) 2015 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "--host=x86_64-apple-darwin10 --target=arm-none-eabi".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
<http://www.gnu.org/software/gdb/documentation/>.
For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from main.elf...done.
(gdb) target remote :3333
Remote debugging using :3333
main () at main.c:21
21	{
(gdb) cont
Continuing.
WARNING! The target is already running. All changes GDB did to registers will be discarded! Waiting for target to halt.
^C             
Program received signal SIGINT, Interrupt.
main () at main.c:26
26	        i++;
(gdb) p i

$1 = 159549733

```
which is successful

```
$1 = 159549733
```