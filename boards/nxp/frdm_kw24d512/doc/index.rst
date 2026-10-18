.. zephyr:board:: frdm_kw24d512

Overview
********

The FRDM-KW24D512 is a Freedom development platform for the NXP MKW24D512 wireless MCU of the
KW2xD series. The MKW24D512 combines a low-power IEEE 802.15.4 2.4 GHz radio transceiver and a
Kinetis Arm Cortex-M4 MCU in a single package.

The board carries the MKW24D512 with a 32 MHz reference oscillator crystal, RF circuitry with a
printed antenna, a 16 Mbit SPI serial flash, a 6-axis combo sensor and an OpenSDA serial and
debug adapter in the Freedom form factor.

Hardware
********

- MKW24D512 wireless MCU: Arm Cortex-M4 core, 512 KB flash, 64 KB SRAM, IEEE 802.15.4 2.4 GHz
  radio and full-speed USB 2.0
- Printed F-antenna and footprint for an SMA RF connector
- 32 MHz reference oscillator crystal and 32.768 kHz crystal
- AT45DB161E 16 Mbit SPI serial flash
- FXOS8700CQ 6-axis accelerometer and magnetometer on I2C
- One RGB LED and one blue LED
- Four user push buttons and one reset button
- USB Mini-B connector for the MKW24D512 USB port
- OpenSDA v2.1 serial and debug adapter with its own USB Mini-B connector
- 10-pin SWD connector for the MKW24D512
- Freedom form factor I/O headers

For more information about the KW2xD SoC and the FRDM-KW24D512 board:

- `KW2xD Website`_
- `KW2xD Datasheet`_
- `KW2xD Reference Manual`_
- `FRDM-KW24D512 Website`_
- `FRDM-KW24D512 User Guide`_
- `FRDM-KW24D512 Design Files`_
- `FRDM-KW24D512 Getting Started`_

Supported Features
==================

.. zephyr:board-supported-hw::

Connections and IOs
===================

The KW2xD SoC has five pairs of pinmux/GPIO controllers, all of which are enabled for the
FRDM-KW24D512 board.

+-------+-----------+---------------------------------------------------+
| Name  | Function  | Usage                                             |
+=======+===========+===================================================+
| PTA19 | GPIO      | SW4                                               |
+-------+-----------+---------------------------------------------------+
| PTD1  | GPIO      | SW3                                               |
+-------+-----------+---------------------------------------------------+
| PTE3  | GPIO      | SW2                                               |
+-------+-----------+---------------------------------------------------+
| PTE4  | GPIO      | SW1                                               |
+-------+-----------+---------------------------------------------------+
| PTD4  | GPIO      | RGB LED (D17), red                                |
+-------+-----------+---------------------------------------------------+
| PTD5  | GPIO      | RGB LED (D17), green                              |
+-------+-----------+---------------------------------------------------+
| PTD6  | GPIO      | RGB LED (D17), blue, through jumper J41           |
+-------+-----------+---------------------------------------------------+
| PTD7  | GPIO      | Blue LED (D8), through jumper J42                 |
+-------+-----------+---------------------------------------------------+
| PTE0  | UART1_TX  | UART console (OpenSDA), through jumper J36        |
+-------+-----------+---------------------------------------------------+
| PTE1  | UART1_RX  | UART console (OpenSDA), through jumper J37        |
+-------+-----------+---------------------------------------------------+
| PTB10 | SPI1_PCS0 | Internally connected to the transceiver           |
+-------+-----------+---------------------------------------------------+
| PTB11 | SPI1_SCK  | Internally connected to the transceiver           |
+-------+-----------+---------------------------------------------------+
| PTB16 | SPI1_SOUT | Internally connected to the transceiver           |
+-------+-----------+---------------------------------------------------+
| PTB17 | SPI1_SIN  | Internally connected to the transceiver           |
+-------+-----------+---------------------------------------------------+
| PTB3  | GPIO      | Internally connected to the transceiver (IRQ_B)   |
+-------+-----------+---------------------------------------------------+
| PTB19 | GPIO      | Internally connected to the transceiver (RST_B)   |
+-------+-----------+---------------------------------------------------+
| PTC0  | GPIO      | Internally connected to the transceiver (GPIO5)   |
+-------+-----------+---------------------------------------------------+

The LEDs are active low. The push buttons connect their GPIO to ground; their external pull-up
resistors are not populated, so the internal pull-ups are enabled.

System Clock
============

The 32 MHz reference oscillator crystal is connected to the transceiver. The MCU is configured
to use the 4 MHz clock output of the transceiver, which is internally connected to the EXTAL0
input of the MCU, with the on-chip PLL to generate a 48 MHz system clock.

Serial Port
===========

The KW2xD SoC has three UARTs. UART1 is used for the console and is connected to the OpenSDA
serial adapter.

USB
===

The KW2xD SoC has a USB OTG controller that supports both device and host functions. Only the
USB device function is supported in Zephyr. The MKW24D512 USB port is available on the USB
Mini-B connector J16, labeled ``KW24`` on the board.

Programming and Debugging
*************************

.. zephyr:board-supported-runners::

Build and flash applications as usual (see :ref:`build_an_application` and
:ref:`application_run` for more details).

Configuring a Debug Probe
=========================

A debug probe is used for both flashing and debugging the board. The board has an OpenSDA v2.1
serial and debug adapter, built around a Kinetis K20 MCU, which is connected to the PC through
the USB Mini-B connector J15, labeled ``DEBUG`` on the board. The OpenSDA adapter ships with
CMSIS-DAP firmware, and the board is configured by default to use pyOCD with it.

Option 1: CMSIS-DAP Onboard Debug Probe (Recommended)
-----------------------------------------------------

Install the :ref:`pyocd-debug-host-tools` and make sure they are in your search path.

Option 2: :ref:`opensda-jlink-onboard-debug-probe`
--------------------------------------------------

Install the :ref:`jlink-debug-host-tools` and make sure they are in your search path.

Follow the instructions in :ref:`opensda-jlink-onboard-debug-probe` to program the
`OpenSDA J-Link FRDM-KW24D512 Firmware`_.

Add the arguments ``-DBOARD_FLASH_RUNNER=jlink`` and ``-DBOARD_DEBUG_RUNNER=jlink`` when you
invoke ``west build`` to override the default runner from pyOCD to J-Link:

.. zephyr-app-commands::
   :zephyr-app: samples/hello_world
   :board: frdm_kw24d512
   :gen-args: -DBOARD_FLASH_RUNNER=jlink -DBOARD_DEBUG_RUNNER=jlink
   :goals: build

Configuring a Console
=====================

Regardless of your choice in debug probe, we will use the OpenSDA microcontroller as a
usb-to-serial adapter for the serial console.

Connect a USB cable from your PC to J15.

Use the following settings with your serial terminal of choice (minicom, putty, etc.):

- Speed: 115200
- Data: 8 bits
- Parity: None
- Stop bits: 1

Flashing
========

Here is an example for the :zephyr:code-sample:`hello_world` application.

.. zephyr-app-commands::
   :zephyr-app: samples/hello_world
   :board: frdm_kw24d512
   :goals: flash

Open a serial terminal, reset the board (press the reset button), and you should see the
following message in the terminal:

.. code-block:: console

   *** Booting Zephyr OS build v4.5.0-xxx-gxxxxxxxxxxxx ***
   Hello World! frdm_kw24d512/mkw24d5

Debugging
=========

Here is an example for the :zephyr:code-sample:`hello_world` application.

.. zephyr-app-commands::
   :zephyr-app: samples/hello_world
   :board: frdm_kw24d512
   :goals: debug

Open a serial terminal, step through the application in your debugger, and you should see the
following message in the terminal:

.. code-block:: console

   *** Booting Zephyr OS build v4.5.0-xxx-gxxxxxxxxxxxx ***
   Hello World! frdm_kw24d512/mkw24d5

.. include:: ../../common/board-footer.rst.inc

References
**********

.. target-notes::

.. _FRDM-KW24D512 Website:
   https://www.nxp.com/design/design-center/development-boards-and-designs/FRDM-KW24D512

.. _FRDM-KW24D512 User Guide:
   https://www.nxp.com/webapp/Download?colCode=FRDMKW24DUG

.. _FRDM-KW24D512 Design Files:
   https://www.nxp.com/webapp/Download?colCode=FRDM-KW24D512-DESIGN-FILES

.. _FRDM-KW24D512 Getting Started:
   https://www.nxp.com/document/guide/get-started-with-the-frdm-kw24d512:GS-FRDM-KW24D512

.. _KW2xD Website:
   https://www.nxp.com/products/wireless/thread/kinetis-kw2xd-2.4-ghz-802.15.4-wireless-radio-microcontroller-mcu-based-on-arm-cortex-m4-core:KW2xD

.. _KW2xD Datasheet:
   https://www.nxp.com/docs/en/data-sheet/MKW2xDxxx.pdf

.. _KW2xD Reference Manual:
   https://www.nxp.com/webapp/Download?colCode=MKW2XDXXXRM

.. _OpenSDA J-Link FRDM-KW24D512 Firmware:
   https://www.segger.com/downloads/jlink/OpenSDA_FRDM-KW24D512
