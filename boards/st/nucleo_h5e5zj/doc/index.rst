.. zephyr:board:: nucleo_h5e5zj

Overview
********

The Nucleo H5E5ZJ board is designed as an affordable development platform for
STMicroelectronics ARM® Cortex®-M33 core-based STM32H5E5ZJT6 microcontroller.
Here are some highlights of the Nucleo H5E5ZJ board:

- STM32H5E5ZJ microcontroller featuring 4 Mbytes of flash memory and 1.5 Mbytes
  of SRAM in LQFP144 package
- Board connectors:

  - USB Type-C® Sink device HS
  - Ethernet RJ45 connector compliant with IEEE-802.3-2002
  - ARDUINO® Uno V3 connectors (CN5, CN6, CN8, CN9)
  - ST morpho extension connectors (CN7, CN10)
  - M.2 Key A serial memory connector (CN19)

- Flexible board power supply:

  - 5V_STLK from the ST-LINK USB connector
  - VIN (7 - 12V) supplied via the ARDUINO® connector CN6 pin 8
  - 5V_EXT on the ST morpho connector CN7 pin 6
  - USB Type-C® user connector (CN13)
  - 3V3_EXT supplied via the ARDUINO® connector CN6 pin 4

- On-board STLINK-V3EC debugger/programmer

  - mass storage
  - Virtual COM port
  - debug port

- Three user LEDs
- Three push-buttons: USER, RESET and BOOT
- 32.768 kHz crystal oscillator
- 48 MHz crystal oscillator

More information about the board can be found at the `NUCLEO_H5E5ZJ website`_.

Hardware
********

The STM32H5E5xx devices are high-performance microcontrollers from the STM32H5
Series based on the high-performance Arm® Cortex®-M33 32-bit RISC core.
They operate at a frequency of up to 250 MHz.

- Core: ARM® 32-bit Cortex®-M33 CPU with TrustZone® and FPU
- Clock management:

  - 48 MHz crystal oscillator (HSE)
  - 32.768 kHz crystal oscillator for RTC (LSE)
  - Internal 64 MHz (HSI) trimmable by software
  - Internal low-power 32 kHz RC (LSI)
  - Internal 4 MHz oscillator (CSI), trimmable by software
  - Internal 48 MHz (HSI48) with recovery system
  - 3 PLLs for system clock, USB, audio, ADC

- Memories

  - 4 Mbytes of flash memory, 2 banks read-while-write
  - 1.5 Mbytes of SRAM
  - 4 Kbytes of backup SRAM available in the lowest power modes
  - 1x OCTOSPI memory interface
  - 2x SD/SDIO/MMC interfaces
  - Flexible external memory controller (FMC)

- Rich analog peripherals (independent supply)

  - 3x 12-bit ADC
  - 1x 12-bit DAC with 2 channels
  - 1x digital temperature sensor

- Communication interfaces

  - 1x USB Type-C® / USB power-delivery controller
  - 1x USB 2.0 high-speed device with embedded PHY
  - 4x I2C FM+ interfaces (SMBus/PMBus)
  - 2x I3C interfaces
  - 12x U(S)ARTs, 1x LPUART
  - 6x SPIs, 2x SAI
  - 3x FDCAN
  - 2x SDMMC interfaces
  - 2x 16 channel DMA controllers
  - 1x 8- to 14-bit camera interface
  - 1x Ethernet MAC interface with DMA controller
  - 1x LCD-TFT controller (LTDC) and 1x JPEG codec

- Development support: serial wire debug (SWD), JTAG, Embedded Trace Macrocell™

More information about STM32H5E5ZJ can be found here:

- `STM32H5E5ZJ on www.st.com`_

Supported Features
==================

.. zephyr:board-supported-hw::

Connections and IOs
===================

Nucleo H5E5ZJ Board has 8 GPIO controllers. These controllers are responsible
for pin muxing, input/output, pull-up, etc.

For more details please refer to `STM32H5 Nucleo-144 board User Manual`_.

Default Zephyr Peripheral Mapping:
----------------------------------

- ADC1 channel 3 input: PA6 (Arduino A0)
- ADC1 channel 7 input: PA7 (Arduino A1)
- ADC1 channel 18 input: PA4 (Arduino A2)
- ADC1 channel 9 input: PB0 (Arduino A3)
- ADC1 channel 6 input: PF12 (Arduino A4)
- ADC1 channel 2 input: PF11 (Arduino A5)
- Ethernet RMII: PA1 (REF_CLK), PA2 (MDIO), PC1 (MDC), PD1 (CRS_DV), PC4 (RXD0),
  PC5 (RXD1), PA5 (TX_EN), PB12 (TXD0), PG12 (TXD1)
- I2C4 SCL/SDA: PF5/PG6 (Arduino D15/D14)
- LD1 (green): PA3
- LD2 (red): PF0
- LD3 (blue): PE5
- SPI4 SCK/MISO/MOSI/CS: PE12/PE13/PE14/PE11 (Arduino D13/D12/D11/D10)
- UART7 TX/RX: PB4/PA8 (Arduino D1/D0)
- USART3 TX/RX: PD8/PD9 (VCP)
- USB Type-C® CC1/CC2: PB13/PB14
- USER_PB: PC13

System Clock
------------

Nucleo H5E5ZJ System Clock could be driven by internal or external oscillator,
as well as main PLL clock. By default System clock is driven by PLL clock at
250MHz, driven by the 48MHz external crystal oscillator (X3).

Serial Port
-----------

Nucleo H5E5ZJ board has up to 12 U(S)ARTs. The Zephyr console output is assigned
to USART3. Default settings are 115200 8N1.

Programming and Debugging
*************************

.. zephyr:board-supported-runners::

Nucleo H5E5ZJ board includes an STLINK-V3EC embedded debug tool interface.
This probe allows to flash the board using various tools.

Applications for the ``nucleo_h5e5zj`` board can be built and
flashed in the usual way (see :ref:`build_an_application` and
:ref:`application_run` for more details).

Flashing
========

The board is configured to be flashed using west `STM32CubeProgrammer`_ runner,
so its :ref:`installation <stm32cubeprog-flash-host-tools>` is required.

Alternatively, JLink can also be used to flash the board using the ``--runner``
(or ``-r``) option:

.. code-block:: console

   $ west flash --runner jlink

Flashing an application to Nucleo H5E5ZJ
----------------------------------------

Connect the Nucleo H5E5ZJ to your host computer using the ST-LINK USB port.
Then build and flash an application. Here is an example for the
:zephyr:code-sample:`hello_world` application.

Run a serial host program to connect with your Nucleo board:

.. code-block:: console

   $ minicom -D /dev/ttyACM0

Then build and flash the application.

.. zephyr-app-commands::
   :zephyr-app: samples/hello_world
   :board: nucleo_h5e5zj
   :goals: build flash

You should see the following message on the console:

.. code-block:: console

   Hello World! nucleo_h5e5zj

Debugging
=========

You can debug an application in the usual way.  Here is an example for the
:zephyr:code-sample:`blinky` application.

.. zephyr-app-commands::
   :zephyr-app: samples/basic/blinky
   :board: nucleo_h5e5zj
   :goals: debug

.. _NUCLEO_H5E5ZJ website:
   https://www.st.com/en/evaluation-tools/nucleo-h5e5zj.html

.. _STM32H5 Nucleo-144 board User Manual:
   https://www.st.com/resource/en/user_manual/um3601-stm32h5-nucleo144-board-mb2129-stmicroelectronics.pdf

.. _STM32H5E5ZJ on www.st.com:
   https://www.st.com/en/microcontrollers-microprocessors/stm32h5e5zj.html

.. _STM32CubeProgrammer:
   https://www.st.com/en/development-tools/stm32cubeprog.html
