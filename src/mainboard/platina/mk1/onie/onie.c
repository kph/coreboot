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

enum onie_type {
	onie_type_nvmem_name		= 0x11,
	onie_type_nvmem_cache		= 0x12,
	onie_type_product_name		= 0x21,
	onie_type_part_number		= 0x22,
	onie_type_serial_number		= 0x23,
	onie_type_mac_base		= 0x24,
	onie_type_manufacture_date	= 0x25,
	onie_type_device_version	= 0x26,
	onie_type_label_revision	= 0x27,
	onie_type_platform_name		= 0x28,
	onie_type_onie_version		= 0x29,
	onie_type_num_macs		= 0x2a,
	onie_type_manufacturer		= 0x2b,
	onie_type_country_code		= 0x2c,
	onie_type_vendor		= 0x2d,
	onie_type_diag_version		= 0x2e,
	onie_type_service_tag		= 0x2f,
	onie_type_vendor_extension	= 0xfd,
	onie_type_crc			= 0xfe,
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

static struct onie_tlv *onie_next(struct onie_tlv *tlv)
{
	return (struct onie_tlv *)((u8*)tlv +
				   sizeof(struct onie_tlv) +
				   tlv->l);
}

static bool has_prefix(const char *pfx, const char *attr)
{
	size_t len = strlen(pfx);

	return strncmp(pfx, attr, len) == 0;
}

static void onie_init(struct device *dev)
{
	int i;
	int err;
	int data;
	static u8 buf[onie_max_data];
	struct onie_data *od = (struct onie_data *)buf;
	size_t tlvsz, fullsz, crcsz;
	u32 crc_read, crc_calc;
	u8 *end;
	struct onie_tlv *tlv;
	static bool found = 0;
	bool is_platina = 0;
	bool part_known = 0;
	int version = 0;
	
	if (!dev->enabled || found) {
		dev->enabled = 0;
		return;
	}
	
	err = smbus_write_byte(dev, 0, 0);
	printk(BIOS_INFO, "%s: smbus_write_byte select address returned %d\n",
	       __func__, err);
	if (err < 0) {
		printk(BIOS_INFO, "%s: probe of %s failed\n",
		       __func__, dev_path(dev));
		return;
	}

	found = 1;
	
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
	if (od->header.version != onie_header_version) {
		printk(BIOS_INFO, "%s: header version is %d\n",
		       __func__, od->header.version);
		return;
	};
	tlvsz = read_be16(&od->header.length);
	fullsz = sizeof(struct onie_header) + tlvsz;
	if (fullsz > onie_max_data) {
		printk(BIOS_INFO, "%s: too much data %zu\n",
		       __func__, fullsz);
		return;
	}
	crcsz = fullsz - onie_sz_crc;
	crc_read = read_be32(&buf[crcsz]);
	crc_calc = ~onie_crc(~0, buf, crcsz);	
	if (crc_read != crc_calc) {
		printk(BIOS_INFO, "%s crc read %x calc %x\n",
		       __func__, crc_read, crc_calc);
		return;
	}
	end = buf + sizeof(struct onie_header) + tlvsz;
	for (tlv = &od->tlv; (u8 *)tlv < end; tlv = onie_next(tlv)) {
		if ((u8 *)tlv + tlv->l > end) {
			printk(BIOS_INFO, "%s: tlv exceeds end",
			       __func__);
			return;
		}
		switch (tlv->t) {
		case onie_type_vendor:
			if (has_prefix("Platina", (char *)tlv->v)) {
				is_platina = 1;
			}
			break;

		case onie_type_part_number:
			if (has_prefix("BT77O759.00", (char *)tlv->v) ||
			    has_prefix("PS-3001-32C", (char *)tlv->v) ||
			    has_prefix("PSW-3001-32C", (char *)tlv->v)) {
				part_known = 1;
			}
			break;

		case onie_type_device_version:
			if (tlv->l != 1) {
				printk(BIOS_INFO, "%s: version length is %d\n",
				       __func__, tlv->l);
				continue;
			}
			version = *(u8 *)tlv->v;
			break;
		}
		printk(BIOS_INFO, "%s: tlv %x len %d\n", __func__, tlv->t, tlv->l);
	}
	printk(BIOS_INFO, "%s: is_platina %d part_known %d version %d\n",
	       __func__, is_platina, part_known, version);
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
	
	if (!dev->enabled) {
		return;
	}

	printk(BIOS_INFO, "%s: dev_path %s acpi_device_path %s scope %s enabled %d\n",
	       __func__, dev_path(dev), acpi_device_path(dev),
	       acpi_device_scope(dev), dev->enabled);

	
	err = smbus_write_byte(dev, 0, 0);
	if (err < 0) {
		printk(BIOS_INFO, "%s: %s failed\n",
		       __func__, dev_path(dev));
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
