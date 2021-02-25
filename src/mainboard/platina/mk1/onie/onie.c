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
#include "mainboard/platina/mk1/onie/chip.h"

static void onie_init(struct device *dev)
{
	int i;
	int err;
	int data;
	
	err = smbus_write_byte(dev, 0, 0);
	printk(BIOS_INFO, "%s: smbus_write_byte select address returned %d\n",
		       __func__, err);
	if (err < 0) {
		printk(BIOS_INFO, "%s: probe of %s failed\n",
		       __func__, dev_path(dev));
		return;
	}

	for (i = 0; i < 32; i++) {
		data = smbus_recv_byte(dev);
		printk(BIOS_INFO, "%s: offset %d returned %02x\n",
		       __func__, i, data);
	}
}

#if CONFIG(HAVE_ACPI_TABLES)

static void platina_mk1_onie_fill_ssdt(struct device *dev,
			void (*callback)(struct device *dev),
			struct mainboard_platina_mk1_onie_config *config)
{
	int err;
	const char *scope = "\\_SB.PCI0.SBUS";
	struct acpi_i2c i2c = {
		.address = dev->path.i2c.device,
		.mode_10bit = dev->path.i2c.mode_10bit,
		.speed = I2C_SPEED_FAST,
		.resource = scope,
	};
	struct acpi_dp *dsd = NULL;

	printk(BIOS_INFO, "%s: enabled %d\n",
	       __func__, dev->enabled);

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
	acpigen_write_scope(scope);
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
		dsd = acpi_dp_new_table("_DSD");
//		if (config->compat_string)
//			acpi_dp_add_string(dsd, "compatible", "platina-mk1");
		/* Add generic property list */
		acpi_dp_add_property_list(dsd, config->property_list,
					  config->property_count);
		acpi_dp_write(dsd);
	}

	/* Callback if any. */
	if (callback)
		callback(dev);

	acpigen_pop_len(); /* Device */
	acpigen_pop_len(); /* Scope */
	printk(BIOS_INFO, "%s: wrote ACPI tables\n", dev_path(dev));
}

static void platina_mk1_onie_fill_ssdt_generator(struct device *dev)
{
	platina_mk1_onie_fill_ssdt(dev, NULL, dev->chip_info);
}

/* Use name specified in config or build one from I2C address */
static const char *platina_mk1_onie_acpi_name(const struct device *dev)
{
	static char name[5];

	snprintf(name, sizeof(name), "D%03.3X", dev->path.i2c.device);
	name[4] = '\0';
	return name;
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
