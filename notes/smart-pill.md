title: Smart medication dispenser
description: ideas
tag: #embedded

Smart medication dispenser
==========================

The system is composed of three software components:

-   embedded software,
-   mobile application
-   web administration.

The goal of the plan is to create a working prototype:

-   implements core business logic - that is a topic TBD
-   not suitable for mass production

Some assumptions about the technical solution:

-   embedded Linux board and not MCU (fast sw prototyping)
-   off the shelf screen and wifi integration on development kit (can be
    time consuming)
-   cloud connectivity (avoid custom backend development)

Person month (PM): Mean amount of work performed by the average worker
in one month.

Hw
---

[devkit](https://www.st.com/en/evaluation-tools/stm32mp157f-dk2.html)

Embedded
--------

Work package 1 - Select parts, hardware bring-up

1.  Development kit setup + OS bring-up
2.  Touchscreen + Qt (GUI app) bring-up
3.  Wifi setup + Azure IoT connection
4.  Servo, infra, led connected on breadboard
5.  Speaker

1-2 PM (person month)

Work package 2 - Core functionality

1.  Design GUI screens
2.  Specifiy hardware interaction, sequence diagrams etc.
3.  Implement application flow
4.  Implement connected features

2-3 PM

Phase 3 - Extended functionality

1.  Wifi provisioning + App integration
2.  Revise application flow
3.  Customise graphics
4.  Testing

2-3 PM

Cloud
-----

Work package 1 - Off the shelf admin UI

1.  Azure IoT Central setup
2.  Design device - cloud messaging
3.  Create dashboard for simulated devices

0.5 - 1 PM

Work package 2 - Custom webapp

1.  ???

Mobile
------

Work package 1 - Core functionality

1.  Remote device control
2.  Screen design

2 PM

Work package 2 - Extended functionality

1.  Wifi provisioning
2.  Testing

1 PM

Notes
-----

total \~ 12 PM

Implementing a Wifi credential setup from the mobile app can be
complicated (requires custom solution depending on the phone OS
(android, ios) also on the embedded device needs switching wifi modes
(AP mode to client). This should be handled as a separate task, that can
be solved later.

Also assumed that an off-the-shelf web ui is suitable for the prototype.
A custom web app can be developed later independently.

  [Smart medication dispenser]: #smart-medication-dispenser
  [Embedded]: #embedded
  [Cloud]: #cloud
  [Mobile]: #mobile
  [Notes]: #notes
