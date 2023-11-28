tags: #linux #kernel
title: Device tree
description: Lessons learned from SJA1000 and weim

Device tree
===========

INVENSENSE ICM20948 IMU (Inertial Measurement Unit)
---------------------------------------------------

If a chip is supported in a driver this doesn't mean your variant is
supported as well. If your part number is slightly different there is a
chance that the complete registermap has changed:

> This driver supports the Invensense MPU6050/9150,
> MPU6500/6515/6880/9250/9255, ICM20608(D)/20609/20689,
> ICM20602/ICM20690

But not ICM20948, it's a whole new device.

NXP SJA1000 and i.MX weim
-------------------------

16 bit bus mode (see EIM multiplexed mode) but 8 bit peripheral. Use
AD08 and AD09 as chip select. Map peripheral to address range in device
tree. Patch kernel.

    &weim {
    	status = "okay";
    	ranges = <
    		0 0 0x08000000 0x04000000
    		1 0 0x0C000000 0x04000000
    		>;
    	pinctrl-names = "default";
    	pinctrl-0 = <&pinctrl_weim_sja1000 &pinctrl_weim_cs &pinctrl_weim_unused
    		    >;

    	sja-can-xtal@0,0 {
    		compatible = "nxp,sja1000";
    		reg = <0 0x0 0x80>;
    		interrupts = <31 2>;
    		interrupt-parent = <&gpio2>;
    		nxp,external-clock-frequency = <24000000>;
    		nxp,clock-out-frequency = <24000000>;
    		nxp,tx-output-config = <0x06>;
    		fsl,weim-cs-timing = <0x07f13039 0x00001002 0x18683372
    					0x00000068 0xd863ffe6 0x00000000>;
    	};

    	sja-can-slave@0,1 {
    		compatible = "nxp,sja1000";
    		reg = <1 0x0 0x80>;
    		interrupts = <23 2>;
    		interrupt-parent = <&gpio3>;
    		nxp,external-clock-frequency = <24000000>;
    		nxp,tx-output-config = <0x06>;
    		fsl,weim-cs-timing = <0x07f13039 0x00001002 0x18683372
    					0x00000068 0xd863ffe6 0x00000000>;
    	};
    };

And patch register r/w:

    Index: linux-4.14.74/drivers/net/can/sja1000/sja1000_platform.c
    ===================================================================
    --- linux-4.14.74.orig/drivers/net/can/sja1000/sja1000_platform.c
    +++ linux-4.14.74/drivers/net/can/sja1000/sja1000_platform.c
    @@ -52,12 +52,14 @@ struct technologic_priv {

     static u8 sp_read_reg8(const struct sja1000_priv *priv, int reg)
     {
    -	return ioread8(priv->reg_base + reg);
    +	u16 data;
    +	data = ioread16(priv->reg_base + reg*2);
    +	return data>>1;
     }

     static void sp_write_reg8(const struct sja1000_priv *priv, int reg, u8 val)
     {
    -	iowrite8(val, priv->reg_base + reg);
    +	iowrite16(val * 2, priv->reg_base + reg * 2);
     }

     static u8 sp_read_reg16(const struct sja1000_priv *priv, int reg)

MCP2515 SPI CAN controller
--------------------------

Don't forget to pinmux irq and reset lines.

    	pinctrl_mcp2515: mcp2515grp {
                    fsl,pins = <
    			/* irq  */
    			/* MX6QDL_PAD_SD4_DAT3__GPIO2_IO11 0x000b1 */
    			/* rst */
    			MX6QDL_PAD_NANDF_CS2__GPIO6_IO15 0x000b1
                    >;
            };

Otherwise fairly simple:

    	spi_can: spi_can@0 {
    		compatible = "microchip,mcp2515";
    		reg = <0>;
    		pinctrl-names = "default";
    		pinctrl-0 = <&pinctrl_mcp2515>;
    		spi-max-frequency = <10000000>;
    		clocks = <&clk_mcp251x>;
    		interrupt-parent = <&gpio2>;
    		interrupts = <11 0x2>;
    		vdd-supply = <&reg_mcp2515>;
    		status = "okay";
    	};

NXP PCA9575 GPIO expander
-------------------------

If a chip is supported, this doesn't mean that all variants support all
features.

    NXP PCA953x I2C GPIO multiplexer Required properties:
    ...
        compatible: Has to contain one of the following:
    ...
        nxp,pca9505

Looking good so far:

    `CONFIG_GPIO_PCA953X_IRQ`
    Say yes here to enable the pca953x to be used as an interrupt
    controller. It requires the driver to be built in the kernel.

This doesn't mean that our pca9505 supports interrupts (has a separate
interrupt mask register which needs setting). Also pcal953x has a lot
more irq related registers.

MICROCHIP MCP23017 GPIO expander
--------------------------------

Use named GPIO lines:

    &i2c1 {
    	clock-frequency = <100000>;
    	pinctrl-names = "default";
    	pinctrl-0 = <&pinctrl_i2c1>;
    	status = "okay";

    	gpio_i2c: gpio@20 {
            	compatible = "microchip,mcp23017";
            	gpio-controller;
            	#gpio-cells = <2>;
            	reg = <0x20>;
    		ngpios = <14>;
    		gpio-line-names = "CAN1_TEN", "CAN1_TX_OFF", "CAN2_TEN","CAN2_TX_OFF",
    				  "CAN3_TEN","CAN3_TX_OFF","CAN4_TEN", "CAN4_TX_OFF",
    				  "SEL_SJA_CAN","","","","","","","";

    		pinctrl-names = "default";
    		pinctrl-0 = <&gpio20defaults>;

    		gpio20defaults: pinmux {
    			pins =	"gpio0";
    			output-low;
    		};
    	};

    };

GPIO leds for CAN error
-----------------------

Practical usage of GPIO led drivers:

    	leds {
    		compatible = "gpio-leds";

    		can1-err {
    			label = "can1-err";
    			gpios = <&gpio_i2c 9 GPIO_ACTIVE_LOW>;
    		};
    		can2-err {
    			label = "can2-err";
    			gpios = <&gpio_i2c 10 GPIO_ACTIVE_LOW>;
    		};
    		can3-err {
    			label = "can3-err";
    			gpios = <&gpio_i2c 11 GPIO_ACTIVE_LOW>;
    		};
    		can4-err {
    			label = "can4-err";
    			gpios = <&gpio_i2c 12 GPIO_ACTIVE_LOW>;
    		};
    		status {
    			label = "sw-err";
    			gpios = <&gpio_i2c 13 GPIO_ACTIVE_LOW>;
    		};
    	};

Setting gpios in `/etc/network/interfaces` (don't mind the pkill part):

    iface can1 inet manual
      pre-up gpioset --background --mode=signal $(gpiofind CAN1_TEN)=0
      pre-up ip link set can1 type can bitrate 500000
      pre-up echo 0 > /sys/class/leds/can1-err/brightness
      pre-up echo oneshot > /sys/class/leds/can1-err/trigger
      up ifconfig can1 up
      up (candump can1,0~0,#FFFFFFFF > /sys/class/leds/can1-err/shot ; \
            echo default-on > /sys/class/leds/can1-err/trigger) &
      down ifconfig can1 down
      post-down pkill -f "gpioset.*$(gpiofind CAN1_TEN)"
      auto can1

INFINEON SLB9670 TPM
--------------------

Keep in mind that attaching logic analyser probes to noisy Dupont cables
can lead to weird errors. Sometimes using a debugger can lead to more
problems. When in doubt make sure that you have proper wiring.

    &ecspi3 {
    	cs-gpios = <&gpio4 24 GPIO_ACTIVE_HIGH>;
    	pinctrl-names = "default";
    	pinctrl-0 = <&pinctrl_ecspi3>;
    	status = "okay";

    	tpm_tis@0 {
                    compatible = "infineon,slb9670";
    		reg = <0>;
                    spi-max-frequency = <10000000>;
    		vdd-supply = <&reg_tpm>;
            };
    };

  [Device tree]: #device-tree
  [INVENSENSE ICM20948 IMU (Inertial Measurement Unit)]: #invensense-icm20948-imu-inertial-measurement-unit
  [NXP SJA1000 and i.MX weim]: #nxp-sja1000-and-imx-weim
  [MCP2515 SPI CAN controller]: #mcp2515-spi-can-controller
  [NXP PCA9575 GPIO expander]: #nxp-pca9575-gpio-expander
  [MICROCHIP MCP23017 GPIO expander]: #microchip-mcp23017-gpio-expander
  [GPIO leds for CAN error]: #gpio-leds-for-can-error
  [INFINEON SLB9670 TPM]: #infineon-slb9670-tpm
