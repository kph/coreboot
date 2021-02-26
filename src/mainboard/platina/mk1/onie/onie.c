/*
 * This file is part of the coreboot project.
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

#include <arch/acpi_device.h>
#include <arch/acpigen.h>
#include <console/console.h>
#include <device/i2c_simple.h>
#include <device/device.h>
#include <device/path.h>
#include <device/smbus.h>
#include <stdint.h>
#include <string.h>
#include <commonlib/endian.h>
#include "mainboard/platina/mk1/onie/chip.h"

enum onie_max {
	onie_max_data	= 2048,
	onie_max_tlv	=  255,
};

#define ONIE_HEADER_ID	"TlvInfo"

static const char onie_header_id[] = ONIE_HEADER_ID;

enum { onie_header_version = 1 };

enum onie_sz {
	onie_sz_header_id	= sizeof(ONIE_HEADER_ID),
	onie_sz_header_version	= sizeof(u8),
	onie_sz_header_length	= sizeof(u16),
	onie_sz_header		= onie_sz_header_id + onie_sz_header_version +
		onie_sz_header_length,
	onie_sz_tlv_type	= sizeof(u8),
	onie_sz_tlv_length	= sizeof(u8),
	onie_sz_crc		= sizeof(u32),
	onie_sz_mac		= 6,
};

struct __attribute__((packed)) onie_header {
	u8	id[onie_sz_header_id];
	u8	version;
	u8	length[onie_sz_header_length];
};

struct onie_tlv {
	u8 t;
	u8 l;
	u8 v[];
};

struct __attribute__((packed)) onie_data {
	struct onie_header header;
	struct onie_tlv tlv;
};

static u32
onie_crc(u32 crc, unsigned char const *p, size_t len)
{
	int i;
	while (len--) {
		crc ^= *p++;
		for (i = 0; i < 8; i++)
			crc = (crc >> 1) ^ ((crc & 1) ? 0xedb88320 : 0);
	}

	return crc;
}

static void onie_init(struct device *dev)
{
	int i;
	int err;
	int data;
	static unsigned char buf[onie_max_data];
	struct onie_header *h = (struct onie_header *)buf;
	size_t tlvsz, fullsz, crcsz;
	u32 crc_read, crc_calc;
	
	err = smbus_write_byte(dev, 0, 0);
	printk(BIOS_INFO, "%s: smbus_write_byte select address returned %d\n",
	       __func__, err);
	if (err < 0) {
		printk(BIOS_INFO, "%s: probe of %s failed\n",
		       __func__, dev_path(dev));
		return;
	}

	for (i = 0; i < onie_max_data; i++) {
		data = smbus_recv_byte(dev);
		if (data < 0) {
			printk(BIOS_INFO, "%s: offset %d returned %02x\n",
			       __func__, i, data);
			return;
		}
		buf[i] = data;
	}

	if (strcmp(onie_header_id, (char *)buf)) {
		printk(BIOS_INFO, "%s: header ID is %s\n",
		       __func__, buf);
		return;
	}
	if (h->version != onie_header_version) {
		printk(BIOS_INFO, "%s: header version is %d\n",
		       __func__, h->version);
		return;
	};
	tlvsz = read_be16(&h->length);
	fullsz = sizeof(*h) + tlvsz;
	if (fullsz > onie_max_data) {
		printk(BIOS_INFO, "%s: too much data %zu\n",
		       __func__, fullsz);
		return;
	}
	crcsz = fullsz - onie_sz_crc;
	crc_read = read_be32(&buf[crcsz]);
	crc_calc = ~onie_crc(~0, buf, crcsz);	
	printk(BIOS_INFO, "%s crc read %x calc %x\n",
	       __func__, crc_read, crc_calc);
}

#if CONFIG(HAVE_ACPI_TABLES)
/* Use name specified in config or build one from I2C address */
static const char *platina_mk1_onie_acpi_name(const struct device *dev)
{
	static char name[5];

	snprintf(name, sizeof(name), "D%03.3X", dev->path.i2c.device);
	name[4] = '\0';
	printk(BIOS_INFO, "%s: returning %s\n", __func__, name);
	return name;
}

static void platina_mk1_onie_fill_ssdt(struct device *dev,
			void (*callback)(struct device *dev),
			struct mainboard_platina_mk1_onie_config *config)
{
	int err;
	const char *sb_scope = "\\_SB";
	const char *sbus_scope = "\\_SB.PCI0.SBUS";
	struct acpi_i2c i2c = {
		.address = dev->path.i2c.device,
		.mode_10bit = dev->path.i2c.mode_10bit,
		.speed = I2C_SPEED_FAST,
		.resource = sbus_scope,
	};
	struct acpi_dp *dsd = NULL;
	struct acpi_dp *nvrg = NULL;
	struct acpi_dp *nvmem_cell_names = NULL;
	char name[DEVICE_PATH_MAX];
	
	printk(BIOS_INFO, "%s: dev_path %s acpi_device_path %s scope %s enabled %d\n",
	       __func__, dev_path(dev), acpi_device_path(dev),
	       acpi_device_scope(dev), dev->enabled);

	if (!dev->enabled) {
		return;
	}
	
	err = smbus_write_byte(dev, 0, 0);
	if (err < 0) {
		printk(BIOS_INFO, "%s: probe of %s failed\n",
		       __func__, dev_path(dev));
		dev->enabled = 0;
		return;
	}

	/* Device */
	acpigen_write_scope(sbus_scope);
	acpigen_write_device(acpi_device_name(dev));
	acpigen_write_name_string("_HID", "INT3499");
	acpigen_write_name_integer("_UID", 0);
	acpigen_write_name_string("_DDN", "ONIE");
	acpigen_write_STA(acpi_device_status(dev));

	/* Resources */
	acpigen_write_name("_CRS");
	acpigen_write_resourcetemplate_header();
	acpi_device_write_i2c(&i2c);

	acpigen_write_resourcetemplate_footer();

	if (1) {
		nvrg = acpi_dp_new_table("NVRG");
		acpi_dp_add_integer_array(nvrg, "reg", config->regs_list,
					  config->regs_count);
		dsd = acpi_dp_new_table("_DSD");
//		if (config->compat_string)
//			acpi_dp_add_string(dsd, "compatible", "platina-mk1");
		/* Add generic property list */
		acpi_dp_add_property_list(dsd, config->property_list,
					  config->property_count);
		acpi_dp_add_child(dsd, "onie-data", nvrg);
		acpi_dp_write(dsd);
	}

	/* Callback if any. */
	if (callback)
		callback(dev);

	acpigen_pop_len(); /* Device */
	acpigen_pop_len(); /* Scope */

	/* Device */
	acpigen_write_scope(sb_scope);
	acpigen_write_device("ONIE");
	acpigen_write_name_string("_HID", "PRP0001");
	dsd = acpi_dp_new_table("_DSD");
	acpi_dp_add_property_list(dsd, config->onie_list,
				  config->onie_count);

	snprintf(name, DEVICE_PATH_MAX, "%s.%s", sbus_scope,
		 platina_mk1_onie_acpi_name(dev));
	acpi_dp_add_reference(dsd, "nvmem-cells", name);
	nvmem_cell_names = acpi_dp_new_table("nvmem-cell-names");
	acpi_dp_add_string(nvmem_cell_names, NULL, "onie-data");
	
	acpi_dp_add_array(dsd, nvmem_cell_names);

	acpi_dp_write(dsd);
	
	acpigen_pop_len(); /* Device */
	acpigen_pop_len(); /* Scope */

	printk(BIOS_INFO, "%s: wrote ACPI tables\n", dev_path(dev));
}

static void platina_mk1_onie_fill_ssdt_generator(struct device *dev)
{
	platina_mk1_onie_fill_ssdt(dev, NULL, dev->chip_info);
}

#endif

static struct device_operations platina_mk1_onie_ops = {
	.read_resources		  = DEVICE_NOOP,
	.set_resources		  = DEVICE_NOOP,
	.enable_resources	  = DEVICE_NOOP,
	.init			  = onie_init,
#if CONFIG(HAVE_ACPI_TABLES)
	.acpi_name		  = platina_mk1_onie_acpi_name,
	.acpi_fill_ssdt_generator = platina_mk1_onie_fill_ssdt_generator,
#endif
};

static void platina_mk1_onie_enable(struct device *dev)
{
	printk(BIOS_INFO, "%s: enabling %s\n", __func__, dev_path(dev));

	dev->ops = &platina_mk1_onie_ops;
}

struct chip_operations mainboard_platina_mk1_onie_ops = {
	CHIP_NAME("ONIE EEPROM")
	.enable_dev = platina_mk1_onie_enable
};
