/*
 * This file is part of the coreboot project.
 *
 * Copyright (C) 2007-2009 coresystems GmbH
 * Copyright (C) 2011 Google Inc.
 * Copyright (C) 2015-2016 Intel Corp.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 2 of the License.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */

#include <arch/acpi.h>
DefinitionBlock(
	"dsdt.aml",
	"DSDT",
	0x02,		// DSDT revision: ACPI v2.0 and up
	OEM_ID,
	ACPI_TABLE_CREATOR,
	0x20110725	// OEM revision
)
{
	#include "acpi/platform.asl"

	Name(_S0, Package() { 0x00, 0x00, 0x00, 0x00 })
	Name(_S5, Package() { 0x07, 0x00, 0x00, 0x00 })

	Scope (\_SB)
	{
		Device (PCI0)
		{
			#include <acpi/southcluster.asl>
			#include <acpi/pcie1.asl>
		}

		Name (PRUN, Package() {
			Package() { 0x0008FFFF, 0, \_SB.PCI0.LPC0.LNKA, 0 },
			Package() { 0x0008FFFF, 1, \_SB.PCI0.LPC0.LNKB, 0 },
			Package() { 0x0008FFFF, 2, \_SB.PCI0.LPC0.LNKC, 0 },
			Package() { 0x0008FFFF, 3, \_SB.PCI0.LPC0.LNKD, 0 },

			Package() { 0x0009FFFF, 0, \_SB.PCI0.LPC0.LNKA, 0 },
			Package() { 0x0009FFFF, 1, \_SB.PCI0.LPC0.LNKB, 0 },
			Package() { 0x0009FFFF, 2, \_SB.PCI0.LPC0.LNKC, 0 },
			Package() { 0x0009FFFF, 3, \_SB.PCI0.LPC0.LNKD, 0 },

			Package() { 0x000AFFFF, 0, \_SB.PCI0.LPC0.LNKA, 0 },
			Package() { 0x000AFFFF, 1, \_SB.PCI0.LPC0.LNKB, 0 },
			Package() { 0x000AFFFF, 2, \_SB.PCI0.LPC0.LNKC, 0 },
			Package() { 0x000AFFFF, 3, \_SB.PCI0.LPC0.LNKD, 0 },

			Package() { 0x000BFFFF, 0, \_SB.PCI0.LPC0.LNKA, 0 },
			Package() { 0x000BFFFF, 1, \_SB.PCI0.LPC0.LNKB, 0 },
			Package() { 0x000BFFFF, 2, \_SB.PCI0.LPC0.LNKC, 0 },
			Package() { 0x000BFFFF, 3, \_SB.PCI0.LPC0.LNKD, 0 },

			Package() { 0x000CFFFF, 0, \_SB.PCI0.LPC0.LNKA, 0 },
			Package() { 0x000CFFFF, 1, \_SB.PCI0.LPC0.LNKB, 0 },
			Package() { 0x000CFFFF, 2, \_SB.PCI0.LPC0.LNKC, 0 },
			Package() { 0x000CFFFF, 3, \_SB.PCI0.LPC0.LNKD, 0 },

			Package() { 0x000DFFFF, 0, \_SB.PCI0.LPC0.LNKA, 0 },
			Package() { 0x000DFFFF, 1, \_SB.PCI0.LPC0.LNKB, 0 },
			Package() { 0x000DFFFF, 2, \_SB.PCI0.LPC0.LNKC, 0 },
			Package() { 0x000DFFFF, 3, \_SB.PCI0.LPC0.LNKD, 0 },

			Package() { 0x000EFFFF, 0, \_SB.PCI0.LPC0.LNKA, 0 },
			Package() { 0x000EFFFF, 1, \_SB.PCI0.LPC0.LNKB, 0 },
			Package() { 0x000EFFFF, 2, \_SB.PCI0.LPC0.LNKC, 0 },
			Package() { 0x000EFFFF, 3, \_SB.PCI0.LPC0.LNKD, 0 },

			Package() { 0x000FFFFF, 0, \_SB.PCI0.LPC0.LNKA, 0 },
			Package() { 0x000FFFFF, 1, \_SB.PCI0.LPC0.LNKB, 0 },
			Package() { 0x000FFFFF, 2, \_SB.PCI0.LPC0.LNKC, 0 },
			Package() { 0x000FFFFF, 3, \_SB.PCI0.LPC0.LNKD, 0 },

			Package() { 0x0010FFFF, 0, \_SB.PCI0.LPC0.LNKA, 0 },
			Package() { 0x0010FFFF, 1, \_SB.PCI0.LPC0.LNKB, 0 },
			Package() { 0x0010FFFF, 2, \_SB.PCI0.LPC0.LNKC, 0 },
			Package() { 0x0010FFFF, 3, \_SB.PCI0.LPC0.LNKD, 0 },

			Package() { 0x0011FFFF, 0, \_SB.PCI0.LPC0.LNKA, 0 },
			Package() { 0x0011FFFF, 1, \_SB.PCI0.LPC0.LNKB, 0 },
			Package() { 0x0011FFFF, 2, \_SB.PCI0.LPC0.LNKC, 0 },
			Package() { 0x0011FFFF, 3, \_SB.PCI0.LPC0.LNKD, 0 },

			Package() { 0x0012FFFF, 0, \_SB.PCI0.LPC0.LNKA, 0 },
			Package() { 0x0012FFFF, 1, \_SB.PCI0.LPC0.LNKB, 0 },
			Package() { 0x0012FFFF, 2, \_SB.PCI0.LPC0.LNKC, 0 },
			Package() { 0x0012FFFF, 3, \_SB.PCI0.LPC0.LNKD, 0 },

			Package() { 0x0013FFFF, 0, \_SB.PCI0.LPC0.LNKA, 0 },
			Package() { 0x0013FFFF, 1, \_SB.PCI0.LPC0.LNKB, 0 },
			Package() { 0x0013FFFF, 2, \_SB.PCI0.LPC0.LNKC, 0 },
			Package() { 0x0013FFFF, 3, \_SB.PCI0.LPC0.LNKD, 0 },

			Package() { 0x0014FFFF, 0, \_SB.PCI0.LPC0.LNKA, 0 },
			Package() { 0x0014FFFF, 1, \_SB.PCI0.LPC0.LNKB, 0 },
			Package() { 0x0014FFFF, 2, \_SB.PCI0.LPC0.LNKC, 0 },
			Package() { 0x0014FFFF, 3, \_SB.PCI0.LPC0.LNKD, 0 },

			Package() { 0x0016FFFF, 0, \_SB.PCI0.LPC0.LNKA, 0 },
			Package() { 0x0016FFFF, 1, \_SB.PCI0.LPC0.LNKB, 0 },
			Package() { 0x0016FFFF, 2, \_SB.PCI0.LPC0.LNKC, 0 },
			Package() { 0x0016FFFF, 3, \_SB.PCI0.LPC0.LNKD, 0 },

			Package() { 0x0017FFFF, 0, \_SB.PCI0.LPC0.LNKA, 0 },
			Package() { 0x0017FFFF, 1, \_SB.PCI0.LPC0.LNKB, 0 },
			Package() { 0x0017FFFF, 2, \_SB.PCI0.LPC0.LNKC, 0 },
			Package() { 0x0017FFFF, 3, \_SB.PCI0.LPC0.LNKD, 0 },

			Package() { 0x0018FFFF, 0, \_SB.PCI0.LPC0.LNKA, 0 },
			Package() { 0x0018FFFF, 1, \_SB.PCI0.LPC0.LNKB, 0 },
			Package() { 0x0018FFFF, 2, \_SB.PCI0.LPC0.LNKC, 0 },
			Package() { 0x0018FFFF, 3, \_SB.PCI0.LPC0.LNKD, 0 },

			Package() { 0x0019FFFF, 0, \_SB.PCI0.LPC0.LNKA, 0 },
			Package() { 0x0019FFFF, 1, \_SB.PCI0.LPC0.LNKB, 0 },
			Package() { 0x0019FFFF, 2, \_SB.PCI0.LPC0.LNKC, 0 },
			Package() { 0x0019FFFF, 3, \_SB.PCI0.LPC0.LNKD, 0 },

			Package() { 0x001CFFFF, 0, \_SB.PCI0.LPC0.LNKA, 0 },
			Package() { 0x001CFFFF, 1, \_SB.PCI0.LPC0.LNKB, 0 },
			Package() { 0x001CFFFF, 2, \_SB.PCI0.LPC0.LNKC, 0 },
			Package() { 0x001CFFFF, 3, \_SB.PCI0.LPC0.LNKD, 0 },

			Package() { 0x001DFFFF, 0, \_SB.PCI0.LPC0.LNKA, 0 },
			Package() { 0x001DFFFF, 1, \_SB.PCI0.LPC0.LNKB, 0 },
			Package() { 0x001DFFFF, 2, \_SB.PCI0.LPC0.LNKC, 0 },
			Package() { 0x001DFFFF, 3, \_SB.PCI0.LPC0.LNKD, 0 },

			Package() { 0x001EFFFF, 0, \_SB.PCI0.LPC0.LNKA, 0 },
			Package() { 0x001EFFFF, 1, \_SB.PCI0.LPC0.LNKB, 0 },
			Package() { 0x001EFFFF, 2, \_SB.PCI0.LPC0.LNKC, 0 },
			Package() { 0x001EFFFF, 3, \_SB.PCI0.LPC0.LNKD, 0 },

			Package() { 0x001FFFFF, 0, \_SB.PCI0.LPC0.LNKA, 0 },
			Package() { 0x001FFFFF, 1, \_SB.PCI0.LPC0.LNKB, 0 },
			Package() { 0x001FFFFF, 2, \_SB.PCI0.LPC0.LNKC, 0 },
			Package() { 0x001FFFFF, 3, \_SB.PCI0.LPC0.LNKD, 0 },
		})

		Name (ARUN, Package() {
			Package() { 0x0008FFFF, 0, 0, 16 },
			Package() { 0x0008FFFF, 1, 0, 17 },
			Package() { 0x0008FFFF, 2, 0, 18 },
			Package() { 0x0008FFFF, 3, 0, 19 },

			Package() { 0x0009FFFF, 0, 0, 16 },
			Package() { 0x0009FFFF, 1, 0, 17 },
			Package() { 0x0009FFFF, 2, 0, 18 },
			Package() { 0x0009FFFF, 3, 0, 19 },

			Package() { 0x000AFFFF, 0, 0, 16 },
			Package() { 0x000AFFFF, 1, 0, 17 },
			Package() { 0x000AFFFF, 2, 0, 18 },
			Package() { 0x000AFFFF, 3, 0, 19 },

			Package() { 0x000BFFFF, 0, 0, 16 },
			Package() { 0x000BFFFF, 1, 0, 17 },
			Package() { 0x000BFFFF, 2, 0, 18 },
			Package() { 0x000BFFFF, 3, 0, 19 },

			Package() { 0x000CFFFF, 0, 0, 16 },
			Package() { 0x000CFFFF, 1, 0, 17 },
			Package() { 0x000CFFFF, 2, 0, 18 },
			Package() { 0x000CFFFF, 3, 0, 19 },

			Package() { 0x000DFFFF, 0, 0, 16 },
			Package() { 0x000DFFFF, 1, 0, 17 },
			Package() { 0x000DFFFF, 2, 0, 18 },
			Package() { 0x000DFFFF, 3, 0, 19 },

			Package() { 0x000EFFFF, 0, 0, 16 },
			Package() { 0x000EFFFF, 1, 0, 17 },
			Package() { 0x000EFFFF, 2, 0, 18 },
			Package() { 0x000EFFFF, 3, 0, 19 },

			Package() { 0x000FFFFF, 0, 0, 16 },
			Package() { 0x000FFFFF, 1, 0, 17 },
			Package() { 0x000FFFFF, 2, 0, 18 },
			Package() { 0x000FFFFF, 3, 0, 19 },

			Package() { 0x0010FFFF, 0, 0, 16 },
			Package() { 0x0010FFFF, 1, 0, 17 },
			Package() { 0x0010FFFF, 2, 0, 18 },
			Package() { 0x0010FFFF, 3, 0, 19 },

			Package() { 0x0011FFFF, 0, 0, 16 },
			Package() { 0x0011FFFF, 1, 0, 17 },
			Package() { 0x0011FFFF, 2, 0, 18 },
			Package() { 0x0011FFFF, 3, 0, 19 },

			Package() { 0x0012FFFF, 0, 0, 16 },
			Package() { 0x0012FFFF, 1, 0, 17 },
			Package() { 0x0012FFFF, 2, 0, 18 },
			Package() { 0x0012FFFF, 3, 0, 19 },

			Package() { 0x0013FFFF, 0, 0, 16 },
			Package() { 0x0013FFFF, 1, 0, 17 },
			Package() { 0x0013FFFF, 2, 0, 18 },
			Package() { 0x0013FFFF, 3, 0, 19 },

			Package() { 0x0014FFFF, 0, 0, 16 },
			Package() { 0x0014FFFF, 1, 0, 17 },
			Package() { 0x0014FFFF, 2, 0, 18 },
			Package() { 0x0014FFFF, 3, 0, 19 },

			Package() { 0x0016FFFF, 0, 0, 16 },
			Package() { 0x0016FFFF, 1, 0, 17 },
			Package() { 0x0016FFFF, 2, 0, 18 },
			Package() { 0x0016FFFF, 3, 0, 19 },

			Package() { 0x0017FFFF, 0, 0, 16 },
			Package() { 0x0017FFFF, 1, 0, 17 },
			Package() { 0x0017FFFF, 2, 0, 18 },
			Package() { 0x0017FFFF, 3, 0, 19 },

			Package() { 0x0018FFFF, 0, 0, 16 },
			Package() { 0x0018FFFF, 1, 0, 17 },
			Package() { 0x0018FFFF, 2, 0, 18 },
			Package() { 0x0018FFFF, 3, 0, 19 },

			Package() { 0x0019FFFF, 0, 0, 16 },
			Package() { 0x0019FFFF, 1, 0, 17 },
			Package() { 0x0019FFFF, 2, 0, 18 },
			Package() { 0x0019FFFF, 3, 0, 19 },

			Package() { 0x001CFFFF, 0, 0, 16 },
			Package() { 0x001CFFFF, 1, 0, 17 },
			Package() { 0x001CFFFF, 2, 0, 18 },
			Package() { 0x001CFFFF, 3, 0, 19 },

			Package() { 0x001DFFFF, 0, 0, 16 },
			Package() { 0x001DFFFF, 1, 0, 17 },
			Package() { 0x001DFFFF, 2, 0, 18 },
			Package() { 0x001DFFFF, 3, 0, 19 },

			Package() { 0x001EFFFF, 0, 0, 16 },
			Package() { 0x001EFFFF, 1, 0, 17 },
			Package() { 0x001EFFFF, 2, 0, 18 },
			Package() { 0x001EFFFF, 3, 0, 19 },

			Package() { 0x001FFFFF, 0, 0, 16 },
			Package() { 0x001FFFFF, 1, 0, 17 },
			Package() { 0x001FFFFF, 2, 0, 18 },
			Package() { 0x001FFFFF, 3, 0, 19 },
		})

		Device (UNC0)
		{
			Name (_HID, EisaId ("PNP0A03"))
			Name (_UID, 0x3F)
			Method (_BBN, 0, NotSerialized)
			{
				Return (0xff)
			}

			Name (_ADR, 0x00)
			Method (_STA, 0, NotSerialized)
			{
				Return (0xf)
			}

			Name (_CRS, ResourceTemplate ()
			{
				WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
					0x0000,             // Granularity
					0x00FF,             // Range Minimum
					0x00FF,             // Range Maximum
					0x0000,             // Translation Offset
					0x0001,             // Length
					,, )
			})

			Method (_PRT, 0, NotSerialized)
			{
				If (LEqual (PICM, Zero))
				{
					Return (PRUN)
				}

				Return (ARUN)
			}
		}
	}

	#include "acpi/mainboard.asl"

	scope (\_SB)
	{
		Device (ONI0)
		{
			Name (_HID, "PRP0001")
        		Name (_DSD, Package() {
                	     ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                	     Package () {
                             	     Package () { "compatible", "linux,onie" },
				     Package () { "nvmem-cells", Package() { \_SB.PCI0.SBUS.NVM0 } },
				     Package () { "nvmem-cell-names", Package() { "onie-data" } },
                	     }
        		})
		}

		Device (ONI1)
		{
			Name (_HID, "PRP0001")
        		Name (_DSD, Package() {
                	     ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                	     Package () {
                             	     Package () { "compatible", "linux,onie" },
				     Package () { "nvmem-cells", Package() { \_SB.PCI0.SBUS.NVM1 } },
				     Package () { "nvmem-cell-names", Package() { "onie-data" } },
                	     }
        		})
		}
	}
	
	Scope (\_SB.PCI0.SBUS)
	{
		Device (NVM0)
		{	
			Name (_HID, "INT3499") /* _HID: Hardware ID */
			Name (_UID, Zero)  /* _UID: Unique ID */
			Name (_DDN, "ONIE")  /* _DDN: DOS Device Name */

			Method (_STA, 0, NotSerialized)  /* _STA: Status */
			{
				Return (0x0F)
			}

			Name (_CRS, ResourceTemplate ()
			{
				I2cSerialBus (0x0051,
					     ControllerInitiated,
					     400000, // Bus Speed
					     AddressingMode7Bit,
					     "\\_SB.PCI0.SBUS", // Link to host controller
					     0x00, // Resource source index, MBZ
					     ResourceConsumer,
					     ,) // Descriptor Name
			})

			Name (_DSD, Package ()
			{
				ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
				Package () {
					Package () { "size", 16384 },
					Package () { "pagesize", 64 },
					Package () { "no-read-rollover", 1 },
					Package () { "address-width", 16 },
				},
				ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
				Package () {
					Package () { "onie-data", NVRG },
				}
			})

			Name (NVRG, Package() {
				ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
				Package () {
					Package () { "reg", Package() { 0x0, 0x0800 } },
				}
			})
		}
		
		Device (NVM1)
		{	
			Name (_HID, "INT3499") /* _HID: Hardware ID */
			Name (_UID, Zero)  /* _UID: Unique ID */
			Name (_DDN, "ONIE")  /* _DDN: DOS Device Name */

			Method (_STA, 0, NotSerialized)  /* _STA: Status */
			{
				Return (0x0F)
			}

			Name (_CRS, ResourceTemplate ()
			{
				I2cSerialBus (0x0053,
					     ControllerInitiated,
					     400000, // Bus Speed
					     AddressingMode7Bit,
					     "\\_SB.PCI0.SBUS", // Link to host controller
					     0x00, // Resource source index, MBZ
					     ResourceConsumer,
					     ,) // Descriptor Name
			})

			Name (_DSD, Package ()
			{
				ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
				Package () {
					Package () { "size", 16384 },
					Package () { "pagesize", 64 },
					Package () { "no-read-rollover", 1 },
					Package () { "address-width", 16 },
				},
				ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
				Package () {
					Package () { "onie-data", "NVRG" },
				}
			})

			Name (NVRG, Package() {
				ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
				Package () {
					Package () { "reg", Package() { 0x0, 0x0800 } },
				}
			})
		}

		Device (TMP0)
		{
			Name (_HID, "PRP0001")
        		Name (_DSD, Package() {
                	     ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                	     Package () {
                             	     Package () { "compatible", "ti,tmp75" },
                	     }
        		})
        		Method (_CRS, 0, Serialized)
        		{
				Name (SBUF, ResourceTemplate ()
                		{
					I2cSerialBusV2 (0x4f, ControllerInitiated,
                                	400000, AddressingMode7Bit,
                                	"\\_SB.PCI0.SBUS", 0x00,
                                	ResourceConsumer, , Exclusive,)
               			})
                		Return (SBUF)
        		}
		}

		Device (MUX0)
		{
			Name (_HID, "PRP0001")
        		Name (_DSD, Package() {
                	     ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                	     Package () {
                             	     Package () { "compatible", "nxp,pca9548" },
                	     }
        		})
        		Name (_CRS, ResourceTemplate()
			{
				I2cSerialBus (0x70, ControllerInitiated,
                                		     400000, AddressingMode7Bit,
                                		     "\\_SB.PCI0.SBUS", 0x00,
                                		     ResourceConsumer, ,)
			})

			Device (CH00)
			{
				Name (_ADR, 0)

				Device (QS00)
				{
					Name (_HID, "PRP0001")
        				Name (_DSD, Package() {
                	     		     ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                	     		     Package () {
						     Package () { "compatible", "nxp,pca9548" },
                	     		     }
					})

					Name (_CRS, ResourceTemplate () {
					     I2cSerialBus (0x71,
					     ControllerInitiated, 400000,
					     AddressingMode7Bit, "\\_SB.PCI0.SBUS.MUX0.CH00", 0x00,
					     ResourceConsumer, ,)
					     })
				}
			}

			Device (CH01)
			{
				Name (_ADR, 1)

				Device (QS10)
				{
					Name (_HID, "PRP0001")
        				Name (_DSD, Package() {
                	     		     ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                	     		     Package () {
						     Package () { "compatible", "nxp,pca9548" },
                	     		     }
					})

					Name (_CRS, ResourceTemplate () {
					     I2cSerialBus (0x71,
					     ControllerInitiated, 400000,
					     AddressingMode7Bit, "\\_SB.PCI0.SBUS.MUX0.CH01", 0x00,
					     ResourceConsumer,,)
					})
				}
			}

			Device (CH02)
			{
				Name (_ADR, 2)

				Device (QS20)
				{
					Name (_HID, "PRP0001")
        				Name (_DSD, Package() {
                	     		     ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                	     		     Package () {
						     Package () { "compatible", "nxp,pca9548" },
                	     		     }
					})

					Name (_CRS, ResourceTemplate () {
					     I2cSerialBus (0x71,
					     ControllerInitiated, 400000,
					     AddressingMode7Bit, "\\_SB.PCI0.SBUS.MUX0.CH02", 0x00,
					     ResourceConsumer,,)
					})
				}
			}

			Device (CH03)
			{
				Name (_ADR, 3)

				Device (QS30)
				{
					Name (_HID, "PRP0001")
        				Name (_DSD, Package() {
                	     		     ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                	     		     Package () {
						     Package () { "compatible", "nxp,pca9548" },
                	     		     }
					})

					Name (_CRS, ResourceTemplate () {
					     I2cSerialBus (0x71,
					     ControllerInitiated, 400000,
					     AddressingMode7Bit, "\\_SB.PCI0.SBUS.MUX0.CH03", 0x00,
					     ResourceConsumer,,)
					})
				}
			}

			Device (CH04)
			{
				Name (_ADR, 4)

				Device (QS40)
				{
					Name (_HID, "PRP0001")
        				Name (_DSD, Package() {
						ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
						Package () {
							Package () { "compatible", "nxp,pca9555" },
							Package () { "gpio-line-names",
								Package () {
									"PORT0_ABS",  "PORT1_ABS", 
						    			"PORT2_ABS",  "PORT3_ABS", 
									"PORT4_ABS",  "PORT5_ABS", 
									"PORT6_ABS",  "PORT7_ABS", 
						 			"PORT8_ABS",  "PORT9_ABS",
									"PORT10_ABS",  "PORT11_ABS",
									"PORT12_ABS",  "PORT13_ABS",
									"PORT14_ABS",  "PORT15_ABS"
								}
							}
						}
					})

					Name (_CRS, ResourceTemplate () {
					     I2cSerialBus (0x20,
					     ControllerInitiated, 400000,
					     AddressingMode7Bit, "\\_SB.PCI0.SBUS.MUX0.CH04", 0x00,
					     ResourceConsumer,,)
					})
				}

				Device (QS41)
				{
					Name (_HID, "PRP0001")
        				Name (_DSD, Package() {
						ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
						Package () {
							Package () { "compatible", "nxp,pca9555" },
							Package () { "gpio-line-names",
								Package () {
									"PORT16_ABS",  "PORT17_ABS", 
						    			"PORT18_ABS",  "PORT19_ABS", 
									"PORT20_ABS",  "PORT21_ABS", 
									"PORT22_ABS",  "PORT23_ABS", 
						 			"PORT24_ABS",  "PORT25_ABS",
									"PORT26_ABS",  "PORT27_ABS",
									"PORT28_ABS",  "PORT29_ABS",
									"PORT30_ABS",  "PORT31_ABS"
								}
							}
						}
					})

					Name (_CRS, ResourceTemplate () {
					     I2cSerialBus (0x21,
					     ControllerInitiated, 400000,
					     AddressingMode7Bit, "\\_SB.PCI0.SBUS.MUX0.CH04", 0x00,
					     ResourceConsumer,,)
					})
				}

				Device (QS42)
				{
					Name (_HID, "PRP0001")
        				Name (_DSD, Package() {
						ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
						Package () {
							Package () { "compatible", "nxp,pca9555" },
							Package () { "gpio-line-names",
								Package () {
									"PORT0_INT_L",  "PORT1_INT_L", 
						    			"PORT2_INT_L",  "PORT3_INT_L", 
									"PORT4_INT_L",  "PORT5_INT_L", 
									"PORT6_INT_L",  "PORT7_INT_L", 
						 			"PORT8_INT_L",  "PORT9_INT_L",
									"PORT10_INT_L",  "PORT11_INT_L",
									"PORT12_INT_L",  "PORT13_INT_L",
									"PORT14_INT_L",  "PORT15_INT_L"
								}
							}
                	     		     }
					})

					Name (_CRS, ResourceTemplate () {
					     I2cSerialBus (0x22,
					     ControllerInitiated, 400000,
					     AddressingMode7Bit, "\\_SB.PCI0.SBUS.MUX0.CH04", 0x00,
					     ResourceConsumer,,)
					})
				}

				Device (QS43)
				{
					Name (_HID, "PRP0001")
        				Name (_DSD, Package() {
						ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
						Package () {
							Package () { "compatible", "nxp,pca9555" },
							Package () { "gpio-line-names",
								Package () {
									"PORT16_INT_L",  "PORT17_INT_L", 
						    			"PORT18_INT_L",  "PORT19_INT_L", 
									"PORT20_INT_L",  "PORT21_INT_L", 
									"PORT22_INT_L",  "PORT23_INT_L", 
						 			"PORT24_INT_L",  "PORT25_INT_L",
									"PORT26_INT_L",  "PORT27_INT_L",
									"PORT28_INT_L",  "PORT29_INT_L",
									"PORT30_INT_L",  "PORT31_INT_L"
								}
							}
						}
					})

					Name (_CRS, ResourceTemplate () {
					     I2cSerialBus (0x23,
					     ControllerInitiated, 400000,
					     AddressingMode7Bit, "\\_SB.PCI0.SBUS.MUX0.CH04", 0x00,
					     ResourceConsumer,,)
					})
				}
			}

			Device (CH05)
			{
				Name (_ADR, 5)

				Device (QS40)
				{
					Name (_HID, "PRP0001")
        				Name (_DSD, Package() {
						ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
						Package () {
							Package () { "compatible", "nxp,pca9555" },
							Package () { "gpio-line-names",
								Package () {
									"PORT0_LPMODE",  "PORT1_LPMODE", 
						    			"PORT2_LPMODE",  "PORT3_LPMODE", 
									"PORT4_LPMODE",  "PORT5_LPMODE", 
									"PORT6_LPMODE",  "PORT7_LPMODE", 
						 			"PORT8_LPMODE",  "PORT9_LPMODE",
									"PORT10_LPMODE",  "PORT11_LPMODE",
									"PORT12_LPMODE",  "PORT13_LPMODE",
									"PORT14_LPMODE",  "PORT15_LPMODE"
								}
							}
                	     		     }
					})

					Name (_CRS, ResourceTemplate () {
					     I2cSerialBus (0x20,
					     ControllerInitiated, 400000,
					     AddressingMode7Bit, "\\_SB.PCI0.SBUS.MUX0.CH05", 0x00,
					     ResourceConsumer,,)
					})
				}

				Device (QS41)
				{
					Name (_HID, "PRP0001")
        				Name (_DSD, Package() {
						ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
						Package () {
							Package () { "compatible", "nxp,pca9555" },
							Package () { "gpio-line-names",
								Package () {
									"PORT16_LPMODE",  "PORT17_LPMODE", 
						    			"PORT18_LPMODE",  "PORT19_LPMODE", 
									"PORT20_LPMODE",  "PORT21_LPMODE", 
									"PORT22_LPMODE",  "PORT23_LPMODE", 
						 			"PORT24_LPMODE",  "PORT25_LPMODE",
									"PORT26_LPMODE",  "PORT27_LPMODE",
									"PORT28_LPMODE",  "PORT29_LPMODE",
									"PORT30_LPMODE",  "PORT31_LPMODE"
								}
							}
						}
					})

					Name (_CRS, ResourceTemplate () {
					     I2cSerialBus (0x21,
					     ControllerInitiated, 400000,
					     AddressingMode7Bit, "\\_SB.PCI0.SBUS.MUX0.CH05", 0x00,
					     ResourceConsumer,,)
					})
				}

				Device (QS42)
				{
					Name (_HID, "PRP0001")
        				Name (_DSD, Package() {
						ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                	     			Package () {
							Package () { "compatible", "nxp,pca9555" },
							Package () { "gpio-line-names",
								Package () {
									"PORT0_RST_L",  "PORT1_RST_L", 
						    			"PORT2_RST_L",  "PORT3_RST_L", 
									"PORT4_RST_L",  "PORT5_RST_L", 
									"PORT6_RST_L",  "PORT7_RST_L", 
						 			"PORT8_RST_L",  "PORT9_RST_L",
									"PORT10_RST_L",  "PORT11_RST_L",
									"PORT12_RST_L",  "PORT13_RST_L",
									"PORT14_RST_L",  "PORT15_RST_L"
								}
							}
						}
					})

					Name (_CRS, ResourceTemplate () {
					     I2cSerialBus (0x22,
					     ControllerInitiated, 400000,
					     AddressingMode7Bit, "\\_SB.PCI0.SBUS.MUX0.CH05", 0x00,
					     ResourceConsumer,,)
					})
				}

				Device (QS43)
				{
					Name (_HID, "PRP0001")
        				Name (_DSD, Package() {
						ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
						Package () {
							Package () { "compatible", "nxp,pca9555" },
 							Package () { "gpio-line-names",
								Package () {
									"PORT16_RST_L",  "PORT17_RST_L", 
						    			"PORT18_RST_L",  "PORT19_RST_L", 
									"PORT20_RST_L",  "PORT21_RST_L", 
									"PORT22_RST_L",  "PORT23_RST_L", 
						 			"PORT24_RST_L",  "PORT25_RST_L",
									"PORT26_RST_L",  "PORT27_RST_L",
									"PORT28_RST_L",  "PORT29_RST_L",
									"PORT30_RST_L",  "PORT31_RST_L"
								}
							}
						}
					})

					Name (_CRS, ResourceTemplate () {
					     I2cSerialBus (0x23,
					     ControllerInitiated, 400000,
					     AddressingMode7Bit, "\\_SB.PCI0.SBUS.MUX0.CH05", 0x00,
					     ResourceConsumer,,)
					})
				}
			}
		}

		Device (GPIO)
		{
			Name (_HID, "PRP0001")
        		Name (_DSD, Package() {
				ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
				Package () {
					Package () { "compatible", "nxp,pca9539" },
 					Package () { "gpio-line-names",
						Package () {
							"TH_RST_L", "TH_PCIE_RST_L", 
							"LED_CLR", "HOST_TO_BMC_I2C", 
							"UART_MUX_SEL", "USB_MUX_SEL", 
							"TH_CLK_FSEL_0", "TH_CLK_FSEL_1", 
						 	"TH_INT_L", "QSFP_GPIO0_INT_L",
							"QSFP_GPIO1_INT_L", "QSFP_GPIO2_INT_L",
							"QSFP_GPIO3_INT_L", "TH_CLK_SEL",
							"I210_RST_L", "I210_PE_RST_L"
						}
					}
				}
        		})
        		Name (_CRS, ResourceTemplate ()
			{
				I2cSerialBus (0x74, ControllerInitiated,
					400000, AddressingMode7Bit,
                                	"\\_SB.PCI0.SBUS", 0x00,
                                	ResourceConsumer, ,)
               		})
		}
	}
}
