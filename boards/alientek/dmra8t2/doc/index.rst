.. zephyr:board:: dmra8t2

Overview
********

The ATK-DMRA8T2 (also branded ATK-DN8T2) is a motor control development board from
Alientek built around the Renesas RA8T2 MCU group. The board is made of a carrier
board and the ATK-CNRA8T2 core module, which carries the MCU, a 24 MHz main crystal,
a 32.768 kHz sub-clock crystal, 32 MB of SDRAM and an Octal-SPI NOR flash.

The RA8T2 incorporates a high-performance Arm |reg| Cortex |reg|-M85 core running up
to 1 GHz and an Arm |reg| Cortex |reg|-M33 core running up to 250 MHz, with:

- 1 MB MRAM
- 2 MB SRAM (256 KB CM85 TCM, 128 KB CM33 TCM, 1664 KB user SRAM)
- Octal Serial Peripheral Interface (OSPI) and SDRAM bus
- Layer 3 Ethernet Switch Module (ESWM) with EtherCAT support, USBFS, SD/MMC host
- Motor control timers (GPT with three-phase output), analog peripherals
- Security and safety features

**Motor control interfaces**

- Two DC brushed / BLDC / PMSM driver interfaces (CN4, CN6), each providing
  three-phase complementary PWM, Hall sensor inputs, incremental encoder inputs,
  phase current / back-EMF / bus voltage / temperature analog inputs and a shutdown
  control signal
- Two opto-isolated stepper motor driver interfaces (CN5, CN7) with pulse, direction
  and enable signals
- Two servo (RC PWM) outputs (SRV1, SRV2)
- Two incremental encoder headers (CN11) and an analog input header (CN13)
- Brake signal inputs (BRK1, BRK2)

**System control and ecosystem access**

- Two USB-C connectors

  - J3: CH343P USB to serial converter, wired to SCI0 (this is the Zephyr console)
  - J4: USB full speed device, wired to USBFS

- Two 10/100 Ethernet ports (J5, J6) with Motorcomm YT8512C PHYs on MII, driven by
  the Ethernet switch module; EtherCAT status LEDs are fitted
- CAN-FD (TJA1050), RS485 (TP8485E) and RS232 (TPT3232E) transceivers on CN2/CN3
- micro SD card socket on SDHI channel 0
- SPI header shared by a 1.3" SPI LCD module and an NRF24L01 style wireless module
- ATK-MODULE serial header
- Two user LEDs (LED0 red, LED1 green), a power LED, an active buzzer
- Three user buttons (KEY0, KEY1, BOOT) and one reset button
- 5-pin SWD debug header (CN1)
- 6-24 V DC barrel jack input with a 5 V buck regulator and 3.3 V LDOs

Hardware
********

Detailed hardware features are documented in the ATK-DMRA8T2 hardware reference
manual and schematic supplied by Alientek.

Supported Features
==================

.. zephyr:board-supported-hw::

Both cores are supported as separate board targets:

.. list-table::
   :header-rows: 1

   * - Board target
     - Core
     - Code flash
     - RAM
   * - ``dmra8t2/r7ka8t2lflcac/cm85``
     - Cortex-M85
     - ``code_mram_cm85`` (768 KB)
     - ``sram0`` (1 MB)
   * - ``dmra8t2/r7ka8t2lflcac/cm33``
     - Cortex-M33
     - ``code_mram_cm33`` (256 KB)
     - ``sram1`` (640 KB)

Pin assignment
==============

The signals below are the ones described by the devicetree. Everything else on the
board is a plain GPIO and can be used from an application overlay.

.. list-table:: On-board devices
   :header-rows: 1

   * - Function
     - Node
     - MCU pins
   * - Console (CH343P USB serial, J3)
     - ``uart0`` (SCI0)
     - P603 (TXD0_B), P602 (RXD0_B)
   * - HMI screen (CN3) / RS232, jumper P1
     - ``uart7`` (SCI7)
     - PC03 (TXD7_C), PC04 (RXD7_C)
   * - RS485 (CN2)
     - ``uart9`` (SCI9)
     - P209 (TXD9_B), P208 (RXD9_B)
   * - ATK-MODULE header
     - ``uart4`` (SCI4)
     - P714 (TXD4_C), P715 (RXD4_C)
   * - SPI LCD / 2.4G wireless header
     - ``spi0`` (SPI channel A)
     - P203 (RSPCKA_A), P202 (MOSIA_A), P313 (MISOA_A), P204 (SSLA0_A)
   * - I2C on the encoder header CN11
     - ``iic2``
     - P515 (SCL2_B, ENC3), P514 (SDA2_B, ENC4)
   * - CAN-FD (CN2)
     - ``canfd1``
     - P415 (CTX1), PC15 (CRX1)
   * - USB device (J4)
     - ``usbfs``
     - P814 (D+), P815 (D-), P407 (VBUS)
   * - micro SD card
     - ``sdhc0`` (SDHI channel 0)
     - PD05 (CLK), PD04 (CMD), PD03/PD02/PD01/P111 (DAT0-3), PD07 (CD)
   * - Ethernet port 0 (J5)
     - ``eth0`` + ``phy1`` (address 1)
     - MII on P405, P406, P700-P705, P710, PB00-PB04
   * - Ethernet port 1 (J6)
     - ``eth1`` + ``phy2`` (address 2)
     - MII on P106, P206, P304-P307, P310-P312, P905-P909
   * - Ethernet MDIO (shared by both PHYs)
     - ``mdio0``
     - P708 (MDC), P709 (MDIO)
   * - Ethernet PHY reset (shared)
     - ``board.c``
     - P711, active low
   * - Servo 1 pulse (SRV1)
     - ``pwm5`` channel A
     - P915 (GTIOC5A)
   * - Servo 2 pulse (SRV2)
     - ``pwm7`` channel B
     - P303 (GTIOC7B)
   * - Stepper 1/2 pulse (CN5/CN7)
     - ``pwm11`` channels A/B
     - P800 (GTIOC11A), P801 (GTIOC11B)
   * - SDRAM (W9825G6KB, 32 MB)
     - ``sdram`` / ``sdram1`` at 0x68000000
     - 16-bit bus on port 1, 3, 5, 6, 8, A and D

.. list-table:: LEDs and buttons
   :header-rows: 1

   * - Silkscreen
     - Devicetree
     - MCU pin
   * - LED0 (red)
     - ``led0``, alias ``led0`` on CM85
     - P207, active low
   * - LED1 (green)
     - ``led1``, alias ``led0`` on CM33
     - PB05, active low
   * - KEY0
     - ``key0``, alias ``sw0`` on CM85
     - P707 (IRQ8), active low
   * - KEY1
     - ``key1``, alias ``sw1`` on CM85
     - PD06 (IRQ18), active low
   * - BOOT
     - ``boot_key``, alias ``sw2`` on CM85
     - P201 (MD / IRQ4), active low

Signals that are brought out to the motor connectors but are not modelled in the
devicetree, because Zephyr has no driver API for them, are listed below so that they
can be driven from an application:

.. list-table:: Motor interface signals
   :header-rows: 1

   * - Signal group
     - Driver 1 (CN4)
     - Driver 2 (CN6)
   * - Three-phase PWM, high side (U/V/W)
     - P413, P411, P409
     - P807, P712, P501
   * - Three-phase PWM, low side (U/V/W)
     - P412, P410, P408
     - P105, P601, P600
   * - Hall sensors (U/V/W)
     - P308, P205, P802
     - P108, P109, PA07
   * - Encoder A/B/Z
     - P511, P512, P713
     - P914, P604, P605
   * - Shutdown control
     - P402
     - P606
   * - Current sense U/V/W
     - P002, P806, P805
     - P812, P012, P013
   * - Back-EMF U/V/W
     - P001, P000, P007
     - P500, P010, P011
   * - Bus voltage / temperature
     - P003 / P513
     - P005 / P009

Other unmodelled signals: buzzer P400, SPI LCD backlight P314 and reset PC10,
brake inputs BRK1 P401 and BRK2 P615, stepper enable/direction ST1 P102/P810 and
ST2 P809/P811, general purpose inputs INPUT1-4 P911, P910, P903, P904, general
purpose outputs OUTPUT1-4 P110, PC11, P913, P912 and analog inputs ADC_PORT0-5
P006, P004, P008, P014, P015, P502.

Programming and Debugging
*************************

.. zephyr:board-supported-runners::

Debug and flash with a SWD probe connected to the 5-pin header CN1 (3V3, DIO, CLK,
GND, RST). Both J-Link and pyOCD runners are configured.

Building and flashing the Cortex-M85 image:

.. zephyr-app-commands::
   :zephyr-app: samples/basic/blinky
   :board: dmra8t2/r7ka8t2lflcac/cm85
   :goals: build flash

Building and flashing the Cortex-M33 image:

.. zephyr-app-commands::
   :zephyr-app: samples/basic/blinky
   :board: dmra8t2/r7ka8t2lflcac/cm33
   :goals: build flash

Console output
==============

The console is on ``uart0`` (SCI0), which is wired to the on-board CH343P USB to
serial converter. Connect a USB-C cable to J3 and open the resulting serial port at
115200 8N1.

Using the SDRAM
===============

The SDRAM controller driver is behind the experimental ``CONFIG_MEMC`` option and is
therefore not enabled by default. Add the following to your application to have the
32 MB SDRAM initialised and available as the ``SDRAM`` memory region at
``0x68000000``:

.. code-block:: cfg

   CONFIG_MEMC=y

Using the SD card
=================

The micro SD card socket is exposed as ``sdhc0`` with a ``zephyr,sdmmc-disk`` child.
Enable ``CONFIG_DISK_DRIVER_SDMMC`` (and a file system, for example
``CONFIG_FAT_FILESYSTEM_ELM``) to use it; the disk is named ``SD``.

References
**********

.. target-notes::

- `Renesas RA8T2 MCU group <https://www.renesas.com/en/products/ra8t2>`_
- `Alientek ATK-DMRA8T2 product page <http://www.alientek.com/>`_
