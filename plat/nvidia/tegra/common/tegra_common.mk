#
# Copyright (c) 2015-2020, ARM Limited and Contributors. All rights reserved.
# Copyright (c) 2020, NVIDIA Corporation. All rights reserved.
#
# SPDX-License-Identifier: BSD-3-Clause
#

PLAT_INCLUDES		:=	-Iplat/nvidia/tegra/include/drivers \
				-Iplat/nvidia/tegra/include/lib \
				-Iplat/nvidia/tegra/include

include lib/xlat_tables_v2/xlat_tables.mk
PLAT_BL_COMMON_SOURCES	+=	${XLAT_TABLES_LIB_SRCS}

COMMON_DIR		:=	plat/nvidia/tegra/common

# Include GICv3 driver files
include drivers/arm/gic/v3/gicv3.mk
TEGRA_GICv3_SOURCES	:=	$(GICV3_SOURCES)				\
				plat/common/plat_gicv3.c			\
				${COMMON_DIR}/tegra_gicv3.c

# Include GICv2 driver files
include drivers/arm/gic/v2/gicv2.mk

TEGRA_GICv2_SOURCES	:=	${GICV2_SOURCES}				\
				plat/common/plat_gicv2.c			\
				${COMMON_DIR}/tegra_gicv2.c

BL31_SOURCES		+=	drivers/delay_timer/delay_timer.c		\
				drivers/io/io_storage.c				\
				plat/common/aarch64/crash_console_helpers.S	\
				${TEGRA_GICv2_SOURCES}				\
				${COMMON_DIR}/aarch64/tegra_helpers.S		\
				${COMMON_DIR}/lib/debug/profiler.c		\
				${COMMON_DIR}/tegra_bl31_setup.c		\
				${COMMON_DIR}/tegra_delay_timer.c		\
				${COMMON_DIR}/tegra_ehf.c			\
				${COMMON_DIR}/tegra_fiq_glue.c			\
				${COMMON_DIR}/tegra_io_storage.c		\
				${COMMON_DIR}/tegra_platform.c			\
				${COMMON_DIR}/tegra_pm.c			\
				${COMMON_DIR}/tegra_sip_calls.c			\
				${COMMON_DIR}/tegra_sdei.c

ifneq ($(ENABLE_STACK_PROTECTOR), 0)
BL31_SOURCES		+=	${COMMON_DIR}/tegra_stack_protector.c
endif
