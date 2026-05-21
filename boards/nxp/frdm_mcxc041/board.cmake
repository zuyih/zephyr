#
# Copyright 2024 NXP
#
# SPDX-License-Identifier: Apache-2.0
#

board_runner_args(jlink "--device=MCXC041")
board_runner_args(linkserver "--device=MCXC041:FRDM-MCXC041")
board_runner_args(pyocd "--target=mcxc041")

include(${ZEPHYR_BASE}/boards/common/linkserver.board.cmake)
include(${ZEPHYR_BASE}/boards/common/pyocd.board.cmake)
include(${ZEPHYR_BASE}/boards/common/jlink.board.cmake)
