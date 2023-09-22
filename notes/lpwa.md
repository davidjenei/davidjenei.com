Notes on LPWA network and development boards
============================================

Low-power wide-area network

LTE-M = includes eMTC (enhanced Machine Type Communication)
NB-Iot = narrow band
https://blog.onomondo.com/nb-iot-vs-lte-m-a-comparison-of-the-two-iot-technology-standards

Make sure to check what is implemented.
[Example](https://docs.iotcreators.com/docs/nb-iot-network-information)

LTE-M only: SMS, voice

> Voice is not implemented @DT

EU bands: 8-20-3

M2M SIM options
--------------

Default lifetime estimated for regular SIM cards is 2-5 years.

eSIM - 6x5mm or 2x1mm package

eUICC – a secure element that features one or more subscription profiles. eUICC
is compatible with eSIM and removable SIMs. In effect, each profile enables the
eUICC to function like a removable SIM.

eUICC platforms still have lock-ins.

nuSIM - SIM functions goes into the modem

Coverage Enhancement Level
-------------------------

Providing deep indoor coverage
NB-IOT 0-1-2, number of retransmissions, increase coupling loss
LTE-M A,B increase coupling loss

Power Saving Mode
-----------------

> Whilst it has always been possible for a device’s application to turn its radio
> module off to conserve battery power, the device would subsequently have to
> reattach to the network when the radio module was turned back on. The reattach
> procedure consumes a small amount of energy, but the cumulative energy
> consumption of reattaches can become significant over the lifetime of a device.
> Therefore, battery life could be extended if this procedure could be avoided.
>
> extended Long-Periodic Tracking Area Updates (Long-Periodic TAU)
> eg. in DT network between 1 hour and 310 hours - final value is determined by
> the network
> maximum in standard is 413 days
>
> The network retains the state information and the device remain registered
>
> Timers:
> * PSM Acitivity T3324 - during which the device remains idle, listening paging msgs
> * Long Periodic TAU T3412 - effectively sleep time
>
> [src](https://docs.iotcreators.com/docs/nb-iot-network-information)

Extended Discontinous Reception
-------------------------------

> Paging procedure - device listens to the network on regular intervals to check
> for incoming data
>
> Timers:
> * Paging Transmission Window (T PTW): Time during which the device performs the
> DRX procedure, which can accommodate between 4 and 16 paging reception slots.
> * eDRX Cycle (T eDRX): Time between the start of two consecutive PTW windows.
>
> Between those two times, the IoT device module or chipset enters a so-called
> “Sleep Mode” during which the receive path of the radio chipset is deactivated.
>
> eg. eDRX between 20,48s and 10485,76s (~175min)
> PTW between 2,56s and 40,96s
>
> [src](https://docs.iotcreators.com/docs/nb-iot-network-information)

Early Release Assistance Inicator
--------------------------------

> By activating the Early Release Indication, the IoT device is able to go
> straight into the Idle Mode after data transmission and/or reception, thus
> bypassing the `RRC_CONNECTED` state (which is typically 20-30 seconds long).
> Depending on the chipset solution being used, this means that up to 50mA of
> current may be saved by the IoT device.
>
> Send data to inform the network that no subsequent uplink or downlink data
> transmission is expected.
>
> [src](https://docs.iotcreators.com/docs/nb-iot-network-information)

Data Packet Buffering
--------------------
Depends on the visited network, eg. 10 packets of 1600 bytes.

No harm to networks
------------------
https://iotcreators.iotsolutionoptimizer.com/LoadDocument/1382/No%20Harm%20to%20Networks%20with%20Chordant%20oneM2M.pdf

Security features
----------------
https://www.gsma.com/iot/resources/security-features-of-ltem-nbiot/

NRF9160 (Nordic)
---------------
https://www.jaredwolff.com/store/nrf9160-feather/

Alternative: https://www.nordicsemi.com/Products/Development-hardware/Nordic-Thingy-91

Quectel BG96 (Qualcomm)
-----------------------
https://www.tekmodul.de/produkt/tuino-0-96/

Programming: https://github.com/Wiz-IO/platform-quectel/wiki/Framework-ThreadX

Sim7070G (Qualcomm)
------------------
https://www.waveshare.com/sim7070g-cat-m-nb-iot-gprs-hat.htm

Ublox Sara R4 + Atmel MCU
------------------------
https://shop.sodaq.com/sodaq-sara-sff-r410m.html

Quectel BC66 (Mediatek)
-----------------------
https://www.olimex.com/Products/IoT/NB-IoT/NB-IoT-DevKit/open-source-hardware
https://github.com/Wiz-IO/Arduino-MT2625-BC66

