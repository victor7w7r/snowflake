# SPDX-License-Identifier: GPL-2.0
dtb-$(CONFIG_ARCH_SUNXI) += \
	sun50i-h616-gpu.dtbo \
	sun50i-h616-i2c0-pi.dtbo \
	sun50i-h616-i2c1-pi.dtbo \
	sun50i-h616-i2c2-pi.dtbo \
	sun50i-h616-i2c2-ph.dtbo \
	sun50i-h616-i2c3-pg.dtbo \
	sun50i-h616-i2c3-ph.dtbo \
	sun50i-h616-i2c4-pg.dtbo \
	sun50i-h616-i2c4-ph.dtbo \
	sun50i-h616-keys.dtbo \
	sun50i-h616-pwm1-ph3.dtbo \
	sun50i-h616-pwm1-pi11.dtbo \
	sun50i-h616-pwm2-ph2.dtbo \
	sun50i-h616-pwm2-pi12.dtbo \
	sun50i-h616-pwm3-ph0.dtbo \
	sun50i-h616-pwm3-pi13.dtbo \
	sun50i-h616-pwm4-ph1.dtbo \
	sun50i-h616-pwm4-pi14.dtbo \
	sun50i-h616-uart2-pg.dtbo \
	sun50i-h616-uart2-pg-rts-cts.dtbo \
	sun50i-h616-uart2-ph.dtbo \
	sun50i-h616-uart2-ph-rts-cts.dtbo \
	sun50i-h616-uart2-pi.dtbo \
	sun50i-h616-uart2-pi-rts-cts.dtbo \
	sun50i-h616-uart3-pi.dtbo \
	sun50i-h616-uart3-pi-rts-cts.dtbo \
	sun50i-h616-uart4-pi.dtbo \
	sun50i-h616-uart4-pi-rts-cts.dtbo \
	sun50i-h616-uart5.dtbo \
	sun50i-h616-spi-spidev.dtbo \
	sun50i-h616-spidev0_0.dtbo \
	sun50i-h616-spidev1_0.dtbo \
	sun50i-h616-spidev1_1.dtbo \
	sun50i-h616-spidev1_2.dtbo \
	sun50i-h616-ir.dtbo \
	sun50i-h616-tft35_spi.dtbo \
	sun50i-h616-mcp2515.dtbo \
	sun50i-h616-ws2812.dtbo \
	sun50i-h616-light.dtbo

scr-$(CONFIG_ARCH_SUNXI) += \
	sun50i-h616-fixup.scr

targets += $(dtb-y) $(scr-y) $(dtbotxt-y)

always		:= $(dtb-y) $(scr-y) $(dtbotxt-y)
clean-files	:= *.dtbo *.scr
