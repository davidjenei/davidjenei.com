# az-220

## Implement the IoT solution infrastructure

### Create and configure an IoT Hub

* [ ] create an IoT Hub

> ! az extension add --name azure-iot
>
> az iot hub device-identity create --device-id simDevice --hub-name {YourIoTHubName}
>
> az iot device simulate -d simDevice -n {YourIoTHubNameacs

* [ ] register a device
* [ ] configure a device twin
* [ ] configure IoT Hub tier and scaling

> The free tier does not support upgrading to basic or standard.
>
> ! 4kb message size 
>
> 400k/day - 1.5GB - x200 unit available 1M /min
>
> 6M/day - 22.8GB - x200 unit available 16M /min
>
> 300M/day - 1114GB 800M /min

### Build device messaging and communication

* [ ] build messaging solutions by using SDKs (device and service)
* [ ] implement device-to-cloud communication
* [ ] implement cloud-to-device communication
* [ ] configure file upload for devices

### Configure physical IoT devices

* [ ] recommend an appropriate protocol based on device specifications

 Under current HTTPS guidelines, each device should poll for messages every 25 minutes or more.

MQTT and HTTPS support only a single device identity (device ID plus credentials) per TLS connection

! The standard AMQP protocol uses port 5671, and MQTT listens on port 8883. Use of these ports could cause problems in networks that are closed to non-HTTPS protocols. Use MQTT over WebSockets, AMQP over WebSockets, or HTTPS in this scenario.

Once you have created an IoT hub in an Azure region, the IoT hub keeps the same IP address for the lifetime of that IoT hub. However, if Microsoft moves the IoT hub to a different scale unit to maintain quality of service, then it is assigned a new IP address.

* [ ] configure device networking, topology, and connectivity

MQTT

IoT Hub limits the maximum server-side timeout to 29.45 minutes (1767 seconds) because all Azure services are bound to the Azure load balancer TCP idle timeout, which is 29.45 minutes.

IoT Hub's keep-alive ping interval is 1.5 times the client keep-alive value. 

C,C# SDK configurable keep-alive



>  Custom device and module authentication (token service): If you have existing device registry



X509

> A distinguishing attribute of the X.509 CA authentication is a one-to-many relationship a CA certificate has with its downstream devices. This relationship enables registration of any number of devices into IoT Hub by registering an X.509 CA certificate once, otherwise device unique certificates must be pre-registered for every device before a device can connect. This one-to-many relationship also simplifies device certificates life-cycle management operations.

> Purchase: 3rd party services integration otherwise self-signed
>
> Registartion: Proof of possession

## Provision and manage devices

### Implement the Device Provisioning Service (DPS)

* [ ] create a Device Provisioning Service
* [ ] create a new enrollment in DPS
* [ ] manage allocation policies by using Azure Functions
* [ ] link an IoT Hub to the DPS

### Manage the device lifecycle

* [ ] provision a device by using DPS
* [ ] deprovision an autoenrollment
* [ ] decommission (disenroll) a device

### Manage IoT devices by using IoT Hub

* [ ] manage devices list in the IoT Hub device registry
* [ ] modify device twin tags and properties
* [ ] trigger an action on a set of devices by using IoT Hub Jobs and Direct Methods
* [ ] set up Automatic Device Management of IoT devices at scale

### Build a solution by using IoT Central

* [ ] define a device type in Azure IoT Central
* [ ] configure rules and actions in Azure IoT Central
* [ ] define the operator view
* [ ] add and manage devices from IoT Central
* [ ] monitor devices

## Implement Edge

### Set up and deploy an IoT Edge device

* [ ] create a device identity in IoT Hub
* [ ] deploy a single IoT device to IoT Edge
* [ ] create a deployment for IoT Edge devices
* [ ] install container runtime on IoT devices
* [ ] define and implement deployment manifest
* [ ] update security daemon and runtime
* [ ] provision IoT Edge devices with DPS
* [ ] IoT Edge automatic deployments
* [ ] deploy on constrained devices
* [ ] secure IoT Edge solutions
* [ ] deploy production certificates

### Develop modules

* [ ] create and configure an Edge module

> Currently, modules can't receive cloud-to-device messages or use the file upload feature.
>
> No c2d message, only method

* [ ] deploy a module to an Edge device
* [ ] publish an IoT Edge module to an Azure Container Registry

### Configure an IoT Edge device

* [ ] select and deploy an appropriate gateway pattern
* [ ] implement Industrial IoT solutions with modules like Modbus and OPC
* [ ] implement module-to-module communication
* [ ] implement and configure offline support (including local storage)

## Process and manage data

### Configure routing in Azure IoT Hub

* [ ] implement message enrichment in IoT Hub

> enriching device telemetry messages with a device twin tag can reduce load on customers to
> make device twin API calls for this information.

> $iothubname
> $twin.tags.field

* [ ] configure routing of IoT Device messages to endpoints

> Event vs Message services
> Event Grid - React to status changes
> Event Hubs - Telemetry and distributed data streaming
> Service Bus - Order processing and financial transactions

> storage account, eventhub, service bus queue (single consumer), service bus topic (publish-subscribe)

> Paid SKU hubs may have 10 additional endpoints. Free SKU hubs may have one additional endpoint.

* [ ] define and test routing queries

> Paid SKU hubs may have 100 routing queries. Free SKU hubs may have five routing queries.

> Telemetry events, Device twin change events,

[Anomaly detection with Stream Analyitcs](https://docs.microsoft.com/en-us/learn/modules/data-anomaly-detection-using-azure-iot-hub/)

* [ ] integrate with Event Grid

> 10,000,000 events per second per region
> subject: devices/{deviceId}

> advanced filtering: key-value

### Configure stream processing

Stream Analytics guarantees exactly *once* event processing and *at-least-once* event delivery.

* [ ] create ASA for data and stream processing of IoT data

* [ ] process and filter IoT data by using Azure Functions

> Tumbling, hopping, sliding, 

* [ ] configure Stream Analytics outputs

### Configure an IoT solution for Time Series Insights (TSI)

* [ ] implement solutions to handle telemetry and time-stamped data
* [ ] create an Azure Time Series Insights (TSI) environment
* [ ] connect the IoT Hub and the Time Series Insights (TSI)

## Monitor, troubleshoot, and optimize IoT solutions

### Configure health monitoring

* [ ] configure metrics in IoT Hub

Archive to Azure Storage Account
Route to Eventhub
Store in Log Analytics Workspace

* [ ] set up diagnostics logs for Azure IoT Hub
  Snapshot vs Single point (v2 = moving to snapshot)

C2D Command/Message - expired, abandoned, rejected, delivery completed
C2D Method - failure, success, request size, response size
C2DeviceTwin - read/updates failed/successful
Configuration count - modify device twin counts (edge deployment, etc.)
Daily total data, count
D2C Telemetry - throttling, attempted, received
D2C Twin
Event Grid deliveries
Routing metrics - delivery attempts, latency, save to blob, route to blob, built-in endpoint latency, delivered to fallback route
telemetry message dropped, incompatible, orphaned (no fallback route)

Resource logs:
  connection events
  telemetry erros
  device identity operations
  Device-to-cloud twin operations
  cloud-to-device twin operations
  distribute tracing
    device to cloud log message (measure device to cloud latency, caller local time, callee local time
    egress log - write to endpoint
    ingress log - write to built-in endpoint (duration MS)

* [ ] query and visualize tracing by using Azure monitor

distributed tracing - only C sdk
needs correlation id across multiple Azure services

1. select where to log
2. select trace messages in diagnostic settings
3. enable tracing in C SDK
4. enable tracing per device
5. set sampling rate

// All distributed traces
AzureDiagnostics
| where Category == "DistributedTracing"
| project TimeGenerated, Category, OperationName, Level, CorrelationId, DurationMs, properties_s
| order by TimeGenerated asc

* [ ] use Azure Policy definitions for IoT Hub

### Troubleshoot device communication

* [ ] establish maintenance communication

Azure Monitor vs Event Grid

Monitor: metric alerts, thresholds etc.

* [ ] verify device telemetry is received by IoT Hub
* [ ] validate device twin properties, tags and direct methods
* [ ] troubleshoot device disconnects and connects

IoT Hub only supports one active MQTT connection per device. Any new MQTT connection on behalf of the same device ID causes IoT Hub to drop the existing connection.
400027 ConnectionForcefullyClosedOnNewConnection will be logged into IoT Hub Logs

### Perform end-to-end solution testing and diagnostics

* [ ] estimate the capacity required for each service in the solution
* [ ] conduct performance and stress testing
* [ ] set up device D2C message tracing by using Azure Distributed Tracing

## Implement security

### Implement device authentication in the IoT Hub

* [ ] [choose an appropriate form of authentication](https://docs.microsoft.com/en-us/azure/iot-dps/concepts-device-oem-security-practices?WT.mc_id=thomasmaurer-blog-thmaure)

* X.509 certificates: external vendors, price, lifecycle management

* TPM: difficult, can't rotate EK

* [ ] manage the X.509 certificates for a device
* [ ] manage the symmetric keys for a device

### Implement device security by using DPS

[Documentation](https://docs.microsoft.com/en-us/azure/iot-dps/)

* [ ] configure different attestation mechanisms with DPS
* [ ] generate and manage x.509 certificates for IoT Devices
* [ ] configure enrollment with x.509 certificates

> When a device connects to the provisioning service, the service prioritizes more specific enrollment entries over less specific enrollment entries. If there is no individual enrollment for the device and an enrollment group for the first intermediate certificate in the device's certificate chain exists, the service applies that entry, and so on, up the chain to the root.

> Upload Proof of posession: Sign a cert for a random common name.

* [ ] generate a TPM endorsements key for a device

[TPM provisioning process](https://www.youtube.com/watch?v=cSbDRNg72cU&feature=youtu.be&t=2460)

* [ ] configure enrollment with symmetric keys

### Implement Azure Security Center (ASC) for IoT

* [ ] enable ASC for IoT in Azure IoT Hub

Built-in mode vs enhanced mode (with agents)

Agents:

* C and C#
* Authentication: Device mode(CA signed not supported) and module mode(symmetric only)

* [ ] create security modules

process create/terminate, listenning ports, new connections

1. sudo apt-get install auditd audispd-plugins

2. edge deployment configuration

```
        "Privileged": true,
        "NetworkMode": "host",
        "PidMode": "host",
        "Binds": [
            "/:/host"
        ]
```

3. azureiotsecurity module twin identity
   ```  "ms_iotn:urn_azureiot_Security_SecurityAgentConfiguration" ```
   schema: https://github.com/Azure/Azure-IoT-Security/blob/master/security_module_twin/azureiotsecurity_schema.json

Validate! An agent will not launch if the configuration object does not match the schema.

4. set Edge Hub config (default)

5. set routes

"ASCForIoTRoute": "FROM /messages/modules/azureiotsecurity/* INTO $upstream"


* [ ] configure custom alerts
