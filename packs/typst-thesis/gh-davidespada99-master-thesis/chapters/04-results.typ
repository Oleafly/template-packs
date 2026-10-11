#pagebreak(to:"odd")
= Results <cap:results>


== Introduction <sec:introduction>
This chapter presents the experimental results of the framework developed during this work. As outlined in the introduction, the primary goal was to design and prototype an interoperability layer for heterogeneous IoT protocols in the agricultural domain, with particular emphasis on security, identity management, multi-tenancy and architectural constraints such as using open-source technologies and high availability. 
The implementation focused on building a reference architecture and validating the core operational flow rather than preparing a system ready for physical deployment. Due to the complexity of the security mechanisms and the time required to develop the full pipeline, the framework was treated as a case study to explore the feasibility of protocol bridging. As a result, physical deployment on hardware devices was not performed and quantitative performance metrics such as latency, throughput or battery consumption were not conducted. Such measurements would require further development of the current framework, which remains focused on proving the conceptual and functional design.
The experimental results presented here consist of functional tests conducted during development using Docker deployments. These tests validate that the services communicate correctly, that authentication and authorization flows work as intended and that the multi-protocol bridging logic operates as planned. Screenshots of running instances and corresponding log outputs are provided to demonstrate that the workflow functions as designed.

#pagebreak()

== MQTT Workflow <sec:mqtt-workflow>
=== JWT Bootstrapping <sec:jwt-bootstrapping>

The first step in the MQTT workflow is the automated bootstrap process through which each device obtains a JWT access token from Zitadel. @fig:jwt_bootstrap shows the logs from a device named `local-hub-001` during this initialization phase.
#v(1em)
#align(center)[
   #figure(image("../images/docker/jwt_bootstrap.png", width: 100%),
    caption: "JWT bootstrapping process")
    <fig:jwt_bootstrap>
]
#v(1em)

In this example, the device is a local hub which acts as a special device forwarding data on behalf of local sensors, as discussed in @sec:local_hub_design. Although it performs forwarding, it authenticates and behaves exactly like any other MQTT device in the architecture. Once the token is obtained, the device successfully connects to the MQTT broker and begins publishing telemetry data received by the sensors.

The process begins with the creation of a service user in Zitadel's internal database. As shown in the output, the service user is assigned a unique User ID (`365197819197259779`) and a corresponding Key ID. A private key is generated and stored locally by the device in JSON format at the specified path. This private key is used by the device to sign JWT assertions when requesting access tokens.
The bootstrap script then constructs a self-signed JWT assertion using the stored private key. This assertion serves as a cryptographic proof of identity and is presented to Zitadel as part of the OAuth 2.0 flow. Zitadel validates the signature using the public key it holds for the service user. If the assertion is valid, Zitadel issues an access token with a time-limited validity (in this case is set to 43199 seconds, approximately 12 hours).
The issued access token is printed to the logs under the label `access_token`. This token is then used by the device to authenticate subsequent MQTT connections. The device stores the token in memory and reuses it for all outgoing messages until expiration, at which point the token refresh logic is triggered.



=== MQTT pipeline <sec:mqtt-workflow>

@fig:mqtt-nats-flow illustrates the complete data pipeline from device layer to the persistence layer. The logs capture the interaction between multiple services as a message flows through the system: the MQTT-NATS bridge, the authentication service, the device and the NATS worker responsible for database writes.

#v(1em)
#align(center)[
    #figure(image("../images/docker/mqtt-nats-flow.png", width: 90%),
  caption: "MQTT workflow from device to database persistence layer"
) <fig:mqtt-nats-flow>
]
#v(1em)

The sequence begins with the `mqtt-nats-bridge` service establishing a connection to NATS. The bridge retrieves its signing key from Zitadel (identified by Key ID `347382488982880259`) and successfully authenticates using the JWT mechanism. It then connects to the VerneMQ broker and subscribes to the topic pattern `tenant/+/devices`, enabling it to forward all device telemetry to the corresponding NATS subjects. As discussed in @sec:nats_vernemq, both the bridges are special services that authenticate using JWT.
Next, the device `mqtt-device-001` connects to VerneMQ after obtaining its JWT access token through the bootstrap process described in @sec:jwt-bootstrapping. The device identifies itself with the client ID `mqtt-device-001` and the username `tenant_01-mqtt-device-001`, which encodes both tenant and device identity. Upon connection, the device publishes a telemetry message containing temperature data to the topic `tenant/tenant_01/devices`.
The publish operation triggers the `auth-service`, which validates the device's JWT and checks its authorization to publish on the requested topic. The service retrieves the signing key, verifies the token signature and confirms that the client ID matches the authenticated identity. Once authorization succeeds, the publish is allowed and the message is accepted by VerneMQ.

The `mqtt-nats-bridge` receives the MQTT message and forwards it to NATS under the subject `incoming.tenant_01.mqtt-device-001`. The message payload includes the device identifier, temperature reading, timestamp and tenant metadata. Finally, the `nats-worker` subscribes to the `incoming.*` subject pattern, retrieves the bridged message from NATS, and writes it to the PostgreSQL database as described in @sec:db_persistence.

Even if some steps in the flow are simplified, such as the topic structure, this end-to-end flow demonstrates that the authentication, authorization, protocol bridging and persistence mechanisms work correctly in sequence. Each service performs its designated role without errors and the telemetry data is delivered from the device to storage.

=== MQTT Bridging <sec:mqtt-bridging>
As we saw previously, the bridging service acts as the translation layer between the VerneMQ and NATS to ensure interoperability. The operational flow of this component is documented in the container execution logs, as shown in @fig:mqtt-nats-bridge. 
This shows the logs from the `mqtt-nats-bridge` service, responsible for subscribing to MQTT topics and forwarding messages to NATS, hence forwarding telemetry data from the device layer to the persistence layer. The opposite direction is not included here but behaves similarly.
The output confirms that the service initializes by successfully authenticating via JWT. Following a successful bootstrap phase, it establishes active connections to both NATS and the MQTT broker. The service then subscribes to the MQTT topics to retrieve incoming data from VerneMQ. As the logs demonstrate, the telemetry data is fetched and seamlessly published to NATS, with the topic string correctly translated into the expected dot-separated subject format.

#figure(
  image("../images/docker/mqtt-nats-bridge.png", width: 100%),
  caption: [System logs of the MQTT to NATS bridge illustrating successful JWT authentication and data translation.],
) <fig:mqtt-nats-bridge>

== Authentication Service <sec:auth-service>

=== Webhook Integration <sec:webhook-integration>

The authentication service acts as the authorization layer for VerneMQ, handling all access control decisions through a webhook integration. VerneMQ invokes HTTP endpoints on the auth service at specific points thus delegating authentication and authorization logic to this external component rather than implementing it internally, as described in @sec:vernemq.
@fig:auth-service-webhooks shows the set of webhooks exposed by the authentication service and the corresponding events that trigger them. 

#v(1em)
#align(center)[
    #figure(
  image("../images/docker/auth-service-webhooks1.png", width: 115%),
  caption: "Authentication service webhooks"
) <fig:auth-service-webhooks>
]
#v(1em)

The `auth_on_register` webhook is called whenever a client attempts to establish a new MQTT connection. The service validates the JWT access token provided in the connection credentials, verifies the token signature using the public key retrieved from Zitadel and checks that the client ID matches the identity encoded in the token. If validation succeeds, the connection is allowed. In the logs, we can see it by looking at the _Auth OK_ messages, corresponding to the successful authentication.

The `auth_on_publish` and `auth_on_subscribe` webhooks handle message authorization. When a device attempts to publish a message or subscribe to a topic, VerneMQ forwards the request to the auth service along with the client identity and the target topic. The service evaluates whether the client is permitted to perform the requested action based on the tenant context and topic structure. For example, a device can only publish to topics prefixed with its own tenant identifier.

Finally, the `on_client_offline` and `on_client_gone` webhooks are invoked when a client disconnects or is forcibly removed from the broker. These notifications allow the auth service to log session events or update client state.

This webhook approach decouples the broker logic from the authorization policy, making it easier to extend or modify access control rules without changing the VerneMQ configuration. All policy decisions are centralized in the auth service, which can integrate with external identity providers, audit logs or tenant management as required.

=== Zitadel <sec:zitadel>
In @fig:zitadel, we can see the dashboard of Zitadel showing the service users created correctly. In particular, the service users for the bridges service as described above and the local hub device, which is a special device that forwards data on behalf of local sensors, as discussed. Each service user has an associated key for JWT authentication, stored in Zitadel internal database, which is used by the respective component to authenticate with Zitadel and obtain access tokens.
#align(center)[
    #figure(
  image("../images/docker/zitadel.png", width: 100%),
  caption: [Zitadel dashboard showing the created service user and associated keys for JWT authentication.],
) <fig:zitadel>
]

=== Permify and Access Control <sec:permify>
To provide the access control layer, we first ensure the authorization engine is active. As illustrated in the logs for `iot-platform-permify-1` in @fig:permify-startup, Permify is initialized. In particular, the first four substantial log entries after service startup confirm that the authorization schema and corresponding relational tuples were loaded successfully, rendering the system ready to enforce policies.
#v(1em)
#align(center)[
    #figure(image("../images/docker/permify-write-and-check.png", width: 100%),
  caption: "Permify engine startup",
) <fig:permify-startup>
]
#v(1em)
To illustrate the access control mechanism in action, we can look at the logs from the local hub device `local-hub-001` as it attempts to publish telemetry data. 

We first examine a scenario where the publish request is intentionally denied to verify the authorization logic, as shown in @fig:local-hub-not-authorized. As we saw previously, the local hub acts as a standard device and authenticates using a JWT. The device connects through the Traefik load balancer, which we introduced in @sec:load_balancer. During the initial connection phase, the authentication service processes the `/auth-on-register` webhook and confirms the token validity with an _Auth OK_ response. When the device subsequently attempts to publish data, the `/auth-on-publish` webhook is invoked. Because the device permissions were manually configured to an invalid state in the Permify authorization engine for this test, the authentication service correctly evaluates the policy and returns a _Publish DENIED_ outcome.
In this example, the logs inform us that the local hub `local-hub-001`, which is forwarding data on behalf of the local sensors `mqtt-device-001`, does not have the necessary permissions since this device not belongs to its permission set.
#v(1em)
#align(center)[
    #figure(
  image("../images/docker/local_hub_device_not_authorized.png", width: 90%),
  caption: [Log output showing a denied publish request due to insufficient permissions in Permify.],
) <fig:local-hub-not-authorized>
]
#v(1em)

On the other hand, we can then observe the successful authorization flow in @fig:local-hub-authorized. After updating the local hub with the correct permissions in Permify, the device repeats the publish attempt. In this case, the authentication service successfully validates the action against the authorization engine and logs a _Publish OK_ response. The telemetry data is then successfully accepted by the broker.
#v(1em)
#figure(
  image("../images/docker/local_hub_device_not_authorized.png", width: 90%),
  caption: [Log output showing a successful publish request after assigning the correct permissions.],
) <fig:local-hub-authorized>
#v(1em)

== CoAP Workflow <sec:coap-workflow>

=== DTLS with PSK Handshake <sec:dtls-handshake>
To secure the communication between CoAP devices and backend services, we implemented DTLS using PSK, as described in detail in @sec:coap_auth. The server initialization process is shown in @fig:coap-server-dtls.

#v(1em)
#align(center)[
  #figure(
  image("../images/docker/coap-server-dtls.png", width: 100%),
  caption: "CoAP server initialization with DTLS-PSK handshake",
) <fig:coap-server-dtls>
]
#v(1em)
The CoAP bridge server connects to the NATS broker and initializes the PSK stores, used to retrieve pre-shared keys to authenticate incoming device connections. Once the stores are ready, the service starts listening for incoming DTLS traffic on port 5684. When a CoAP device attempts to connect, the server retrieves the corresponding PSK from the store based on the device identity and uses it to perform the DTLS handshake. If the handshake is successful, a secure channel is established for subsequent telemetry transmission. The logs confirm that the server is correctly configured and ready to accept connections.
#v(1em)
#align(center)[
#figure(image("../images/docker/coap-device-dtls.png", width: 100%),
  caption: "CoAP device initialization with DTLS-PSK handshake",
) <fig:coap-device-dtls>
]
#v(1em)
On the device side, the sensor initiates the handshake using its provisioned identity and key. As observed in @fig:coap-device-dtls, the device `coap-sensor-01` correctly configures the DTLS-PSK parameters and dials the endpoint through the proxy. The system verifies the credentials, and the device successfully completes the handshake, establishing a secure channel for subsequent telemetry transmission.

=== CoAP Communication Flow <sec:coap-communication-flow>
As we implemented, the CoAP server manages bidirectional communication by queuing messages for devices that might operate on sleep cycles. @fig:coap-server-message-flow illustrates this process, starting with the server receiving a command message from the backend intended for the sensor. Following the default behavior, the server saves this message in the database for future delivery.
#v(1em)
#align(center)[ 
#figure(
  image("../images/docker/coap-server-message-flow.png", width: 100%),
  caption: "CoAP server message flow",
) <fig:coap-server-message-flow>
]
#v(1em)

Subsequently, the device prepares a telemetry payload and sends it to the server. This transmission is securely encrypted using the ephemeral session key established during the DTLS handshake we saw in @sec:dtls-handshake. The server successfully receives this _CoAP POST_ request, authenticates the device, and processes the telemetry. 

During the processing of the _CoAP POST_ request, and before the device goes offline, the server checks the database for any pending commands associated with the device. Finding the previously saved command, the server constructs the acknowledgment response and inserts a notification to inform the device about the queued data. 

As shown in @fig:coap-device-message-flow, the device receives this acknowledgment and detects the notification. It immediately initiates a _GET_ request to the `/messages` endpoint on the server to retrieve the pending command. The device successfully processes the received payload and then polls the endpoint again. This polling loop repeats until the server confirms the message queue is empty. This exact sequence validates that the bidirectional communication logic functions correctly.

#v(1em)
#align(center)[ 
#figure(
  image("../images/docker/coap-device-message-flow.png", width: 93%),
  caption: "CoAP device message flow",
) <fig:coap-device-message-flow>
]
#v(1em)