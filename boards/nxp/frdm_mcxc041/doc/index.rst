.. zephyr:board:: frdm_mcxc041

Overview
********

FRDM-MCXC041 is a compact and scalable development board for rapid prototyping of the MCX C041
MCU. It offers industry standard headers for easy access to the MCU's I/Os and an on-board
MCU-Link debugger. The MCX C04x is an Arm Cortex-M0+ based MCU family.

Hardware
********

- MCXC041VFK Arm Cortex-M0+ microcontroller running at 48 MHz
- 24-pin QFN package
- 32 KB flash
- 2 KB SRAM
- FXLS8974 accelerometer on I2C0
- RGB user LED
- Reset (SW1), wake-up (SW2) and ISP (SW3) buttons
- On-board MCU-Link debugger with CMSIS-DAP, USB Type-C connector (J8)
- 10-pin SWD connector (J9)
- Arduino UNO R3 compatible socket (J1 to J4), mikroBUS socket (J5, J6) and Pmod connector
  (J7, not populated)

For more information about the MCXC041 SoC and FRDM-MCXC041 board, see the `References`_.

Supported Features
==================

.. zephyr:board-supported-hw::

Connections and IOs
===================

The MCXC041 SoC has two pairs of pinmux/gpio controllers (PORTA/GPIOA and PORTB/GPIOB). Both
ports can generate pin interrupts.

+-------+-------------+---------------------------+
| Name  | Function    | Usage                     |
+=======+=============+===========================+
| PTA8  | ADC0_SE3    | ADC0 channel 3            |
+-------+-------------+---------------------------+
| PTA9  | ADC0_SE2    | ADC0 channel 2            |
+-------+-------------+---------------------------+
| PTA12 | CMP0_IN0    | Comparator input          |
+-------+-------------+---------------------------+
| PTB10 | GPIO        | Red LED (TPM0_CH1 PWM)    |
+-------+-------------+---------------------------+
| PTB11 | GPIO        | Green LED (TPM0_CH0 PWM)  |
+-------+-------------+---------------------------+
| PTB13 | GPIO        | Blue LED (TPM1_CH1 PWM)   |
+-------+-------------+---------------------------+
| PTB7  | TPM1_CH0    | PWM                       |
+-------+-------------+---------------------------+
| PTB2  | LPUART0_RX  | UART Console              |
+-------+-------------+---------------------------+
| PTB1  | LPUART0_TX  | UART Console              |
+-------+-------------+---------------------------+
| PTB0  | GPIO        | SW2 (wake-up) button      |
+-------+-------------+---------------------------+
| PTB5  | GPIO        | SW3 (ISP/NMI) button      |
+-------+-------------+---------------------------+
| PTB4  | I2C0_SDA    | I2C accelerometer         |
+-------+-------------+---------------------------+
| PTB3  | I2C0_SCL    | I2C accelerometer         |
+-------+-------------+---------------------------+

System Clock
============

The MCXC041 SoC is configured to use HIRC running at 48 MHz as a system clock source.

Serial Port
===========

The MCXC041 LPUART0 is used for the console.

Memory Constraints
==================

The MCXC041 has only 2 KB of SRAM. To fit in it, the board defconfig disables multithreading
(:kconfig:option:`CONFIG_MULTITHREADING`) and reduces the ISR, main and idle stack sizes.
Applications run in the main context only, so kernel services that need threads, such as work
queues, and the drivers and subsystems built on them are not available. An application that
re-enables multithreading must still fit in the 2 KB of SRAM.

Programming and Debugging
*************************

.. zephyr:board-supported-runners::

Build and flash applications as usual (see :ref:`build_an_application` and
:ref:`application_run` for more details).

Configuring a Debug Probe
=========================

A debug probe is used for both flashing and debugging the board. This board is
configured by default to use the MCU-Link CMSIS-DAP Onboard Debug Probe.

Using LinkServer
----------------

LinkServer is the default runner for this board, and supports the factory
default MCU-Link firmware. Follow the instructions in
:ref:`mcu-link-cmsis-onboard-debug-probe` to reprogram the default MCU-Link
firmware. This only needs to be done if the default onboard debug circuit
firmware was changed. To put MCU-Link in ``ISP mode`` to program the firmware,
short jumper JP2 before connecting the board.

Using J-Link
------------

There are two options. The onboard debug circuit can be updated with Segger
J-Link firmware by following the instructions in
:ref:`mcu-link-jlink-onboard-debug-probe`.
To be able to program the firmware, you need to put MCU-Link in ``ISP mode``
by shorting jumper JP2.
The second option is to attach a :ref:`jlink-external-debug-probe` to the
10-pin SWD connector (J9) of the board. Additionally, short jumper JP4 to
disable the MCU-Link SWD interface.
For both options use the ``-r jlink`` option with west to use the jlink runner.

.. code-block:: console

   west flash -r jlink

Configuring a Console
=====================

Connect a USB cable from your PC to J8, and use the serial terminal of your choice
(minicom, putty, etc.) on the MCU-Link VCOM port, which is enabled when jumper JP3 is open (the
default), with the following settings:

- Speed: 115200
- Data: 8 bits
- Parity: None
- Stop bits: 1

Flashing
========

Here is an example for the :zephyr:code-sample:`hello_world` application.

.. zephyr-app-commands::
   :zephyr-app: samples/hello_world
   :board: frdm_mcxc041
   :goals: flash

Open a serial terminal, reset the board (press the SW1 button), and you should
see the following message in the terminal:

.. code-block:: console

   *** Booting Zephyr OS build vX.Y.Z ***
   Hello World! frdm_mcxc041/mcxc041

Debugging
=========

Here is an example for the :zephyr:code-sample:`hello_world` application.

.. zephyr-app-commands::
   :zephyr-app: samples/hello_world
   :board: frdm_mcxc041
   :goals: debug

Open a serial terminal, step through the application in your debugger, and you
should see the following message in the terminal:

.. code-block:: console

   *** Booting Zephyr OS build vX.Y.Z ***
   Hello World! frdm_mcxc041/mcxc041

References
**********

- `MCX C04x Website`_
- `MCX C04x Datasheet`_
- `MCX C041 Reference Manual`_
- `FRDM-MCXC041 Website`_
- `FRDM-MCXC041 User Manual`_
- `FRDM-MCXC041 Quick Start Guide`_
- `FRDM-MCXC041 Design Files`_

.. include:: ../../common/board-footer.rst.inc

.. _MCX C04x Website:
   https://www.nxp.com/products/MCX-C04x

.. _MCX C04x Datasheet:
   https://www.nxp.com/docs/en/data-sheet/MCXC041P24M48SF0.pdf

.. _MCX C041 Reference Manual:
   https://www.nxp.com/webapp/Download?colCode=MCXC041P24M48RM

.. _FRDM-MCXC041 Website:
   https://www.nxp.com/design/design-center/development-boards-and-designs/FRDM-MCXC041

.. _FRDM-MCXC041 User Manual:
   https://www.nxp.com/webapp/Download?colCode=UM12116

.. _FRDM-MCXC041 Quick Start Guide:
   https://www.nxp.com/docs/en/quick-reference-guide/MCX-C041-QSG.pdf

.. _FRDM-MCXC041 Design Files:
   https://www.nxp.com/webapp/Download?colCode=FRDM-MCXC041-DESIGN-FILES
