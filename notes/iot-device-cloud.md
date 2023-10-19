tags: #embedded #iot

Device-cloud communication models
=================================

METHODS AND SCENARIOS
---------------------

- event messaging: alerts, events, time series telemetry
- file upload: raw, compressed measurement data
- device twin: set parameters, read conditions, long running commands
- direct method: perform immediate action, calibrate, reboot
- file download: firmware update
- streaming: bidirectional data stream, diagnostic console

TECHNICAL PARAMETERS
--------------------

- authentication method
- protocol
- size
- frequency
- qos, priority

COMMUNICATION PROTOCOLS
-----------------------

- HTTPS
- MQTT
- MQTT over WS
- AMQP
- AMQP over WS
- WS

PAYLOAD FORMAT
--------------

- JSON + JSON schema
- Protobuf, Flatbuf, Nanopb
- Avro, Thrift

COMPRESSION
-----------

- snappy
- deflate
- lzma
- bzip
- brotli

API DESCRIPTION
---------------

- HTTP: OpenAPI/Swagger
- AMQP, MQTT, WebSockets: AsyncAPI

DATA STORAGE
------------

- WARM path storage: relational database, document oriented database,
  time-series database, mem-cached database, graph database
- COLD path storage: data lake file format
- Hierarchy: BLOB storage: each entry in the storage doesn't conform to
  any particular model

DEVICE MODEL (DIGITAL TWIN)
---------------------------

### CAPABILITY MODEL

A *device capability model* describes the capabilities a device should
implement:

- telemetry and properties it reports
- cloud properties that aren't stored on the device
- commands that can be executed

An *interface* describes related capabilities that are implemented by a
device or digital twin. Interfaces are reusable and can be reused across
different capability models.

- *telemetry* describes the data emitted by a device or digital twin,
  whether the data is a regular stream of sensor readings or an
  occasional error or information message.
- *property* describes the read-only and read-write state of a device or
  digital twin. For example, a device serial number may be a read-only
  property and the temperature set point on a thermostat may be a
  read-write property.
- *command* describes a function or operation that can be performed on a
  device or digital twin.

### OTHER MODELS

- Anomaly detection models: ML Anomaly detection API format
- Physical environment models: Spatial intelligence graph

DEVICE EXECUTION MODEL
----------------------

- Real time operating system
- Preemptive multi tasking operating system

AUTHENTICATION
--------------

### ENCRYPTION

- symmetric
- asymmetric

### X.509

- no need to distribute the public keys when creating key pairs.
- can maintain a list of invalidated certificates

PROVISIONING
------------

- group enrollment: one root certificate, and any number of leaf
  certificates signed by this root

have many sensors configured to provide an identical format of telemetry
data

- group enrollment with intermediate certificates: organise devices into
  enrollment groups, sign with intermediate cert

device hierarchy: flexible access control and initial configuration
parameters

- individual enrollment
