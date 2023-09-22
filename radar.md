My technology radar
===================

Here is where I track the technologies and techniques I work with. It is
inspired by [Embedded Artistry](https://embeddedartistry.com) which is
based on the original [Thoughtworks](https://www.thoughtworks.com/radar)
radar. It's a way of organising tools in categories and noting the
maturity or adoption level for each.

Though I use different categories: in addition to
observing technology trends, I wanted to highlight some aspects of
embedded software engineering that I find challenging in the focus areas
section.

1.  [Languages & Libraries](#Languages%20&%20Libraries)
2.  [Platforms](#platforms)
3.  [Tools](#tools)
4.  [Techniques & Focus areas](#Techniques%20&%20focus%20areas)

Instead of including the flashy Javascript radar, I decided to keep it
simple and use a text based approach. To further simplify it, I reduced
the assessment scale to the following:

- **Adopt**: This technology is proven, mature and can be used in most
  cases
- **Evaluate**: These tools are ready to use and have been tested to
  various extent, but not as mature as the adopted ones
- **Hold**: These are the industry standard tools which I rather not use
  or only in special circumstances

Languages & Libraries
---------------------

> 💡 This section contains programming languages, supporting libraries
> and occasionally complete software frameworks.

**Adopt**

- C
- C++
- Python
- Qt
- Catch
- Trompeloeil

**Evaluate**

- Rust

**Hold**

- WPE Webkit

Platforms
---------

> 💡 The platforms sections includes hardware platforms, bootloaders,
> operating systems and cloud providers.

**Adopt**

- NXP i.MX6
- STM32F3
- U-boot
- Linux
- FreeRTOS
- Azure IoT Hub
- Azure IoT Edge
- Azure Sphere
- AWS IoT Core

**Evaluate**

- NXP i.MX8
- 🔺 GD32 RISCV
- Nordic nRF5x
- Zephyr
- ELBE
- AWS IoT Greengrass

**Hold**

- 🔻 NXP i.MX8X
- NXP i.MX23

Tools
-----

> 💡 The tools section list supporting engineering tools:
> software/firmware build systems, sanitisers, formatters.

**Adopt**

- Yocto
- Buildroot
- FreeRTOS
- Make
- Clangd: clang-format, clang-tidy

**Evaluate**

- 🔺 ELBE
- Zephyr

Techniques & Focus areas
------------------------

> 💡 This section contains engineering techniques and some focus areas
> which I think requires special care in embedded software engineering.

**Adopt**

- Lifecycle management
	- Manufacturing: Factory floor configuration
	- Manufacturing: Cloud configuration
	- Provisioning: Server assignment(multi-tenancy, geo-sharding)
	- Maintenance: Firmware/Configuration/Application update
	- Deprovisioning
- Security
	- Hardware root of trust: TPM, Fuse, PUF
	- Defense: Read-only flash, isolated cores
	- Trusted computing: ARM Trustzone
	- Dynamic compartments: Processes, containers
	- Authentication: Certificates, tokens
	- Monitoring: Agent-based, agentless
	- Renew: Firmware update
- Network communication
- Distributed computing
	- Business drivers: Security, Availability, Cost, Bandwidth, Latency
	- Computing layers: Sensor, Edge, Fog, Cloud
	- Network communication:
		- Models: Device-to-cloud, cloud-to-device
		- Protocols: Application layer, Physical layer
		- Payload: Compression, serialisation


