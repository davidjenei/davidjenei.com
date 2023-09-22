Digital twin
============

In essence digital twin is the virtual representation of a physical
asset. This simply means creating virtual models that is the exact
counterpart (or twin) of a physical thing.

Motivation
----------

Most industrial contexts are a complex reality of assets connected in
various different ways.

- **Today**: Connected Assets (eRDM)
- **Emerging**: Connected Environments (chargers + vehicles)
- **Future**: Connected Ecosystems (Power plants + chargers + vehicles)

Goal
----

- Create software models to represent real world
- Query data from a physical space
- Detach models of physical assets from IoT devices
- Use the same data model throughout the whole system (data collection,
  processing, visualisation)
- Consistent programming model from the devices and the edge all the way
  to the cloud

Digital twin frameworks
-----------------------

- flexible modeling system, not a hard coded onthology (eg. specialised
  for smart buildings)
- graph topology

Modeling language
---------------

Use your own vocabulary and build your twin graph in the self-defined
terms of your business.

What is linked data?
--------------------

How we get computers understand relations between data?

Data format: web pages, images, videos, etc.

Easiest way: property-value mechanism

```
  name: 'John Lennon'
  birthday: '1995-01-01'
  mood: 'peaceful'
  spouse: "http://dbpedia.org/resource/Cynthia_Lennon"
```

JSON LD
-------

[JSON-LD] (JavaScript Object Notation for Linked Data) is a method of
encoding linked data using JSON.

> JSON-LD is a W3C recommendation: [Web of Things (WoT) Thing
> Description]

Azure Digital twin definition language
--------------------------------------

> The [Digital Twins Definition Language] (DTDL) is a language for
> describing models and interfaces for IoT digital twins. Using DTDL to
> describe any digital twin's abilities enables the IoT platform and IoT
> solutions to leverage the semantics of each digital twin.

```
  {
      "@id": “dtmi:example:Station;1",
      "@type": "Interface",
      "extends": “dtmi:example:Room;1",
      "contents": [
          {
              "@type": "Property",
              "name": “isOccupied",
              "schema": "boolean“
          },
          {
              "@type": “Property",
              "name": “hasAVSystem",
              "schema": “boolean“
          },
          {
              "@type": "Property",
              "name": “capacity",
              "schema": “integer“
          }
      ],
      "@context": "dtmi:dtdl:context;2"
  }
```

> Azure Digital Twins Definition Language conforms with the JSON and
> JSON-LD 1.1 specification

Example application: Azure IoT Central
--------------------------------------

Azure IoT Central is an IoT application platform for building
enterprise-grade IoT solutions.

Device capaility model = Interfaces + Device Identity + View + Cloud
properties

> **Digital twin != IoT device**: IoT devices implement interfaces that
> capture data from real world assets.
>
> **Digital twin identity != IoT device identity**: devices installed on
> fixed locations can observe several moving assets (eg. eRDM)

Example architecture
--------------------

![Bentley architecture]

Elements of a model
===================

Interface
---------

> An Interface describes the contents (Properties, Telemetries, Commands,
> Relationships, or Components) of any digital twin. Interfaces are
> reusable and can be reused as the schema for Components in another
> Interface.

    {
        "@id": "dtmi:com:example:Thermostat;1",
        "@type": "Interface",
        "displayName": "Thermostat",
        "contents": [
            {
                "@type": "Telemetry",
                "name": "temp",
                "schema": "double"
            },
            {
                "@type": "Property",
                "name": "setPointTemp",
                "writable": true,
                "schema": "double"
            }
        ],
        "@context": "dtmi:dtdl:context;2"
    }

Telemetry
---------

> Telemetry fields represent measurements or events, and are often used to
> describe device sensor readings. Telemetry is not stored on a digital
> twin; it is more like a stream of data events ready to be sent
> somewhere.

Example: sensor data batches sent every 5 minutes.

    {
        "@type": ["Telemetry", "Temperature"],
        "name": "temp",
        "schema": "double",
        "unit": "degreeCelsius"
    }

Property
--------

> Properties are data fields that represent the state of an entity (like
> the properties in many object-oriented programming languages). Unlike
> telemetry, which is a time-bound data event, properties have backing
> storage and can be read at any time.

> Example: Available capabilities and conditions. For example, the current
> device connectivity mode such as cellular or WiFi. Synchronizing
> long-running workflows, such as configuration and software updates.

    {
        "@type": "Property",
        "name": "setPointTemp",
        "schema": "double",
        "writable": true
    }

Command
-------

> A Command describes a function or operation that can be performed on any
> digital twin.

    {
        "@type": "Command",
        "name": "reboot",
        "request": {
            "name": "rebootTime",
            "displayName": "Reboot Time",
            "description": "Requested time to reboot the device.",
            "schema": "dateTime"
        },
        "response": {
            "name": "scheduledTime",
            "schema": "dateTime"
        }
    }

Relationship
------------

> Relationships let you represent how a digital twin can be involved with
> other digital twins. Relationships can represent different semantic
> meanings, such as contains ("floor contains room"), cools ("hvac cools
> room"), isBilledTo ("compressor is billed to user"), etc. Relationships
> allow the solution to provide a graph of interrelated entities.

    {
        "@type": "Relationship",
        "name": "floor",
        "minMultiplicity": 1,
        "maxMultiplicity": 1,
        "target": "dtmi:com:example:Floor;1"
    }

Sources
-------

- [IBM digital twin]
- [Azure digital twin]
- [Azure Digital Twins: Powering the Next Generation of IoT]

  [JSON-LD]: https://json-ld.org
  [Web of Things (WoT) Thing Description]: https://www.w3.org/TR/wot-thing-description/
  [Digital Twins Definition Language]: https://github.com/Azure/opendigitaltwins-dtdl/blob/master/DTDL/v2/dtdlv2.md
  [Bentley architecture]: https://eilabscom.sharepoint.com/sites/ENG/ISW/LINUX/Shared%20Documents/img/Screenshot%202020-06-17%20at%2010.21.37.png
  [IBM digital twin]: https://www.ibm.com/internet-of-things/trending/digital-twin
  [Azure digital twin]: https://azure.microsoft.com/en-us/services/digital-twins/
  [Azure Digital Twins: Powering the Next Generation of IoT]: https://www.youtube.com/watch?v=PM10Q9HDnTo
