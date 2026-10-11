#pagebreak(to:"odd")
#import "@preview/codelst:2.0.2": sourcecode
#import "../config/thesis-config.typ": config, mc

= Methodology <cap:methodology>

== Introduction <sec:introduction3>
In this chapter, we will describe the framework's architecture and design choices, implementation details and the evolution of the project through its development stages. All the choices were guided by the requirements outlined in the previous chapter. We will also describe the challenges encountered during development and how they were addressed. The chapter is structured to provide a comprehensive overview of the framework's construction, from high-level architectural decisions to low-level implementation details.

== Architectural requirements <sec:arch_requirements>
For completeness, we restate here the architectural requirements, as depicted in @fig:arch_requirements as they guided the design and implementation, with a deeper description.  \

*Multi-tenancy and Data Isolation*: A tenant is a logically isolated organizational unit that shares the same infrastructure but operates independently from others. In this context, each tenant represent a different company, with its own devices, users and data streams. Isolation must be enforced at every layer: device authentication, message routing, data storage and access control, ensuring that no tenant can access another's resources. This requirement directly influences the choice and implementation of every service in the stack and the technical communication specifications.

#align()[
   #figure(image("../images/requirements.png", width: 24em),
    caption: "Architectural requirements")
    <fig:arch_requirements>
]
#v(1em)

*Open Source*: All components must be based on open-source technologies. Beyond promoting transparency and avoiding vendor lock-in, this requirement is practically motivated by the nature of the project itself: being a thesis internship without dedicated funding, commercial licensing costs are not an option. Open-source solutions also tend to have greater community support and better long-term and low-cost maintainability.

*High Availability*: HA refers to the ability of a system to remain operational even when the failure of an individual service happens. In production environments, HA is achieved through redundancy: multiple instances of a service running concurrently as a single unit so that if one fails, others can take over without interruption. This is also a security requirement, as availability is one of the CIA principles. In practice, this means that services must support clustering or horizontal scaling, which directly conditions technology selection.

*Identity and Access Management*: IAM refers to the set of policies and mechanisms that govern who can access what within a system. In a multi-tenant IoT platform, this involves managing three distinct classes of identities: human users such as administrators, operators or maintainers, each with different permission levels; IoT devices, which must be authenticated before being allowed to publish or consume data; and internal backend services, which must authenticate with each other to prevent unauthorized access to internal APIs. IAM must therefore be handled by a service that supports user management with role-based access control, machine identity management and the issuance of service accounts and short-lived tokens for internal communication.

*Interoperability*: The architecture must support heterogeneous application protocols that coexist and cooperate together, and must be designed with extensibility. This means adding support for a new IoT protocol or a custom user-defined protocol should require low effort and no structural changes to the existing system. MQTT and CoAP devices must interact with the rest of the system without upper layers being aware of the underlying protocol differences. The integration layer must abstract away protocol-specific details, translating between different communication paradigms while preserving message semantics and delivery guarantees. From the perspective of backend services and end users, a CoAP sensor and an MQTT sensor should appear equivalent, differing only in their data, not in how they are handled.

*Authentication and Authorization.* All entities interacting with the system must be properly authenticated and authorized. Authentication ensures that each entity is who it claims to be, while authorization governs what it is permitted to do.
Human users rely on standard credential-based flows and role-based access control. All non-human entities (both IoT devices and internal backend services) fall under the broader M2M authentication model. In all the cases, every interaction remains subject to appropriate authentication mechanisms tailored to the specific class of entity and all actions are subject to authorization policies, ensuring that no entity can act beyond its defined scope. 

== Architectural overview <sec:arch_overview>
The whole architecture can be broken into three main components or layers: 
+ the device layer;
+ the cloud infrastructure layer;
+ the end user layer.
@fig:arch_overview depicts the high-level architecture and how these layers interact with each other.
#v(1.5em)
#align()[
   #figure(image("../images/schemas/arch_overview.png", width: 40em),
    caption: "Architectural requirements")
    <fig:arch_overview>
]
\ 

The device layer corresponds to the perception layer of the IoT stack (@sec:perception_layer) and is composed of the physical devices, that collect data from the environment or perform specific actions. These devices are heterogeneous and could be produced by different manufacturers, hence using different communication protocols. Also, we need to consider custom and proprietary devices or protocols, which are common in industrial environments. For this reason, the architecture must be designed to be extensible and support multiple protocols, with a focus on MQTT and CoAP.
Devices can be classified into two categories: 
- _sensors_: which collect telemetry data from the environment and publish it to the cloud infrastructure.
- _actuators_: which receive commands from the cloud infrastructure (e.g., user commands, automated trigger or a command directly coming from a sensor) to perform specific actions in the environment.
\

The cloud infrastructure layer corresponds to the middleware layer of the IoT stack (@sec:middleware_layer) and is responsible for managing the incoming data from devices, authenticate and authorize requests, processing it and making it available for end users. This layer includes in particular: _message brokers_ that handle the communication with devices, protocol translation and data routing; _databases_ that store and manage data for visualization, analysis and subsequent actions; _authentication and authorization services_ that ensure only authorized users and devices can access the system. As we wil see, the system is much more complex than this simplified description, especially considering the interoperability requirement.
\ \

The end user layer corresponds to the application layer of the IoT stack (@sec:application_layer) and includes the interfaces and applications that allow users to interact with the system, such as dashboards, APIs and control panels. This layer provides the means for users to visualize data, configure devices (e.g., setting thresholds for alerts or sending commands to actuators) and manage their accounts and permissions. This layer must consider the different types of users and their needs, ensuring that the system is able to assign to each user the appropriate level of access and functionality based on their role, that determines what they can see and do within the system. 
At the implementation level, for this layer we only designed and considered roles, permissions and the corresponding APIs, without implementing a UI, as the focus of the project is on the backend infrastructure that manages the devices and data. However, the architecture is designed to be extensible, so that a UI can be added in the future without requiring deep structural changes.


== Use Case Scenario: Smart Agriculture <sec:use_case_agriculture>

=== Motivation <sec:use_case_motivation>
After defining the architectural requirements and providing a high-level structure of how the system should be implemented, we will now describe a concrete use case scenario. This is necessary to guide the design and implementation of the framework, as it provides a practical context in which to apply the architectural principles and requirements outlined above and that influence important design choices. 
As we mentioned in the introduction (@sec:problem_statement), a general purpose solution that attempts to consider every possible scenario, while theoretically feasible, introduces a level of complexity that is difficult to justify in practice. The cost of designing, testing and maintaining such a system grows exponentially as the number of supported configurations increases. Introducing a universal cloud infrastructure layer would require accounting for an immense variety of edge cases, packet formats, timing constraints and so on. \ 

This is also true when security is taken into account: each additional use case brings its own set of actors, roles, permissions and threat models, which must all be accounted for and validated. When the system already has to bridge the gap between two protocols with opposite  communication paradigms, adding an unbounded set of contextual assumptions it increase the workload and multiplies the number of possible interactions and failure modes. For this reason, bounding the design to a concrete and defined scenario allows us to make reasonable choices, without sacrificing the clarity or the correctness of the system. 
\ \ 

=== Scenario Description <sec:use_case_description>

The use case scenario we designed falls within the domain of smart agriculture, which is gaining increasing attention as a promising application of IoT technologies. In particular, we focus on smart greenhouses, which are controlled environments that optimize plant growth by regulating factors such as temperature, humidity, light and soil moisture. For these reasons, greenhouse may be compared to a chemical laboratory, where different resources are controlled and monitored to achieve a specific outcome. This makes them an ideal context for an IoT framework to optimize crop yields. However, the framework is designed to be extensible and can be adapted also to open field agriculture. \
#v(1em)
#align(center)[
   #figure(image("../images/smart-greenhouse.png", width: 36em),
    caption: "Smart greenhouse use case scenario example")
    <fig:smart_greenhouse>
]
#v(1em)

In this scenario, as depicted in @fig:smart_greenhouse, we can see an example of a greenhouse equipped with a variety of sensors and actuators that monitor and control the environment. 

- *Thermal control.* Temperature and humidity sensors are distributed across the greenhouse in specific zones, tracking ambient conditions and transmitting readings. The cloud servers may calculate average values or apply specific logic through a series of telemetry readings, to analyze trends or detect anomalies and trigger alerts to operators. For example, if temperature exceeds acceptable limits, commands are sent to controllers to activate air conditioning or ventilation fans in the affected zones, with actions logged and displayed on the dashboard.

- *Irrigation.* Soil moisture sensors measure water content in the soil, providing data that informs irrigation decisions. Rather than watering on a fixed schedule, the system can trigger irrigation only when needed, reducing water waste and preventing over watering or drought stress. Automated valves or pumps connected as actuators enable precise control over water delivery.

- *Light and shading.* Light intensity sensors measure illumination levels and trigger automated responses: closing shading curtains when light is excessive or activating LED lights when necessary. The dashboard may displays real-time status and historical trends to optimize light exposure.

- *pH and nutrient monitoring.* pH and electrical conductivity sensors monitor substrate solution chemistry. When values deviate from optimal ranges, dosing pumps automatically add base solutions or nutrients, with all corrections logged and displayed graphically.

- *Local gateway.* Data collection and command distribution are mediated by a local gateway situated within the greenhouse. This gateway serves as a bridge between the edge devices (sensors and actuators) and the cloud infrastructure, aggregating telemetry data from sensors and forwarding it to the central platform for storage and processing, while simultaneously receiving commands from the cloud and forwarding them to the appropriate actuators. In this initial abstraction, the local gateway is considered primarily as a data transit point. A detailed discussion is done in Section X, as its role has important implications on the communication. \ \

This form a comprehensive monitoring and control infrastructure. It is important to note that, being situated in an agricultural context rather than a critical industrial environment or a life-critical application, the system tolerates moderate delays and inaccuracies. Environmental parameters change gradually, and while certain operations (such as irrigation or dosing pumps require timely responses) failures or delays do not result in catastrophic consequences. This allows for low to moderate data transmission frequencies (in order of seconds or minutes) and provides some margin for error. Hence, the computational and network load remains manageable. 

=== Hierarchical Zoning and Topic Structure <sec:hierarchical_zoning>

The physical organization of the greenhouse and the deployment of devices directly influence the design of the communication infrastructure, particularly the topic structure used to distinguish between different devices and data streams. This reinforces the concept introduced earlier: defining a precise use case scenario is essential because it conditions the entire communication architecture
The decision to adopt a topic-based communication paradigm, rather than a traditional RESTful approach, is motivated by various factors. Topic-based messaging accommodates a wide variety of devices and data types while providing a flexible and horizontally scalable structure. It enables efficient routing and filtering of messages based on semantic content, simplifies audit logging and traceability, and supports multi-tenant environments where different organizations have distinct data streams and access requirements.
This design choice is further justified by the need to support both MQTT and CoAP devices, which operate on fundamentally different paradigms: MQTT is inherently topic-based, while CoAP is resource-based. By designing a topic structure, the system achieves interoperability. The topic structure serves as a unifying abstraction that bridges the gap between these protocols, allowing them to coexist and interact seamlessly without requiring significant changes to the underlying communication mechanisms.

==== Design and Evolution <sec:hierarchical_zoning_design>
In the system we designed, because of the multi-tenancy requirement, the topic structure must include a field for the tenant ID, to ensure logical isolation between different organizations. Each tenant may have multiple sites, which can be either greenhouses or open fields, and each site is identified by a unique site ID. Within each site, there are sections and zones that further subdivide the physical space, allowing for more granular organization and management of devices. Each device is categorized by its type (e.g., sensor or actuator) and subclass (e.g., temperature sensor, irrigation pump), with a unique identifier for each individual device. Finally, the message type field distinguishes between different types of messages (telemetry, command, state, alert, config) and the target ID field specifies the intended recipient of commands or configuration messages. 
\ \ 

During the design process, topic structure evolved from a 9 to a 10 level hierarchy. This modification was necessary to address two critical requirements that emerged during implementation: the need to explicitly specify the target device when sending commands, and authentication constraints that emerged and will be discussed in detail in the following sections .
The initial 9-level structure was sufficient for telemetry flows, where sensors publish data about themselves without needing to address other entities. However, when devices or local hub (which, as we will see, act as devices themselves in certain scenarios) need to send `command` messages to actuators, the topic must explicitly identify the target recipient. Without a dedicated field for the target device ID, the system would have no way to determine which actuator should execute the command, particularly in zones where multiple actuators of the same type may be present.

The final 10-level topic hierarchy is structured as follows in @tab:topic_hierarchy:

#v(1em)
#figure(
  table(
    columns: (auto, auto, 1fr, auto),
    align: (center, left, left, left),
    stroke: 0.5pt,
    inset: 5pt,
    [*Level*], [*Field*], [*Description*], [*Example*],
    [1], [`tenant_id`], [Logical isolation between organizations], [`agroTech01`],
    [2], [`site_type`], [Type of agricultural facility], [`greenhouse`, `open field`],
    [3], [`site_id`], [Physical site identifier], [`GH-001`],
    [4], [`section_id`], [Section within the site], [`section-2`],
    [5], [`zone_id`], [Operational zone], [`zone-A`],
    [6], [`entity_type`], [Device category], [`sensor`, `actuator`],
    [7], [`entity_subclass`], [Specific device type], [`temp`, `ph`, `water pump`],
    [8], [`entity_id`], [Unique device identifier], [`mqtt-device-03`],
    [9], [`message_type`], [Message classification], [`data`, `cmd`, `status`, `alert`],
    [10], [`target_id`], [Target device for commands (optional)], [`cooler-001`],
  ),
  caption: [10-level topic hierarchy structure]
) <tab:topic_hierarchy>
#v(1em)


For example, a temperature sensor publishing telemetry would use:
```
agroTech01/greenhouse/GH-001/section-2/zone-A/sensor/temp/mqtt-device-03/telemetry/
```

While a gateway sending a command to activate a cooling system would use:
```
agroTech01/greenhouse/GH-001/section-2/zone-A/actuator/cooler/gateway-01/command/cooler-001
```

This structure ensures that commands are unambiguously addressed, authorization policies can be enforced based on the sender-target relationship and the topic itself carries sufficient semantic information for routing and filtering at every layer of the architecture.


=== MQTT vs CoAP Deployment Scenario <sec:mqtt_vs_coap_deployment>
In agricultural IoT deployments, the selection between MQTT and CoAP is primarily dictated by the specific environmental constraints and the reliability of the available network infrastructure. Within a greenhouse setting, where devices typically operate under stable connectivity and consistent power supplies, MQTT is often the preferred communication protocol. By utilizing persistent TCP connections, MQTT ensures low-latency transmission and reliable data delivery, which is essential for the real-time telemetry required in controlled environments. Conversely, in open-field agriculture where sensors are often battery-powered and distributed across vast areas with intermittent network access, CoAP provides a more efficient alternative. Based on the UDP transport layer and a request-response architecture, CoAP significantly reduces the energy overhead associated with connection management, allowing highly constrained devices to maximize their battery life, even for several month without any manual intervention, while operating in lossless environments.

== Authentication and Authorization Services <sec:authz>
Beyond the general architectural decisions and the specific use case scenario, among the first design choices we had to make was selecting the appropriate authentication and authorization services. The IAM service must support both user and machine identity management and ensure that only authorized users and devices can access the system.
A study on authentication and authorization methods for MQTT and CoAP was conducted, as described in @sec:security_solutions_iot, to evaluate the available options and select the most suitable solution that we hope to implement in the future.

For MQTT, we chose to secure the transport layer with TLS rather than relying on X.509 client certificates, primarily because mutual authentication with certificates introduces computational overhead that increases battery consumption. For authentication, we selected JWT tokens, given their wide adoption, high security properties and compatibility with limited devices. JWTs also support custom claims, which allows the broker to enforce permission control directly from the token payload.

For CoAP, our initial choice was to use CWT tokens, motivated by their structural similarity to JWTs and the expectation that this would simplify interoperability at the broker side. However, we found that CWT, despite being designed for constrained environments, was not the best solution in our scenario: the ecosystem support is still limited, the tooling is less mature and the effort required to integrate CWT issuance and validation would have been comparable to a heavier solution. In particular, the _Zitadel_ service we chose do not support CWT token for machine users. However, as we will see in @sec:coap_implementation, this turned out to be not the best solution, leading us to adopt a different authentication mechanism for CoAP devices. We therefore moved to DTLS with PSK, which provides a secure and encrypted communication channel while remaining lightweight. This approach also handles device identification implicitly through the key identity, removing the need for a separate token layer at the transport level.

=== Zitadel <sec:zitadel>
As already discussed in @sec:authentication_service, among the different authentication services available, based on the architectural requirements and goals of the project, we chose to implement _Zitadel_ service. The decision was driven by the need to support JWT authentication for MQTT devices, as it was the first protocol we decided to implement, and the fact that it provides native support for JWT issuance and validation, which simplifies integration with the MQTT broker. _Zitadel_ also supports a wide range of authentication methods for human users, including password-based authentication, MFA and social login options, making it a versatile choice for managing user identities in a multi-tenant environment.

While not directly supporting CWT tokens for machine users, it was still essential to manage user identities for the overall system, providing a solid and dedicated IAM service. At this point, is clear that finding a unified solution for both protocols is challenging, especially under the constraints of the project, we need to make trade-offs and adapt our choices.

==== Deployment and Configuration <sec:zitadel_deployment>

Zitadel was implemented using its official Docker image, without any modifications to the
base image itself. All configuration varua is supplied through environment variables at container
startup, following the recommended approach for containerized deployments.

On first startup, Zitadel initializes its own database schema on a PostgreSQL instance and
bootstraps a default organization and administrator account, whose credentials are injected
via environment variables. A machine user acting as a login client is also provisioned
automatically, along with a Personal Access Token (PAT) that is written to a shared volume
and consumed by other services that need to interact with the Zitadel API.

The instance is configured to use the v2 login interface, a recent implementation of
the authentication flow. The relevant OIDC, SAML and logout URLs are set explicitly to
point to this interface, which is served on a dedicated port alongside the main Zitadel
backend. For the purposes of the project, we disabled TLS since we were running the service locally, as the infrastructure is intended for local development and testing. In a
production environment, TLS termination and a proper external domain would need to be
configured.

#text(fill: rgb("#d60d0d"))[In the following sections, we will see how Zitadel is integrated with the rest of the system, particularly with the MQTT broker and the authorization service.]

=== Permify <sec:permify>
Regarding authorization, we had to define first the roles and permissions model for both
human users and devices for this scenario. The proposed system adopts a multi-tenant
hierarchical architecture in which a single _Super-Admin_ oversees the entire platform
and is responsible for provisioning and managing tenants and their respective
administrators. The Super-Admin can create and delete tenants and manage tenant
administrators, but has no direct access to tenant data, ensuring strict isolation
between organizations.

#align(center)[
    #figure(image("../images/schemas/tenants.png", width: 39em),
      caption: "Authorization schema")
      <fig:authorization_schema>
]
#v(0.5em)
\

Each tenant is governed by an _Admin_, who holds full read, write and edit
privileges within their own tenant. The admin can create and modify the organizational
structure (macro sections, sections, devices and groups), assign roles to other users,
read data from all devices in the tenant, and send commands to any of them.
Inside each tenant, the physical and logical structure is organized into three levels.
At the top there is _Macro Sections_, which represent broad areas of the deployment (such as
a vineyard, a greenhouse or an irrigation zone). Each macro section contains one or
more _Sections_, which represent the finest level of operational control, where devices
are directly managed. Devices can be collected into _Device Groups_, which are logical
containers that allow permissions and configurations to be applied uniformly to a set
of sensors or actuators belonging to the same section.

Users are classified into roles with different scopes and privileges. A _Supervisor_ is
responsible for a single macro section and all the sections it contains: they can read
device data, send commands, and manage alerts at that level. An _Operator_ is scoped to
a single section and can read data and send commands within it, but cannot modify the
structure or assign roles. A _Maintainer_ is scoped to the entire tenant and holds, ideally, privileges equivalent to those of the tenant admin, but only for a limited period of time, typically during a maintenance window.
Users and devices can be managed individually or organized into groups. User groups allow
a set of users to be assigned a role collectively, so that any member of the group
inherits the corresponding permissions automatically. This reduces configuration overhead as as the number of users and resources grows.
This relational model is depicted as an example in @fig:authorization_schema.

\ 

Given that permissions, especially those assigned to users, are subject to change over time, the system must support dynamic access control policies. ABAC was discarded, as it requires defining and maintaining a large number of attributes for each entity and make the system quickly unmanageable as it scales. RBAC, while more practical, proved insufficiently flexible to address the complex and evolving permission requirements of a multi-tenant architecture, particularly given the hierarchical nature of the resources involved.
These considerations led to the adoption of ReBAC, a model that enables fine-grained and dynamic permission management by expressing access rights in terms of relationships between entities. As discussed in @sec:authorization_service, the chosen solution is _Permify_, an open-source ReBAC service.

==== Schema Design, Implementation and Evolution <sec:permify_design>

The authorization _schema_ designed for Permify reflects the hierarchical structure of the
platform. At the top level, a `platform` entity holds `super_admin` relations, granting
the ability to manage tenants without direct access to their data. Each `tenant` entity
defines three roles, `admin`, `maintainer`, and `member`,  which can be assigned either
to individual users or to user groups, so that permissions are inherited by all group members.
Below the tenant level, the hierarchy continues through `macro_section` and `section`
entities, each inheriting and refining permissions from the level above. For example, an
operator assigned to a section can issue commands to devices within it, while a plain
member can only read data. Access rights are expressed as relations between entities and
are evaluated by traversing the relationship graph at query time. In @code:permify_schema_example (#link(<sec:appendix_a>, "Appendix A")), we put a simplified version of the authorization schema designed, which captures the main entities, relations and permissions. The actual implementation is more complex, with additional entities for user and device groups and specific rules for device capabilities, but this example illustrates the core structure and logic of the authorization model.

Devices are represented by a `device` entity that carries three key relations: `section`, which places it within the hierarchy, `type`, which points to a `device_type` that defines the capabilities, and hence the permissions,  of that class and `controllers`, which defines which member in the tenant is allowed to control that device. 


#figure(
  image("../images/permify_schema.png", width: 15em),
  caption: [Example of a simplified Permify authorization schema],
) <fig:permify_schema>
#v(1em)
@fig:permify_schema shows a simplified representation of an authorization schema as visualized by the Permify Playground. The graph illustrates the core concepts of the model: the `platform` entity at the top, connected to `super_admin` users through a relation that grants the `manage_tenants` permission. Each `tenant` defines `admin` and `member`, whose composition drives the computed permissions `is_admin`, `is_member`, `manage_devices` and `view_devices`. The `device` entity then inherits
these permissions by following its relation to the tenant, while also allowing a direct `controller` relation for device assignment. Note that this schema is intentionally minimal and we put it here only to illustrate the general structure of how relational model works. The actual schema used in the system is considerably more complex, using additional entity types, a deeper organizational hierarchy and a greater set of permissions and relations.

\ 

The data model in Permify is based on the _tuple_, written as a triple following the schema structure of the form `(entity, relation, subject)` that records a single relationship in the system. For instance, the fact that `john_doe` is an admin of `tenant:agroTech01` is stored as the tuple shown in @code:permify_tuple.
#figure(
  sourcecode(
  ```json
    { 
      "entity": { "type": "tenant", "id": "agroTech01" },
      "relation": "admin",
      "subject": { "type": "user", "id": "john_doe" }
    }
  ``` 
), caption: "Example of a Permify tuple"
) <code:permify_tuple>

Permission checks are resolved by traversing the graph of tuples starting from the queried entity, combining relations and  permissions according to the schema. When a service needs to verify permissions, it constructs a permission check request and sends it to Permify via an HTTP POST request. The request specifies the entity being accessed (such as an actuator device), the permission being requested (such as publish or subscribe) and the subject attempting the action (such as a sensor device making the request). In @code:permify_check_request_example there is an example of the core structure of a permission check request, very similar to the tuple structure, but with the `permission` field that specifies the permission being checked.



The Permify  endpoint evaluates it by querying its internal tuple database and responds with `CHECK_RESULT_ALLOWED` or `CHECK_RESULT_DENIED`, indicating whether the requested action should be permitted.
\ \

During the design phase, device capabilities were initially modeled as relations on the `device_type` entity. This meant that each individual device had to be linked to its type for every capability it was allowed to use. To illustrate the problem, consider a fleet of 100 sensors, each requiring six capabilities (such as publishing data, subscribing to commands or issuing commands). In this initial design, the system would need to store 600 separate relationships, six for each device. As the fleet grew to hundreds or thousands of devices, the number of stored relationships became unmanageable. Moreover, debugging became impractical, as determining the cause required scanning through hundreds of relationships.

To address this issue, the capability model was revised to use _attributes_ instead of relations, since Permify also supports ABAC permissions. In the updated schema, each `device_type` entity carries a set of boolean attributes, such as `can_pub_data` or `can_sub_cmd`, that define what devices of that type are allowed to do. Individual devices then inherit these capabilities simply by being associated with their type. Returning to the example, instead of storing 600 relationships, the system now stores only one attribute definition for a sensor type plus 100 device type assignments, reducing the total from 600 to 101 entries. When a new sensor is registered, it only needs to be linked to its type, and all capabilities are automatically inherited. This redesign improved both the maintainability and the clarity of the authorization model.
== Multi-Tenancy and Data Isolation <sec:multi-tenancy>
To achieve multi-tenancy and data isolation, a requirement described in @sec:arch_requirements, the architecture must ensure that each tenant's data and resources are separated and protected from unauthorized access by other tenants. There are three primary strategies for implementing tenant isolation:

- _Logical isolation_: relies on software level mechanisms to separate tenant data within shared infrastructure. All tenants use the same service instances, database, and message brokers, but separation is achieved through access control policies, tenant identifiers embedded in data structures such as the topics and authorization checks. This approach maximizes resource utilization and minimizes operational overhead and costs, as a single infrastructure serves all tenants.

- _Physical isolation_: provisions separate infrastructure for each tenant, including dedicated service instances, databases and message brokers. Each tenant operates in a completely isolated environment with no shared resources. While this provides the strongest security guarantees and eliminates the risk of data leakage among tenants, it significantly increases infrastructure costs, complexity and resource consumption, as each tenant requires a full deployment of the entire stack.

- _Hybrid isolation_: combines both approaches by physically separating critical components, such as databases containing sensitive data, while logically isolating less critical services, such as message brokers or gateways, which are shared across tenants with strict access control. This strategy balances security and cost, dedicating resources where isolation is most critical while sharing infrastructure where logical separation is sufficient.
\

For this project, we chose to implement logical isolation for the following reasons. 
First, the scope and constraints of the project make physical isolation impractical, as it would require deploying separate instances of all services for each tenant, significantly increasing infrastructure complexity and resource requirements beyond the available time and budget. Second, physical isolation incurs substantially higher costs in terms of maintenance, monitoring and scalability, as each tenant would need independent updates, backups and capacity planning. Third, physical isolation is usually applied in scenarios with very strict security, such as life-critical applications, financial systems or highly sensitive data handling. Logical isolation, when properly implemented with robust authentication, authorization and data partitioning mechanisms, provides sufficient security and isolation for multi-tenant IoT platforms, making it the most pragmatic and cost-effective choice for this work.

Moreover, during the design and implementation process, we decided not to use the built in multi-tenancy features of the services we chose. Instead, we implemented multi-tenancy at the application level, by embedding tenant identifiers in the topic structure, as described above, and enforcing access control policies based on these identifiers using the _Permify_ service. This approach, while requiring more custom development and seeming counterintuitive at first, provides greater flexibility and control over the multi-tenancy implementation, allowing us to tailor the isolation mechanisms. Also, if in the future we decide to switch to a different service that does not support multi-tenancy natively, we can easily adapt the existing implementation without needing to redesign the entire system.

== MQTT implementation <sec:mqtt_implementation>
For the implementation of the communication we decided to start with MQTT, as it is the most widely adopted protocol in the IoT domain and is particularly well-suited for the greenhouse use case scenario. Moreover, we chose to develop initially the MQTT communication from the device layer to the cloud infrastructure, to provide a solid foundation for the communication architecture and later extend it to support CoAP devices. From a first analysis, MQTT is more simple to implement, as it relies on a wide range of mature open-source brokers and client libraries.

In this section, we will discuss the design and implementation choices made to allow devices to send data, save it persistently in a database and receive commands along with the corresponding authentication and authorization mechanisms. We will also discuss the challenges encountered during the implementation to address interoperability.

For the implementation and simulation of MQTT logic, we adopted the #link("https://github.com/eclipse-paho/paho.mqtt.golang")[`github.com/eclipse/paho.mqtt.golang`] library, the official Go client maintained by the Eclipse Paho project. The library provides a full implementation of the MQTT protocol. It allowed us to public messages with specific QoS levels or topics, or register handlers for incoming messages and to react asynchronously to broker events such as connection loss and reconnection, essential for simulating realistic scenarios. The library also exposes connection options, configurable keep-alive intervals, clean session flags and credential injection, all of which were leveraged for the simulation.

=== Gateway: Problem Statement and Design Choices <sec:gateway_problem_statement>
One of the first design choices we had to make was regarding the role of the gateway,
which is the core of a publish-subscribe architecture, as described in @sec:pub_sub.
The question was: is it better to use a single gateway that translates CoAP requests
to MQTT or to have two separate gateways, one for MQTT and one for CoAP, that both
interact with the cloud infrastructure independently? @fig:gateway_design_choices illustrates the two options considered.
#v(1em)
#align(center)[
    #figure(image("../images/single_vs_double.png", width: 18em),
      caption: "Gateway design choices")
      <fig:gateway_design_choices>
]
\

As described in @sec:central_message_broker, NATS was selected as the central message
broker for the platform. Its model based on _subject_ abstracts the concept of topics,
making it a natural choice to handle messages from multiple protocols.
The goal was therefore to have all messages eventually reach NATS, where downstream services could consume them uniformly.

However, an important architectural consideration emerged from the coexistence of NATS
and VerneMQ. While similar, the two systems address messages using
different conventions: MQTT topics use the slash (`/`) as separator, while
NATS subjects use the dot (`.`). Also, NATS is stateless by design (messages are not retained if a subscriber is offline and Jetstream extension in not enabled) and its MQTT adapter does not  comply with the MQTT specification. VerneMQ, by contrast, natively supports persistent sessions and retained messages and QoS 1 and 2. This means that VerneMQ must remain the authoritative MQTT layer and the bridge to NATS requires an explicit translation step that accounts for both syntactic and semantic differences.
Before reaching the broker, each protocol requires its own ingestion layer. MQTT and
CoAP differ fundamentally in their communication model. MQTT is asynchronous: a device maintains
a persistent connection and listens continuously for messages on its subscribed topics. CoAP, by contrast, is synchronous and request-response oriented: a device sends a request and expects a reply within a certain time, after which it closes the connection.
This asymmetry has direct consequences on how the two protocols handle the two main
message flows in the system: telemetry and commands. For telemetry, both protocols can
publish data to the gateway, which forwards it to NATS for consumption by downstream
services. The difference is that an MQTT device maintains its connection passively,
while a CoAP device sends data as an explicit request and expects an acknowledgement
in return. For commands, the divergence is more significant: an MQTT device can receive
a command at any time, as long as it is connected and subscribed to the relevant topic.
A CoAP device, on the other hand, is not always reachable, so the gateway must be able
to hold a pending command and deliver it when the device reconnects.

The initial choice was to adopt a single solution for both protocols for easier
maintainability. EMQX was selected as a strong candidate, since it is a widely adopted
MQTT broker that also supports CoAP, offering seamless integration of both protocols
under a single service and reducing operational complexity and maintenance. However,
after a first implementation, two critical limitations emerged. First, the open-source
version of EMQX only supports single-node deployments, meaning that high availability
is not available without a commercial license. Second, CoAP support in EMQX is only
available in the paid tier. For these reasons, EMQX was discarded.
This led to the decision to adopt two separate gateways. For MQTT, VerneMQ
(@sec:mqtt_broker) was chosen. Although VerneMQ is distributed under the commercial
EULA license, by compiling the binary from source the resulting build is fully open
and usable without licensing costs.
For CoAP, a custom gateway was developed, tailored to the specific command and
telemetry semantics described above. Both gateways are responsible for translating
their respective protocol messages into NATS subjects — including the necessary
slash-to-dot topic remapping — so that the rest of the platform can consume them
uniformly.
The first concept of the gateway architecture is depicted in @fig:gateway_architecture.
#v(1em)
#align(center)[
    #figure(image("../images/first_concept.png", width: 30em),
      caption: "Gateway architecture")
      <fig:gateway_architecture>
]

=== VerneMQ <sec:vernemq>
VerneMQ, as mentioned above, was built from source to avoid licensing costs, and configured to run in with the built in options to run into a cluster with two instances for high availability. This was done through the environment variable `DOCKER_VERNEMQ_DISCOVERY_NODE=${VERNEMQ_IP_1}` that allows to auto join the first instance of the cluster through the discovery mechanism via local IP.

The broker has also built in options for authentication hooks, which we used to integrate JWT validation with the authentication service, as described later in @sec:jwt_authentication_authorization. These hooks allow an incoming connection to be intercepted and authenticated before being accepted by the broker, by using a plugin. The webhook plugin (`vmq_webhooks`) is enabled in place of the ACL system, which is explicitly disabled. This means that each event in the broker is delegated to an external HTTP service: connection attempts, publish requests and subscribe requests are each forwarded to a dedicated endpoint on the authentication
service via the `auth_on_register`, `auth_on_publish` and `auth_on_subscribe` hooks respectively. Two additional hooks, `on_client_offline` and `on_client_gone`, notify the authentication service when a client disconnects either gracefully or unexpectedly, allowing the service to update its internal state accordingly.  

The broker is configured to listen for MQTT connections on the standard port 1883. Traefik, the reverse proxy and load balancer later discussed in @sec:load_balancer, is put in front of the cluster and is enabled to to forward the real client IP address to the broker even when traffic is proxied. TLS termination for encrypted MQTT connections on port 8883 is handled by Traefik as well, so that the broker itself does not need to manage certificates directly. The secure communication was not enabled and tested in the current implementation but only considered, as the infrastructure is intended for local use only.
In @code:vernemq_docker_compose (#link(<sec:appendix_a>, "Appendix A")) we show the relevant parts of one of the VerneMQ instances, which capture the main configuration options described above.


=== JWT Issuing <sec:jwt_issuing_validation>
When a device connects for the first time, it must first obtain a JWT token from Zitadel to authenticate itself to the MQTT broker. Initially, we created manually the token from the Zitadel dashboard, by creating a machine user and the corresponding JWT, which was then injected into the simulated device in the code. However, this approach is not scalable and does not reflect the real-world scenario where devices need to obtain their tokens dynamically. For these reasons, in a next step we implemented a custom auto bootstrap issuing service that generates and manages JWT tokens for devices in a secure and scalable way.

The bootstrap process follows a defined sequence. First, device authenticates itself against the Zitadel management API using a Personal Access Token (PAT), which is provisioned once during the initial platform setup. It then creates a machine user in Zitadel on behalf of the device, or retrieves the existing one if the device has already been registered.
Once the machine user is available, the service requests a JSON key pair from Zitadel (one time only), stores the key material locally and then uses the private key to generate a signed JWT assertion following the `private_key_jwt` client authentication method defined in the OAuth 2.0 specification. 
 This assertion is then exchanged against the Zitadel token endpoint to obtain a time bounded access token, which the device can use to authenticate requests to the MQTT broker. If a key file for the user already exists locally, the service reuses it without issuing a new key, making it safe to run multiple times.
@fig:jwt_issuing illustrates the JWT bootstrap process, as described.
#v(1em)
#align(center)[
    #figure(image("../images/mqtt-jwt-bootstrap.png", width: 28em),
      caption: "JWT issuing process")
      <fig:jwt_issuing>
]
#v(1em)


=== JWT Authentication and Authorization <sec:jwt_authentication_authorization>
When a device attempts to connect to the MQTT broker, it presents its JWT token as part of the connection request in the password field. The communication is protected by TLS, so the token is encrypted during transit. During development, as mentioned, TLS was disabled for local testing purposes. VerneMQ, upon receiving the connection request, extracts the JWT token and triggers the `auth_on_register` hook (see @code:vernemq_docker_compose), which is called the first time a device connects or if the authentication result is not already cached. This hook forwards the authentication request to the authentication service.\

The authentication service is a custom Go microservice  we implemented to handle all authentication and authorization hooks from all the brokers, hence interacting with Zitadel and Permify for token validation and permission checks. In @code:auth_service_webhook_handlers we show the handlers for the hook called by VerneMQ. It works in particular by validating internally request format and by interacting with Zitadel to verify the JWT tokens and to Permify to check permissions.  \ \ 
The authentication flow follows the following steps, as @fig:auth_service_webhook_handlers illustrates.
+ The device connects to the broker and presents its JWT token in the password field.
+ \The broker triggers the `auth_on_register` hook and forwards the token to the authentication service.
+ The authentication service then retrieves the JSON Web Key Set (JWKS) from Zitadel and uses it to verify the token's signature and validity. If the token is successfully verified, it caches the authentication result for 12 hours to improve efficiency and responds to the broker with an acceptance message. 
+ The broker then sends a CONNACK message to the device, confirming the successful connection.\ \

When a device attempts a publish or subscribe action, the following operations happens.

+ Once authenticated, when the device attempts to publish to a topic or subscribe to one, the broker invokes the `auth_on_publish` or `auth_on_subscribe` hook.
+ Since the device has already been authenticated during the initial connection, the authentication service does not repeat the token verification process. Instead, it performs internal checks to ensure header consistency, extract the topic and device ID and verify that the token has not expired. 
+ Then queries Permify, to check whether the device has the necessary permissions for the requested operation on the specific topic. Permify evaluates the permissions based on the predefined access control policies and responds with either an acceptance or rejection. This process ensures both security and efficiency by caching authentication results while maintaining access control for each operation.
+ If the permission check is successful, the authentication service responds to the broker, which in turn responds to the device. If the check fails, the broker denies the publish or subscribe request, and the device receives an appropriate error message.
\ 
#v(1em)
#align(center)[
    #figure(image("../images/mqtt-jwt-auth.png", width: 27em),
      caption: "Authentication service webhook handlers")
      <fig:auth_service_webhook_handlers>
]
#v(1em)

=== Bridging NATS and VerneMQ <sec:nats_vernemq>
The next step was to implement the integration between VerneMQ and NATS, to ensure that messages published by MQTT devices are correctly forwarded to the central message broker.

Since VerneMQ natively speaks only the MQTT protocol and has no native support for the NATS protocol, a direct integration between the two systems is not possible without an intermediate component. For this reason, a dedicated bridge service was implemented as a Go microservice. The bridge connects to VerneMQ as a regular MQTT client, subscribes to the topics of interest and for each received message computes the corresponding NATS subject according to the hierarchical naming conventions of the platform, optionally enriches the payload with metadata such as tenant and device identifiers, and publishes the event to the appropriate JetStream stream.

This design keeps the routing and transformation logic outside both VerneMQ and NATS, so that both can evolve or be replaced with limited impact on the rest of the system. The bridge is the only component in the architecture that understands both MQTT topic semantics and NATS subject conventions, acting as a translation layer between the two services. 

A second bridge service was subsequently introduced to handle the reverse flow, that is, commands originating from the backend and directed toward MQTT devices. This service subscribes to the relevant NATS subjects and publishes the corresponding messages to VerneMQ, which then delivers them to the target devices. The two bridges together form a complete bidirectional channel between the MQTT layer and the internal messaging backbone, as depicted in @fig:bridge_architecture. 

#align()[
    #figure(image("../images/bridges.png", width: 40em),
      caption: "Bridge services architecture")
      <fig:bridge_architecture>
]
#v(1em)
High availability for both services was considered during the design phase
and the architecture supports running multiple replicas to avoid a single point of failure on the pipeline. However, this configuration was not implemented in the current deployment and the bridges run as single instances for the time being.

Regarding authentication, the bridge services are treated as special clients of the infrastructure.  Specifically, they are modeled as `service` entities in the authorization schema and follow the same JWT authentication process described for standard MQTT devices. Each bridge obtains a JWT through Zitadel and presents it when connecting to VerneMQ, so that the broker and the authorization layer can apply the same access control policies uniformly, regardless of whether the client is a physical device or an internal bridge.


=== NATS: Clustering and Persistence <sec:nats_subject_mapping>

NATS, as already described in @sec:central_message_broker, is the central message broker where all messages from devices, through the gateways, converge and are later consumed. For this reason, it constitutes a critical component in the system architecture and high availability is a critical requirement, to avoid single point of failure of the communication pipeline. Hence, for the implementation we used three instances in a cluster configuration, a built in option that allows to replicate messages across multiple nodes and ensure that if one instance goes down the others can take over without losing messages or connectivity. For example, the configuration of the first instance contains the following lines, where `routes` specify the addresses of the other two nodes, as shown in @code:nats_cluster_config.

#figure(
  sourcecode(
  ```yaml
  cluster {
    name: "NATS"
    listen: "0.0.0.0:6222"
    routes = [
      "nats://nats-1:6222",
      "nats://nats-2:6222"
    ]
  }
  ```
), caption: "NATS cluster configuration example"
) <code:nats_cluster_config>
The same is done for the other two instances, with the appropriate IP addresses. 

JetStream is a built-in persistence layer for NATS that provides durable message storage and advanced streaming capabilities. Since NATS is primarily designed as an in-memory messaging system, it does not guarantee message durability by default. JetStream addresses this limitation by allowing messages to be stored on disk, ensuring that they are not lost in case of failures. It also supports features such as message replay, at-least-once delivery and message retention policies. For this use case, where telemetry data from devices needs to be stored persistently for later analysis and historical queries, JetStream is an ideal solution.

To handle the incoming and outcoming telemetry data, a JetStream stream (see @code:nats_jetstream_stream_config) was configured to capture all messages flowing through the system. The stream, developed for testing purposes, subscribes to multiple subjects that correspond to different protocol gateways and traffic directions: `incoming.mqtt.>`, `outcoming.mqtt.>`, `incoming.coap.>` and `outcoming.coap.>`. The wildcard (>) ensures that all messages published to these subjects in the hierarchy are captured, regardless of the specific subtopics used. 

The subject naming encodes two pieces of information: the data direction and the protocol type. The direction prefix distinguishes between `incoming` messages, which originate from devices and are translated by the protocol bridges into NATS subjects, and `outcoming` messages, which originate from the backend and are translated by the bridges before being sent to devices through the appropriate gateway. This distinction is essential for determining the source and destination of each message. 

The protocol suffix (`mqtt` or `coap`) identifies which gateway handled the message, enabling the system to route outcoming commands to the correct protocol bridge and providing valuable context for audit trails and analysis. For example, a command destined for a device connected via MQTT would be published to an `outcoming.mqtt.>` subject, ensuring that the MQTT bridge receives and forwards it correctly. Similarly, telemetry data arriving from a CoAP device would appear on an `incoming.coap.>` subject, clearly indicating both its origin and the protocol used for transmission.

The stream employs a limit retention policy, which means messages are retained until the maximum number of messages or the maximum age threshold is reached. To align with the cluster configuration, the stream is configured with three replicas, meaning that each message is replicated across all three NATS instances.


=== DB Writer and Database Persistence <sec:db_persistence>
Message persistence is the final step of the communication pipeline, where telemetry data from devices is stored in a database for later analysis and historical queries, such as for dashboard visualization. A dedicated microservice written in Go, the _DB Writer_, continuously consumes messages from the NATS JetStream stream and writes them to a TimescaleDB database. We selected _TimescaleDB_ (an extension of PostgreSQL) as the storage backend due to its optimization for time-series. It efficiently partition and compress data automatically, making it ideal for IoT where data arrives continuously and queries focus on time parameters.

The DB Writer establishes a pull subscription to the JetStream stream described in the previous section and fetches messages in batches to improve throughput. When messages arrive, the worker parses the payload, which carries the originating device ID, tenant ID, a measurement type, the timestamp and the sensor data and maps them to a database record. The timestamp provided is used as the primary partitioning key, ensuring that data is organized chronologically in the hypertable structure provided by TimescaleDB. Also, data is stored as a JSONB format, which allows to store JSON data in binary form, for flexibility such as when new device types or data formats are introduced. 
@code:data_writer_input_payload illustrates the structure of the input payload and the main fields described above. Also, it shows the logic for dynamic table creation based on the tenant ID.


#figure(
  caption: [Sample rows from `iot_records_tenant_01` (top) and `iot_records_tenant_02` (bottom).],
  grid(
    columns: 1,
    row-gutter: 1em,

    [
      _Table iot\_records\_tenant\_01_
      #table(
        columns: (auto, auto, auto, auto, auto),
        align: (left, left, center, center, left),
        inset: (x: 3pt, y: 7pt),
        table.header(
          [*time*], [*device\_id*], [*tenant\_id*], [*type*], [*data (JSONB)*],
        ),
        mc[2025-11-10 08:03:12 UTC], mc[temp\_001], mc[tenant\_01], mc[data],   mc[{"value": 22.4, "unit": "C"}],
        mc[2025-11-10 08:05:44 UTC], mc[fan\_003],  mc[tenant\_01], mc[status], mc[{"running": true, "speed": "medium"}],
        mc[2025-11-10 08:07:01 UTC], mc[temp\_001], mc[tenant\_01], mc[alert],  mc[{"code": "OVER_THRESHOLD", "value": 29.1}],
        mc[2025-11-10 08:09:33 UTC], mc[fan\_003],  mc[tenant\_01], mc[cmd],    mc[{"action": "set_speed", "target": "high"}],
      )
    ],

    [
      _Table iot\_records\_tenant\_02_
      #table(
        columns: (auto, auto, auto, auto, auto),
        align: (left, left, center, center, left),
        inset: (x: 3pt, y: 7pt),
        table.header(
          [*time*], [*device\_id*], [*tenant\_id*], [*type*], [*data (JSONB)*],
        ),
        mc[2025-11-10 08:10:22 UTC], mc[temp\_007], mc[tenant\_02], mc[data],   mc[{"value": 18.9, "unit": "C"}],
        mc[2025-11-10 08:10:25 UTC], mc[air\_008],  mc[tenant\_02], mc[data],   mc[{"value": 412, "unit": "ppm"}],
        mc[2025-11-10 08:12:01 UTC], mc[temp\_007], mc[tenant\_02], mc[status], mc[{"online": true, "battery": 87}],
      )
    ],
  )
) <tab:timescale-tenant-sample>
#v(1em)

An important aspect is in regards to the logical tenant isolation done at the table level, as discussed theoretically in @sec:multi-tenancy and showed as an example in @tab:timescale-tenant-sample. Instead of writing all data into a single shared table, we maintain a dedicated table per tenant. This enables data isolation and simplifies future access policies at the database.
Tables are provisioned on demand: when the first message belonging to an unknown tenant arrives, the worker creates a new dedicated table for that tenant, which registers the new table with TimescaleDB's time-partitioning engine. Subsequent messages from the same tenant skip this step.
Once a table is ready, the record is inserted and the message is acknowledged (Ack), signalling to JetStream that it can be safely discarded from the stream. Otherwise, the worker sends a negative acknowledgement (Nak) instead, causing JetStream to redeliver the message at a later time. This mechanism guarantees at-least-once delivery, ensuring that no telemetry data is  lost.

=== Summary <sec:mqtt_summary>
In @fig:mqtt_pipeline we summarize the MQTT communication pipeline discusses in this section, from the device layer to the database persistence. The diagram captures the main components involved in the communication, including the MQTT devices, the VerneMQ broker, the bridge services, NATS and JetStreat, the authentication service along with Zitadel and Permify and the DB Writer with TimescaleDB. 

As we can see, the pipeline is designed to be modular and extensible but we can also observe the complexity of the communication flow, with multiple components involved. This complexity is a direct consequence of the design choices made to achieve interoperability, multi-tenancy and security, which require additional layers of abstraction and integration, along with using only open-source solutions. The architecture is designed to allow for future extensions such as adding support for CoAP devices, as we will discuss in the next section.


#v(1.5em)
#align(center)[
    #figure(image("../images/schemas/mqtt_schema.png", width: 45em),
      caption: "MQTT communication pipeline")
      <fig:mqtt_pipeline>
]
#pagebreak()

== CoAP implementation <sec:coap_implementation>

For the CoAP implementation, we needed to integrate it with the existing pipeline just described. First, an analysis of the CoAP protocol was conducted to understand how it works, as described in @sec:coap and should we integrate it. Then, we did a study of the existing services to understand which ones we could reuse and which ones needed to be developed to integrate the new protocol.
In general, the goal was to reuse as much as possible of the existing architecture, such as the existing authentication and authorization mechanisms, the NATS service and the database persistence layer.
A more detailed description of design and implementation choices is done in the next sections.

=== CoAP Gateway Design <sec:coap_gateway_design>
One of the first critical design choices regarded the CoAP gateway. As said, initially we wanted to use a single gateway for both protocols, but after discarding EMQX we had to implement a custom one for both. The main challenge was to design it in a way that it could be integrate with the existing architecture. 
The gateway need to be able to receive CoAP requests from devices, authenticate and authorize them, translate them into the subject structure and forward them to NATS. It also needs to handle the command flow in the opposite direction, by subscribing to the relevant NATS subjects and delivering commands to devices when they reconnect. Basically, it implements the same logic of VerneMQ and bridge services, but for the CoAP protocol.

We implemented the logic using the #link("https://github.com/plgd-dev/go-coap")[`github.com/plgd-dev/go-coap/v3`] library, which provides a full implementation of the CoAP protocol in Go.
The gateway listens for incoming CoAP requests on port 5684 and handles them according to the defined logic.

=== DTLS with PSK: Authentication and Encryption <sec:coap_auth>
For authentication and authorization, the CoAP devices follow a substantially different process compared to MQTT. The main problem we faced was that CoAP does not support JWT tokens and Zitadel does not support CWT tokens (the CoAP equivalent of JWT). This misalignment meant that we could not reuse the same authentication mechanism for both protocols, as we initially intended, which was a critical design choice. For this reason, we had to implement a custom authentication mechanism for CoAP devices, while still integrating some of it with the same authentication service to maintain a unified access control layer.

The solution adopted relies on DTLS with PSK (introduced in @sec:coap), a cryptographic protocol that combines authentication and encryption into a single handshake process, defined in the CoAP specification @RFC7252T73 as the recommended security mechanism. Unlike password-based authentication, where credentials are transmitted and verified, DTLS-PSK operates through a mathematical challenge. The client and server each possess a copy of a _shared secret key_, which is never sent over the network. During the handshake, both parties use this key to independently compute ephemeral session keys. 

If the server successfully decrypts the client's initial message, it has cryptographic proof that the client possesses the correct PSK, thus achieving implicit authentication. From that point forward, all communication is encrypted using the newly derived _session keys_. This approach provides both authentication and confidentiality in a single efficient operation, which is particularly suitable for CoAP.

However, we faced a big issue when trying to integrating DTLS PSK with Zitadel. Like any secure identity provider, it stores credentials as cryptographic hashes. When a client secret is generated, Zitadel displays it only once and then stores its hash. This design ensures that even if the database is compromised, the actual secrets cannot be recovered. The problem is that the CoAP gateway requires access to the plaintext PSK to perform the DTLS handshake calculations. Since Zitadel cannot return the original key, it can only validate whether a provided key matches the stored hash, which is insufficient for DTLS-PSK operation.

An additional challenge is latency. DTLS operates over UDP which sensitive to timing. If a response does not arrive, the client assumes the packet was lost and triggers retransmissions. Making an HTTP call to Zitadel during the DTLS handshake, may introduce delays that can cause the CoAP device to timeout and flood the network with retransmissions, degrading performances.

To address these constraints, during device provisioning (explained in further details in @sec:psk_issuing_storage), a PSK is generated and stored encrypted in a database accessible to the gateway. When a device attempts to connect via CoAP, the gateway retrieves the corresponding PSK from the database and uses it to complete the DTLS handshake without requiring real-time communication with Zitadel. Once the connection is established and the device is authenticated, the gateway query the authentication service to check permission through Permify, maintaining consistency with the authorization model already developed. 
\ \

The DTLS handshake follows a challenge-response protocol that verifies the device possesses the correct PSK without transmitting it. It works as follows, as also showed in the sequence diagram in @fig:dtls_handshake.
+ When a device wakes up and initiates a connection, it sends a ClientHello message that includes its identity hint, which contains both the device ID and the tenant ID. 
+ The CoAP gateway receives this identity and queries the PostgreSQL database to retrieve the corresponding PSK. The PSK is stored in encrypted format using AES-256-GCM with a master key known only to the gateway, ensuring it remains protected.
+ Once retrieved, the gateway decrypts the PSK and uses it to participate in the DTLS handshake calculations.
+ The PSK callback function (see @code:dtls_config_with_psk_callback) is invoked by the DTLS library during the handshake when the server needs to look up the key corresponding to the client's identity. If the device identity is found and the PSK is successfully retrieved, the handshake proceeds. Otherwise, the handshake fails and the connection is rejected.
+ Both parties generate ephemeral key pairs using Elliptic Curve Diffie-Hellman (ECDHE) exchange, that allows them to compute a shared secret without ever transmitting it. It works by each party generating a random private key and a corresponding public key, which are exchanged during the handshake.
+ Then they compute the symmetric session keys using a Key Derivation Function (KDF) with the PSK, the ephemeral key and random nonces, used for encrypting communication.
+ The device sends a challenge encrypted with the derived keys and the server must successfully decrypt and respond to this challenge to prove it possesses the same PSK. 
+ If decryption succeeds, it provides mathematical proof that both parties share the correct secret generated, completing the authentication. 
+ From this point, all CoAP messages are encrypted using the ephemeral session keys, protecting the confidentiality and integrity of the communication.
#v(1em)
#align(center)[
    #figure(image("../images/dtls_handshake.png", width: 27em),
      caption: "DTLS handshake with PSK") <fig:dtls_handshake>
] 



=== PSK Issuing and Storage <sec:psk_issuing_storage> 
Since the PSK is a critical piece of information for the authentication process, it needs to be generated and stored securely during device provisioning. \
Initially, we considered that PSK could be integrated in the device during manufacturing, but this approach is not scalable and flexible, as it requires coordination with the hardware manufacturer and does not allow for dynamic provisioning. For this reason, we implemented a custom PSK issuing service that generates a unique PSK for each device during the provisioning process and stores it securely in a database accessible to the CoAP gateway.

As already mentioned in @sec:database_layer, initially for the storage implementation, we evaluated several alternatives. _HashiCorp Vault_ offers advanced secrets management capabilities including automated key rotation and hardware security module integration, but introduces significant operational complexity through dedicated infrastructure requirements and specialized maintenance procedures. _Infisical_, a more recent open source alternative, simplifies deployment but still requires additional services and introduces REST API latency without providing meaningful benefits for our automated provisioning workflow. Given our limited operations and the small scale of deployment, both solutions resulted to be disproportionate to our actual requirements. 

Finally, we selected a dedicated PostgreSQL instance with application level encryption. This decision was driven primarily by cost considerations and practical constraints. Since we already operate a TimescaleDB instance for data storage, we can allocate a separate database within the same infrastructure at essentially zero additional cost. This allows to eliminate the learning curve associated with specialized secrets management tools and future maintenance overhead. For our use case in smart agriculture, where device downtime does not pose safety risks or cause significant financial losses, the security guarantees provided by AES-256-GCM encryption with Argon2id key derivation.

The implementation uses a schema with a dedicated `device_psk` table per tenant for logical separation in a multi-tenant environment. PSKs are encrypted at the application level before storage with the master encryption key. To maintain acceptable performance during DTLS handshakes, we introduced an in-memory cache that reduces database queries for frequently accessed keys.

Moreover, since the PSKs are not hardcoded during manufacturing, we designed the provisioning process through a manual configuration process by an operator over a secure out-of-band channel, such as Bluetooth or NFC, which is a common practice in IoT deployments. During provisioning, the operator uses a custom smartphone application (that was not implemented due to time constraints and purpose of the current project) to interact with the device and the provisioning API service.

The sequence diagram in @fig:psk_bootstrap illustrates the PSK issuing and storage process. 
+ The workflow begins when the operator uses the smartphone application to configure the tenant ID on the device via Bluetooth. 
+ The device then generates a random 32-byte nonce and transmits it back to the application. This nonce serves as a challenge to verify that the provisioning server is authorized to issue credentials for this specific device. 
+ The operator application forwards the device ID, tenant ID and nonce to the provisioning API via HTTPS.
+ The provisioning API performs two operations: it signs the nonce using an Ed25519 private key to prove its authority and generates a 256-bit PSK for the device. The API responds with a session ID, the signature, the corresponding public key, and the newly generated PSK. 
+ The operator application sends the signature to the device. 
+ The device verifies the signature using the provided public key and the original nonce. This cryptographic verification ensures that the PSK originates from an authorized provisioning server and has not been tampered with during transmission.
+ Upon successful verification, the device requests the PSK from the operator application. 
+ The application transmits the PSK and the device stores it securely. 
+ The operator application then notifies the provisioning API that verification succeeded by sending a completion request with the session identifier. 
+ Only at this point, the provisioning service encrypts the PSK using AES-256-GCM with Argon2id key derivation and stores it in the PostgreSQL database within the appropriate tenant table. 
+ Once the database confirms successful insertion, services are acknowledged and the provisioning process is complete.
+ The device is now ready to establish DTLS connections with the CoAP gateway using the provisioned PSK, as described in the previous section.

The sequence diagram in @fig:psk_bootstrap illustrates the PSK issuing and storage process.

#align(center)[
    #figure(image("../images/schemas/psk_issuing_storage.png", width: 35em),
      caption: "PSK issuing and storage process") <fig:psk_bootstrap>
]
#v(1em)
The use of Ed25519 for signature verification in the provisioning workflow represents an optimization for constrained  environments. As discussed in @sabbry2024digital, traditional signature schemes such as RSA-2048 or ECDSA require significantly more computational resources and memory. RSA operations involve modular exponentiation with large integers, which is computationally expensive for devices with limited processing power. ECDSA, while more efficient than RSA, involves more complex arithmetic operations. In contrast, Ed25519 offers comparable security levels (approximately 128 bits of security) while providing substantially faster signature verification, smaller key sizes (32 bytes for public keys) and deterministic signing that avoids the need for secure random number generation. Ed25519 verification can complete in a few milliseconds even on low-power microcontrollers, whereas RSA verification might take hundreds of milliseconds or require hardware acceleration. This performance advantage is particularly important during the provisioning phase, where the device must verify the server's authority before accepting credentials, as it minimizes the time the operator must maintain the Bluetooth connection and reduces power consumption during the setup procedure.

=== Message Flow <sec:coap_message_flow>
In terms of message flow, the CoAP gateway works in a different way compared to the MQTT broker. Since CoAP is a request-response protocol, the gateway needs to handle both incoming requests from devices and outcoming commands from the backend in a different manner. For MQTT, we developed dedicated translator services that bridge communication between the MQTT broker and NATS. For CoAP, however, we implemented the routing logic directly within the gateway itself. This approach is feasible because the CoAP gateway is a custom microservice under our control, allowing us to integrate the necessary message handling without introducing additional components.

The message flow architecture comprises three main elements: First, the gateway maintains an active NATS subscription to receive commands destined for CoAP devices. These commands originate from backend services and are published to NATS subjects specifying the target device. 

Second, the gateway implements a persistent message store for commands. CoAP devices typically operate in sleep modes to conserve battery power, remaining offline for extended periods between data transmission cycles. Therefore, commands arriving while a device is asleep must be stored in the database rather than discarded. This persistence serves a dual purpose: it ensures reliable command delivery when the device eventually reconnects and provides an audit trail for traceability. When a device connects to send telemetry data, the gateway implements a simple polling mechanism to check for pending commands and delivers them, if any, during the same session, minimizing the number of activations required and ensuring very low latency. For this purpose, we leverage the same PostgreSQL database used for PSK storage, creating a dedicated tables per tenant to maintain logical separation. The reason for this is to avoid introducing additional infrastructure components which would add complexity and operational overhead without providing significant benefits for this use case, given the purpose of the project. 

Third, the gateway enforces permission checks for both incoming and outcoming messages. For incoming telemetry data from devices, the gateway validates that the device is authorized to publish measurements to its assigned data streams. For outcoming commands from the backend, the gateway verifies that the requesting service has the appropriate permissions to send commands to the target device. These authorization decisions are delegated to the authentication service (discussed in @sec:jwt_authentication_authorization ) which exposes a dedicated endpoint for this gateway. In turn, it queries Permify to evaluate the access control policies. This design maintains consistency with the MQTT message flow, ensuring that both protocols apply the same logic, reusing the same infrastructure.

In the sequence diagram in @fig:coap_message_flow, we illustrate the CoAP message flow architecture for both telemetry data from devices and commands persisting in the database until the device reconnects.

+ First, a user publishes a command to a NATS subject that corresponds to the target device, for example `outcoming.coap.tenant123.device456`. This command is received by the gateway through its NATS subscription. 
+ The gateway then stores the command persistently in the PostgreSQL database, marking it with a pending status. At this stage, the device is typically offline to conserve battery power, so the command remains queued until the device reconnects.
+ When the device eventually wakes up and connects, it first establishes a DTLS session using the provisioned PSK. Once the secure channel is established, the device sends a POST request with telemetry data to the gateway. 
+ The gateway performs authorization checks by consulting Permify through the authentication service to verify that the device has permission to publish data to its assigned streams. Simultaneously, the gateway queries the database to check whether any pending commands exist for this device. 
+ If pending commands are found, the gateway publishes the telemetry data to NATS and responds to the device with an acknowledgment that includes notification of pending commands.
+ The device then enters a message retrieval loop. For each pending command, the device sends a GET request to the gateway's messages endpoint. The gateway retrieves the first pending command from the database, updates its status to delivered to prevent duplicate delivery and sends the command payload to the device. 
+ The device processes the command and repeats the retrieval process until the command queue is empty.
#v(1em)
#align(center)[
    #figure(image("../images/coap_message_flow.png", width: 40em),
      caption: "CoAP message flow architecture") <fig:coap_message_flow>
]

=== Summary <sec:coap_summary>
In @fig:coap_pipeline we summarize the CoAP communication pipeline described in this section, from the device layer to the database persistence. The diagram captures the main components involved in the communication, including the CoAP devices, the CoAP gateway along with database for command persistence and PSK storage, the authentication service along with Permify, the NATS cluster and the database for data persistence. The architecture was implemented to reuse as much as possible of the existing components developed for MQTT, while introducing the necessary custom logic to handle the specific requirements of CoAP. The design choices made, such as the custom gateway and the PSK management, were driven by the need to integrate with the existing architecture while addressing the unique challenges posed by CoAP's security model and communication patterns. The resulting architecture is modular and extensible, allowing for future enhancements such as adding support for additional protocols.
#align(center)[
    #figure(image("../images/coap_schema.png", width: 45em),
      caption: "CoAP communication pipeline") <fig:coap_pipeline>
]

== Load Balancing  <sec:load_balancing>
Among the final steps of the implementation, we evaluated different options for load balancing, as in a real deployment, the ingress traffic from devices must be distributed across multiple gateway instances to ensure reliability, scalability and security. A load balancer serves as the entry point for all device communications, acting as a critical security boundary that protects the internal infrastructure from direct exposure to potentially compromised or malicious devices.

In a production environment, a load balancer is considered a standard practice for various reasons. First, it provides a single point of control for applying security policies such as rate limiting, connection barriers or IP filtering, which are essential against denial of service attacks. Without a load balancer, each gateway instance would need to implement these protections independently, increasing complexity. Second, a load balancer enables horizontal scaling by distributing connections across multiple gateway instances, preventing single instances from becoming a bottleneck or single point of failure. Third, it facilitates seamless deployments with no downtime by allowing individual gateway instances to be updated or restarted while the load balancer redirects traffic automatically.

From a security perspective, the absence of a load balancer exposes the system to several attack vectors. Direct exposure of gateway to the public internet increases the attack surface, as each instance becomes a potential target. For instance, an attacker could launch a DDoS attack (@sec:multi_layer_attacks) by opening thousands of DTLS or TCP connections to a single gateway, preventing legitimate devices from connecting. Similarly, amplification attacks exploiting CoAP's UDP based transport could overwhelm an unprotected gateway with spoofed requests. A load balancer mitigates these risks by implementing specific protections.

As already discussed in @sec:load_balancer, we selected Traefik as the load balancer. Traefik communicates with the protocol gateways described in previous sections: the VerneMQ cluster for MQTT traffic and the CoAP gateway for CoAP traffic. This architecture ensures that all device communications pass through a unified ingress layer.

== High Availability <sec:high_availability>

As discussed in @sec:arch_requirements, one of the key requirements of the infrastructure is to achieve high availability, since downtime of one or more components in the communication pipeline could lead to data loss, service disruption and potential financial consequences. For this reason, we considered service replication from the earliest stages of the design process.

In production environments, replicating critical services across multiple instances is standard practice to eliminate single points of failure and ensure continuous operation during maintenance, updates or unexpected failures. However, for the scope of this project, we did not implement replication across all services. This decision was driven by practical considerations including time constraints, maintainability concerns and the purpose of the project. Full high availability implementation would require additional infrastructure resources, more complex deployment and high operational overhead that extends beyond the project's objectives.

As described in previous sections, we applied replication only to NATS and VerneMQ. The main reasons are the followings. First, both systems provide native clustering capabilities with minimal configuration overhead. NATS implements a cluster protocol that automatically synchronizes state across nodes, while VerneMQ offers built-in cluster management with straightforward configuration for message distribution and session persistence. This ease of deployment makes replication feasible without requiring custom development or complex synchronization logic.
Second, NATS and VerneMQ constitute the backbone of the messaging infrastructure and play critical roles in system operation. NATS serves as the central message bus connecting all microservices, making it a single point of failure if not replicated. VerneMQ handles all MQTT device connections and acts as the primary ingress point. 

Replication was not implemented for the CoAP gateway primarily because synchronizing multiple instances introduces considerable complexity. Unlike NATS and VerneMQ, the CoAP gateway is a custom microservice that would require explicit design of state synchronization protocols for the command queue and PSK cache. Implementing distributed coordination for pending commands stored in the database would necessitate consensus algorithms or distributed locking mechanisms to prevent duplicate message delivery or lost updates. While technically feasible, it was not implemented but remains a consideration for future development. Similarly, the other services run as single instances and should be evaluated for high availability in production deployments.

== M2M Communication and Authentication <sec:m2m_communication>
One of the key requirements of the project is to provide appropriate authentication and authorization mechanisms, especially for non-human actors, defined in more detail at the beginning of this chapter in @sec:arch_requirements.
As we saw in the previous sections, the system involves several categories of communicating actors, none of which involve a human user directly. 
M2M authentication is the process by which a machine, a software service or an automated client proves its identity to another machine without any human interaction. Unlike classic authentication, there is no login form or password at runtime. In this architecture, M2M authentication naturally divides into two distinct sub-problems: _device-to-backend_ authentication, which concerns the IoT sensors and gateways and _service-to-service_ authentication, which concerns the internal backend components communicating with each other.

For this work, as described, we implemented two separate authentication paths for IoT nodes, each tailored to the protocol in use. For MQTT devices, we adopted the OAuth 2.0 flow, issuing a short-lived JWT at connection time. For CoAP devices, since for its inherent nature token flows are impractical, we used DTLS with PSKs instead. In both cases, authorization is delegated to Permify, providing a uniform policy layer across the two paths.
For the internal backend services, the scope of the authentication implementation is intentionally limited. Given the purpose of the project and the time constraints, service-to-service authentication has been implemented only for the bridge component that connects VerneMQ and NATS, described in @sec:nats_vernemq.
The mechanism used here mirrors the device authentication model: the bridge service authenticates by obtaining a JWT through a token based flow, which it then presents when establishing its connection. Authorization checks are again delegated to Permify, keeping the policy logic centralized and consistent with the rest of the system.
The remaining internal services, including the database and other infrastructure components, have not been implemented with mutual authentication. This is a clear security limitation and is addressed as a direction for future work in @cap:future_directions.

== Local Hub Design <sec:local_hub_design>
Among the final steps of the implementation, we examined a deployment scenario that  reflects more closely the actual operational environment of the project. While this aspect extends beyond the scope of the current prototype, it warrants discussion due to its implications for architectural design and future scalability. We considered the role of a local hub or gateway deployed in proximity to sensor nodes, acting as a relay point for communication between devices and the cloud infrastructure. The underlying assumption is that each device connects to exactly one local hub, which serves as its gateway to the broader network. @fig:local_hub illustrates the local hub architecture, where multiple devices of a fleet connect to a local hub that manages communication with the cloud.

A local hub is typically a more capable device with enhanced connectivity options, such as Wi-Fi or 5G, which consume more power. This architectural pattern is particularly relevant in scenarios where devices are deployed in remote or challenging environments with limited direct connectivity. In smart agriculture applications, for instance, sensors may be distributed across fields where cellular coverage is intermittent or unavailable. In such cases, a local hub with better antenna or higher transmission power can maintain a reliable connection to the cloud while aggregating data from multiple devices operating on protocols like LoRaWAN. Conversely, in controlled environments such as smart greenhouses, a local hub may be less useful for basic connectivity since the greenhouse itself can provide stable network access. However, even in these scenarios, this solution can offer edge processing capabilities and local control logic.

#v(1em)
#align(center)[
    #figure(image("../images/schemas/local_hub.png", width: 23em),
      caption: "Local hub architecture") <fig:local_hub>
]
#v(1em)

We identified two primary architectural models for local hubs: forwarding and edge processing. The forwarding model operates as a simple relay. The hub receives messages from local devices and forwards them to the cloud without modification. This approach maximizes flexibility by supporting heterogeneous device where sensors may use different communication protocols or data formats. The complexity of protocol translation and data formatting remains on the device side, allowing each sensor to maintain its own communication logic. The forwarding model is particularly well suited to multi-protocol environments where devices range from simple temperature sensors to more sophisticated actuators.

The edge processing model, in contrast, involves management and aggregation functions at the hub level. The local hub manipulates, aggregate and normalizes data from multiple devices before forwarding it to the cloud. This can reduce network bandwidth by combining readings from multiple sensors into summary messages or by filtering redundant data. Additionally, the hub can apply local control logic, responding to sensor readings without requiring round-trip communication. However, this approach introduces rigidity, as the hub must be configured to understand the specific data formats and protocols of the devices it manages. Changes to the device population or the addition of new protocol types may require reconfiguration or firmware updates to the hub itself. @tab:local_hub_comparison summarizes the main differences between the two models in terms of operation, flexibility, complexity and advantages.
#v(1em)
#figure(
  table(
    columns: 3,
    stroke: 0.5pt,
    inset: 5pt,
    align: (left, left, left),
    table.header(
      [*Aspect*],
      [*Forwarding model*],
      [*Edge Processing model*],
    ),
    [_Operation_],
    [Simply forwards data to the cloud],
    [Manipulates data],
    
    [_Flexibility_],
    [High (handles multi-protocol architectures)],
    [Low (rigid with respect to device types)],
    
    [_Complexity_],
    [Distributed to devices],
    [Centralized in the hub],
    
    [_Advantage_],
    [Ideal for heterogeneous devices],
    [Optimizes bandwidth and cloud load],
  ),
  caption: [Comparison between forwarding and edge processing local hub models]
) <tab:local_hub_comparison>
#v(1em)

For this project, we adopted the forwarding model with optional edge processing capabilities. This decision aligns with the multi-protocol philosophy of the infrastructure, which supports both MQTT and CoAP devices with minimal coupling between device implementations and backend services. By treating the local hub as a transparent forwarder by default, we preserve the ability to integrate diverse device types without modifying hub logic. At the same time, the architecture allows for optional aggregation or preprocessing functions to be deployed on the hub when bandwidth optimization or latency reduction becomes critical.

This architectural choice had direct implications for the topic structure and authorization model, as discussed in @sec:hierarchical_zoning_design. The introduction of local hubs, which are seen by che cloud services as special devices, required distinguishing between the authenticated entity establishing the connection (the hub) and the logical device to which the message pertains (the sensor). The original 9 level topic structure could not represent this separation, as it assumed that the device ID in the topic always matched the identity of the connected client. To address this, we extended the topic structure for command messages to include both a sender ID and a target ID, creating a 10 level format that explicitly distinguishes the command source from its destination. For telemetry messages, we maintained the 9 level structure but modified the authorization logic to verify that the connected hub has permission, by querying Permify, to act on behalf of the device.

== Summary <sec:coap_summary>
In @fig:overall_pipeline we provide an overview of the entire communication pipeline discussed and described in the previous sections, including both MQTT and CoAP protocols. 
The diagram captures the main components involved in the communication flow, from the device layer to the database persistence, along with the services that facilitate interoperability between them.
#v(1em)
#align(center)[
    #figure(image("../images/multi-protocol-framework.png", width: 48em),
      caption: "Multi-protocol communication framework overview") <fig:overall_pipeline>
]
#v(1em)
The implementation presented in this chapter represents a significant technical challenge: achieving seamless interoperability between two fundamentally opposite protocols. MQTT and CoAP differ in their architecture, communication patterns and security models. MQTT operates on a publish-subscribe paradigm with persistent connections, while CoAP follows a request-response model over connection less UDP. These architectural differences required a careful design during the development process.

The final solution employs a set of custom services and components that bridge these protocol differences. This approach highly increases complexity and maintenance burden compared to enterprise solutions. However, it achieves complete interoperability at zero licensing cost, relying entirely on open-source components. The trade-off is clear: the operational complexity is exchanged for infrastructure cost savings, as it requires continuous maintenance but eliminates expensive commercial service fees.

Security considerations further complicated the design. Each protocol demanded specific security measures: DTLS with PSK for CoAP nature and TLS with JWT for MQTT. The multi-tenant requirement added another layer of complexity, requiring careful isolation and access control across different organizational boundaries while maintaining a unified data flow.

Despite these challenges, the architecture was designed to be modular and extensible. The clear separation of concerns between protocol gateways and brokers, authentication services and data persistence layers allows for future enhancements, such as adding support for additional IoT protocols. This extensibility ensures that the investment in solving the MQTT and CoAP interoperability provides a foundation for broader protocol support as the system evolves.

In conclusion, the implementation delivers a complex and robust communication framework suitable for smart agriculture applications, demonstrating that open-source solutions can achieve enterprise interoperability when architectural complexity is managed and security is addressed with appropriate measures.


 