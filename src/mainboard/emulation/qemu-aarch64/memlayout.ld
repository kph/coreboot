/*
 * This file is part of the coreboot project.
 *
 * Copyright 2019 Asami Doi <d0iasm.pub@gmail.com>
 *
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

#include <memlayout.h>
#include <arch/header.ld>

/*
 * Memory map for QEMU virt machine since
 * a578cdfbdd8f9beff5ced52b7826ddb1669abbbf (June 2019):
 *
 * 0..128MiB (0x0000_0000..0x0080_0000) is the space for a flash device.
 * 128MiB..256MiB (0x0080_0000..0x0100_0000) is used for miscellaneous device I/O.
 * 256MiB..1GiB (0x0100_0000..0x4000_0000) is reserved for possible future PCI support.
 * 1GiB.. (0x4000_0000) is RAM and the size depends on initial RAM and device memory settings.
 */
SECTIONS
{
	REGION(flash, 0x00000000, CONFIG_ROM_SIZE, 8)

	DRAM_START(0x40000000)
	BOOTBLOCK(0x60010000, 64K)
	STACK(0x60020000, 64K)
	ROMSTAGE(0x60030000, 128K)
	RAMSTAGE(0x60070000, 16M)

	TTB(0x61100000, 16K)
	POSTRAM_CBFS_CACHE(0x61110000, 1M)
}
