#pagebreak(to:"odd")


= Future Directions <cap:future_directions>

== Introduction <sec:intro_future_directions>
In this chapter, we explore potential future directions for the development and enhancement of the multi-protocol communication framework for smart agriculture designed and implemented. Building on the foundation established in the previous chapters, we identify key areas for further research that can enhance the functionality, security or scalability of the system. 

== Post-Quantum Security <sec:post_quantum>
As quantum computing continues to advance, the security of traditional cryptographic algorithms used in IoT devices is increasingly at risk. Future research could focus on integrating post-quantum cryptographic solutions into the communication framework to ensure the long-term security of IoT communication. This could involve evaluating and implementing post-quantum algorithms that are suitable for resource-constrained devices, as well as developing efficient key management strategies for these algorithms.

=== Challenges and Possible Solutions <sec:post_quantum_challenges>
The integration of post-quantum cryptography into IoT networks faces a set of obstacles that derives primarily from the inherent limitations of resource constrained devices.

A first concern is the constant evolution of the cryptographic landscape. Quantum computing is evolving rapidly and there is no guarantee that algorithms considered secure today will remain resistant to  quantum attacks in the future @fernandez2019pre. This uncertainty makes it difficult to commit to any single solution without risking obsolescence.
Pratically speaking, traditional IoT devices operate with relatively small key sizes, typically ranging from 128 to 4096 bits. Post-quantum algorithms, however, demand significantly larger keys, which introduces high overhead in terms of memory, processing time and energy consumption. These requirements do not match with the IoT design philosophy of minimal resource usage.
Latency is another problem. Constrained nodes introduce delays when executing cryptographic primitives, making synchronization harder. Hash-based post-quantum schemes, for instance, impose a finite limit on the number of valid signatures per key pair, requiring periodic key regeneration, a process that is both computationally and energetically expensive for low-power hardware.
Beyond performance, there is a bigger gap: most post-quantum proposals prioritize security proofs while treating energy, time and resource efficiency as secondary. For IoT deployments, however, these parameters are critical. Any solution must balance security guarantees against operational constraints.
Finally, the absence of standardized benchmarks in the IoT environment complicates the selection and comparison of candidate algorithms. Efforts by organizations such as NIST, IEEE and IETF to define standardized and testing procedures would provide a foundation for future works. In parallel, algorithmic optimizations targeting specific computational bottlenecks remain an open and promising research direction.

=== Quantum Attacks <sec:quantum_attacks>
Quantum computing introduces a new class of threats to the cryptographic mechanisms that IoT networks rely on for confidentiality, integrity, authentication and non-repudiation. The following subsections outline the main attack strategies relevant to this context.
==== Shor's Algorithm <sec:shor_algorithm>
Shor's algorithm @shor1999polynomial, introduced in 1994, can solve integer factorization and discrete logarithm problems in polynomial time, specifically in _O(n³)_ with respect to the key size _n_. This means it can break any asymmetric cryptographic scheme whose security is based on these mathematical problems. Lightweight cryptographic algorithms, which are common in IoT due to their low resource demands, tend to rely on problems that are even less computationally hard, making them potentially more vulnerable. 
==== Grover's Algorithm <sec:grover_algorithm>
Grover's algorithm @grover1996fast, introduced in 1996, provides a quadratic speedup when searching through unstructured datasets, leveraging quantum superposition to explore multiple solutions in parallel. This halves the security of symmetric key algorithms: a 128-bit key is only as strong against a quantum computer as a 64-bit key is against a regular computer. While this does not break symmetric cryptography totally, it does require a reassessment of key lengths used in IoT contexts.
==== Side-Channel Attacks <sec:side_channel_attacks>
In this attack, the eavesdropper tries to exploit the vulnerabilities in implementation or environment rather than mathematical structures. For example, an invasive side-channel attack can do anything with cryptographic devices whereas, a
noninvasive side-channel attack does not physically tamper with the device but harms using timing attacks, power analysis, electromagnetic attacks, and so on. In a semi-invasive side-channel attack, the goal of an attacker is to add fault in
the algorithms or cryptosystems. Here, an attacker tries to observe the system outcomes after maliciously inserting the faults which in turn may leak some useful information.

Decades of research on algorithms such as RSA and AES have produced mature understanding and standardized implementations for such vulnerabilities. What changes in the post-quantum context is that this accumulated knowledge does not transfer automatically.
Post-quantum candidates algorithms rely on computational primitives that differ substantially from those of classical algorithms. The side-channel behavior of these operations on constrained hardware is still poorly understood. New leakage patterns may emerge that have no precedent in the classical literature,  meaning  that secure implementation are still being developed.

This concern extends to quantum key distribution (QKD) protocols as well. BB84 @hwang2001eavesdropper and Ekert @ilic2007ekert are the pillars of QKD. They surpass classical cryptography because their security is based on the laws of physics (such as entanglement and Bell's theorem) rather than on the complexity of calculations of post-quantum cryptography (PQC). In the post-quantum landscape, they offer, in theory, inviolable protection against infinite computing power. 

However, even BB84 is vulnerable to side-channel attacks at device level. Device-independent QKD, whose foundations trace back to the work of Ekert, partially addresses this.
These class of  key-distribution schemes allow a stronger security at the price of more limited performances in terms of speed and rate @gill2022quantum.
==== Multi-Target Pre-Image Search <sec:multi_target>
The _parallel rho method_, proposed by van Oorschot and Wiener in 1994 @van1999parallel, is a  low computation algorithm that searches for cryptographic pre-images across multiple targets simultaneously using a mesh of processors. It poses a specific risk to symmetric schemes such as AES-128, as it can systematically search for valid keys through fast, parallelized computation. This attack highlights that symmetric cryptography is not inherently safe from quantum threats.

==== QKD Attack Strategies <sec:qkd_attacks>
QKD is often presented as theoretically secure, but this guarantee holds only under ideal conditions. Real implementations involve imperfect devices, finite signal exchanges, and channel noise, all of which can open exploitable gaps between the theoretical security proof and the actual protocol behavior.
QKD protocols are broadly divided into two families: 
- Discrete-variable (DV) protocols, such as BB84, encode information in individual qubits and are well suited for long-distance communication. 
- Continuous-variable (CV) protocols encode information in the amplitude and phase of light pulses, offering potentially higher key rates but greater sensitivity to channel noise, which limits their effective range.
Both families are subject to specific attack strategies @kumar2022securing. DV protocols are vulnerable to attacks, where an eavesdropper exploits the multi-photon nature of realistic light sources to extract key information undetected, as well as Trojan-horse and backflash attacks, which target the physical components of the communicating devices. CV protocols face threats to the local oscillator and saturation attacks on homodyne detectors, both of which can cause the parties to underestimate the information leaked to an eavesdropper. In each case, practical countermeasures exist, but they introduce additional complexity and are not always sufficient to fully close the gap between theoretical and real-world security.

=== Post-Quantum Cryptography <sec:pqc_solutions>
PQC is based on computational problems that are believed to be resistant to quantum attacks. Unlike traditional cryptographic paradigms, PQC does not depend on problems vulnerable to Shor’s algorithm (@sec:shor_algorithm). Instead, it leverages mathematical structures that remain computationally hard, even for quantum computers. The primary mathematical foundations of PQC are as follows.

==== Lattice-Based Cryptography <sec:lattice_based>
Lattice-based cryptography derives its security from difficult mathematical problems, such as the Learning With Errors (LWE) problem and the Shortest Vector Problem (SVP), both of which are NP-hard. These problems remain difficult for both classical and quantum computers. The National Institute
of Standards and Technology (NIST) has standardized Kyber @bos2018crystals, Dilithium @ducas2018crystals and Falcon @Falcon88:online, all of which are based on lattice structures.

Kyber (ML-KEM), standardized as FIPS-203 is a key encapsulation mechanism (KEM), based on a structured variant of LWE called Module-LWE. In practice, two parties can establish a shared secret by exchanging compact public keys and ciphertexts, with the noise acting as a computational barrier that prevents an eavesdropper from recovering the secret. Dilithium (ML-DSA), standardized as FIPS-204 is a digital signature scheme, builds on a related problem called Module-LWE and Module-SIS. Its signing procedure involves generating a response to a cryptographic challenge in a way that reveals nothing about the private key, while the verification step checks that the response is consistent with the public key and falls within a bounded range. This bound is what ties security to the hardness of finding short vectors in a lattice. Falcon, the third standardized scheme as FIPS-205, is also a signature algorithm and operates over lattices, offering smaller signature sizes than Dilithium at the cost of a more complex signing procedure. Among its parameter sets, Falcon-512 is particularly notable for its very low energy consumption, which makes it well suited for IoT.

==== Code-Based Cryptography <sec:code_based>
Code-based cryptography relies on the hardness of decoding random linear codes, a problem that has been studied for decades and is believed to be resistant to quantum attacks. The core idea is that introducing a controlled amount of errors into a codeword is easy, but recovering the original message, without knowledge of the secret, is computationally infeasible.

The most well-known scheme is McEliece @singh2019code, proposed in 1978, which uses error-correcting codes: the public key is a scrambled version of a structured code, and encryption consists of encoding a message and adding a fixed number of random errors. Only the party who knows the hidden structure of the code can efficiently correct those errors and recover the plaintext, while an adversary sees only what appears to be a random linear code.
The main drawback of code-based schemes is the size of the public keys, which can reach hundreds of kilobytes, a significant concern for IoT devices with limited memory. More compact code constructions variants such as BIKE and HQC, are under consideration by NIST.

==== Hash-Based Cryptography <sec:hash_based>
Hash-based cryptographic schemes derive their security entirely from the properties of cryptographic hash functions (i.e., collision resistance and preimage resistance), without relying on algebraic structure that quantum algorithms could exploit. This makes them one of the most understood families of post-quantum candidates. The only known quantum advantage in this domain comes from Grover's algorithm, which provides a quadratic speedup in brute-force search and can be compensated simply by doubling the output length of the hash function.

The main representative of this family is SPHINCS+ @bernstein2019sphincs, standardized by NIST as a digital signature scheme. It works by organizing a large number of one-time signature key pairs into a hypertree structure. Each layer authenticates the keys of the layer below using a hash-based signature scheme, repeatedly. Signing a message consists of selecting one of the one-time key pairs, using it to sign the message, and then providing an authentication path through the tree to the public root. Verification follows the same path in reverse.
Its security reduces directly to the properties of the underlying hash function, with no additional mathematical hardness assumptions required. The tradeoff is that signatures are relatively large (about 8 KB) compared to other post-quantum schemes, which can be a limiting factor in constrained IoT deployments.

==== Multivariate Cryptography
Multivariate cryptography is based on the difficulty of solving systems of multivariate quadratic equations over a finite field, a problem that is NP-hard in general and believed to resist quantum attacks.
Despite decades of study, the practical security of multivariate schemes has proven difficult to establish reliably. Several proposed constructions have been broken over time, often by attacks that exploit the specific algebraic structure rather than the hardness of the underlying problem. As a result, no multivariate scheme has yet been standardized by NIST.

==== Isogeny-Based Cryptography
Isogeny-based cryptography belongs to a family of post-quantum schemes based on problems from the mathematics of elliptic curves, but in a different way than classical cryptography. Its main attraction is the compactness of its keys, which are significantly smaller than those of most other post-quantum families, making it appealing in principle for IoT environments.
However, the computational cost is substantially higher than that of comparable schemes. In this set of schemes in 2022, SIKE, the main isogeny-based NIST candidate, was broken by a classical attack, highlighting the challenges of designing secure and efficient isogeny-based protocols. As of now, no isogeny-based scheme has been standardized.

=== Integration for the Developed Framework <sec:post_quantum_integration>
The framework developed in this work relies on MQTT and CoAP as its primary communication protocols, both of which depend on classical asymmetric cryptography for key exchange and authentication. TLS-secured MQTT sessions and DTLS handshakes in CoAP are vulnerable and would be broken easily by a quantum computer. A practical migration was studied as a future proposal to this framework.

==== MQTT Integration
For MQTT, the problem needs to be broken down into two distinct levels: the TLS handshake and the JWT authentication.

At the transport level, the TLS handshake relies on ECDH for key exchange and on RSA or ECDSA for certificate authentication, both of which are vulnerable. The mitigation is to replace ECDH with ML-KEM and adopt ML-DSA or Falcon-512 for certificate signatures. Also, a stategy involves using an hybrid approach, where classical and post-quantum key exchange are performed in parallel and their outputs combined: the session remains secure as long as either one holds. This is already supported in some TLS 1.3 implementations and represents a retro compatible approach with the existing infrastructure.

At the authentication level, the JWT presents a more complex challenge. Signing a token with ML-DSA produces a signature of approximately 2.4 KB, which brings the total token size above 3 KB. Falcon-512, standardized as FIPS 206, offers an interesting alternative: its signatures are roughly 700 bytes, reducing the total token size to aroung 1.5 KB, but comes with the tradeoff of a more complex signing procedure and higher computational requirements. Its Go support currently requires CGO through the Open Quantum Safe library @openquan60:online.
For deployments where even 1.5 KB is excessive, reference tokens offer a cleaner solution: the IdP signs and stores the token internally, returning only a compact opaque ID to the device. The broker validates the ID at connection time, without the full token ever traveling over the network. This approach is protocol-agnostic and compatible with any post-quantum signature scheme.

==== CoAP Integration
In CoAP, as we saw, we implemented DTLS in PSK mode. It uses AES-256, which is already quantum-resistant: Grover's algorithm reduces its security from 256 to 128 bits, which remains acceptable by current standards.
The vulnerability lies in the provisioning phase. If the PSK is distributed to the device over a classical channel, an adversary who has recorded the provisioning traffic can recover the PSK in the future and decrypt all subsequent sessions. 
The proposal is to use ML-KEM (FIPS 203) for the provisioning step of the PSK. Once the key is established, the DTLS session proceeds as normal with AES-256.
For devices that establish sessions frequently or cannot rely on static PSKs, KEMTLS is a more comprehensive alternative. By replacing the signature step in the DTLS handshake with ML-KEM, it avoids the overhead while still providing quantum-resistant key exchange. Since CoAP operates over UDP, where packet size directly affects fragmentation and reliability, the smaller footprint of ML-KEM compared to ML-DSA makes KEMTLS a more practical choice.
On the implementation side, ML-KEM is available in Go through the Cloudflare CIRCL library @cloudfla67:online without any external dependencies, making it the most accessible entry point for integrating post-quantum key establishment into the CoAP bridge.

=== Summary <sec:post_quantum_summary>
The integration of post-quantum cryptography into IoT networks is a complex challenge that needs dedicated research efforts to address the unique constraints of these environments. This urgency is intensified by the "_harvest now, decrypt later_" threat @mascelli2025harvest: adversaries can already be collecting encrypted IoT traffic today, storing it until quantum hardware matures enough to decrypt it retroactively. Since many IoT devices are long-lived and difficult to update, and often transmit persistently sensitive data, the window for action is open now rather than at some future point when quantum computers become operational. As discussed in @cap:intro, IoT devices are increasingly ubiquitous and their security is a priority. The development of efficient, secure and standardized post-quantum solutions for IoT is crucial to ensure the long-term viability of these networks.

== Firmware Update Mechanisms <sec:firmware_updates>

IoT devices updates is a fundamental operational requirement. Firmware Over-the-Air (FOTA) updates allow to patch security vulnerabilities, correct software and introduce new capabilities without physical access to each device. When the underlying transport is MQTT over TCP, this process is easier: the nature of TCP handles retransmission and ordering by design. When CoAP over UDP is used instead, FOTA becomes more complex, since UDP does not offers delivery guarantees, ordering and  native support for large payload.

=== Challenges

Several properties of UDP make firmware update challenging.
First, packets can be silently dropped by the network: any lost segment must be detected and requested again at the application level. Second, the Maximum Transmission Unit (MTU) is often very low, which means any binary must be fragmented before transmission. Third, UDP does not preserve packet order, so chunks may arrive out of sequence. Finally, constrained devices have limited RAM and flash memory, which discards large in-memory buffering that would solve the ordering problem.

=== CoAP Block-Wise Transfer
The foundational solution is defined in IETF RFC 7959 @RFC7959B63, which specifies block-wise transfers for CoAP and shifts reliability to the application layer.

The protocol introduces the `Block2` option for GET requests. When a device requests a firmware resource, it includes three parameters in this option: the block number (_NUM_), a flag indicating whether more blocks follow (_M_), and a size field (_SZX_).

The transfer follows a pull model. The device requests block 0; the server responds with the first chunk and sets M=1 to signal that more data is available. The device writes the received bytes to flash memory, then explicitly requests block 1. This cycle continues until the server returns a chunk with M=0, indicating the final block. Because each request is independent, a lost UDP packet only causes a single block to be retried, rather than forcing the entire transfer to restart. This design makes the process resilient and reliable without requiring any state to be maintained at the transport level.

=== Security and Metadata: the SUIT Architecture
Transferring bytes reliably is necessary but not sufficient. The device must also be able to verify that the received firmware is authentic, has not been tampered with and is compatible with its specific hardware. These concerns are addressed by the IETF SUIT architecture, defined in RFC 9019 and RFC 9124 @RFC9019A44 and @RFC9124A81, and further studied in the literature on secure OTA updates for constrained devices @zandberg2019.

The central concept of SUIT is the manifest: a small metadata file encoded in CBOR that the device downloads before the binary itself. The manifest contains the hardware and software identifiers the firmware is intended for, the URI from which the binary can be retrieved, any dependency requirements, a SHA-256 hash of the expected binary and a digital signature produced by the firmware author.

The update workflow proceeds in three steps: 
+ The device downloads and parses the manifest via CoAP. 
+ It then verifies the digital signature against a public key stored in its own secure storage. If the signature is valid and the hardware identifiers match, the device proceeds to download the firmware binary using CoAP block-wise transfers.
+ Once the final block is received, the binary hash is compared against the value in the manifest: if they match, the update is considered trustworthy and ready for installation.

This two-phase approach is efficient ans secure for constrained devices as the manifest is small and can be checked quickly.

=== Device Management: OMA LwM2M Object 5
While block-wise transfer and SUIT handle reliability and security of firmware updates, a production deployment also requires a standardized way for the backend to initiate, monitor and control the update process. This is the role of OMA LwM2M @OMATSLig99, a device management protocol built entirely on CoAP.
LwM2M organizes device capabilities into numbered objects. Object 5 is dedicated to firmware updates and defines four states that both the device and the server must follow. The states are: Idle (0), in which the device awaits instructions; Downloading (1), triggered when the server provides a package URI and the device begins fetching the binary; Downloaded (2), reached once the transfer is complete and the integrity checks have passed; and Updating (3), entered when the server issues the Update command, causing the device to apply the new firmware and reboot.

This standardized approach allows any management platform to query the current update state of a device, detect stalled transfers and trigger retries, without requiring proprietary logic on either side.

=== Integration for the Developed Framework

The infrastructure described in this thesis does not include a full LwM2M server stack; instead, it adopts a hybrid approach that preserves the relevant semantics of each standard while fitting the existing pipeline built around Traefik, the custom CoAP bridge, and the NATS message broker.
The proposed update flow proceeds as follows.
+ The backend publishes a notification to a dedicated NATS subject when a new firmware version is available. 
+ The CoAP gateway, which is subscribed to that subject, translates the event into a CoAP notification delivered to devices on a `/firmware/status` resource. 
+ Upon receiving the notification, each device issues a GET request to retrieve the SUIT manifest. The gateway serves the manifest, which the device then validates locally.
+ If validation succeeds, the device extracts the firmware URI from the manifest and begins a block-wise transfer to download the binary.
+ Once the transfer is complete and the hash matches the value in the manifest, the device proceed to update the firmware, completing the update cycle.

The same flow happens similarly for the MQTT counterpart, where the VerneMQ broker receives the update event and forwards it to subscribed devices on the same topic, along with the manifest.

== Extending Service-to-Service Authentication <sec:future_spiffe>

As discussed in @sec:m2m_communication, the current implementation addresses service-to-service authentication only at the bridge services, leaving the remaining components without mutual authentication. While this is acceptable for this work, in a production environment would require every internal service to be able to verify the identity and not trust blindly all the traffic incoming. The problem with conventional methods is credential management at scale. Static certificates have long lifetimes and must be manually rotated. Shared secrets must be distributed somehow and the provisioning mechanism itself becomes an attack surface. As the number of internal services grows, the operational burden of maintaining these credentials becomes significant. Also, such services form the core of the system, hence any compromise of their credentials can lead to severe consequences.

SPIFFE @SPIFFE, acronym of _Secure Production Identity Framework For Everyone_ addresses this by providing each running service, referred to as a workload, with a cryptographic identity document called SPIFFE Verifiable Identity Document (SVID). Rather than requiring a human operator to provision credentials, the SPIRE runtime agent attests the workload automatically by inspecting properties of its execution environment, such as its Kubernetes service account token or its process metadata on a virtual machine. From this attestation, SPIRE creates a short-lived X.509 certificate that encodes the workload's identity as a URI in the _Subject Alternative Name_ field, for example `spiffe://trust-domain/service/coap-bridge`. This certificate typically expires within minutes or hours and is rotated automatically before expiry, meaning that it does not need to be stored on disk or passed through environment variables.
Each service simply uses the certificate issued by its local SPIRE agent for both its server identity and its client identity when connecting to peers. The SPIRE trust bundle, which is the set of root certificates trusted within the deployment, is distributed and rotated centrally by the SPIRE server.

=== SPIRE Architecture

SPIFFE is the specification, while SPIRE (the SPIFFE Runtime Environment) is its reference implementation. The system is composed of two components that work together to issue and maintain workload identities.

The _SPIRE Server_ is the central trust authority. It maintains the root CA used to sign all SVIDs, stores the registration entries that define which workloads exist and what identity each should receive. Also, it exposes a Workload API that agents can call to request certificates. There is typically one SPIRE Server per trust domain, or a cluster of more nodes if high avaibilty in required. The server never communicates with workloads directly.

The _SPIRE Agent_ runs on every node in the infrastructure. First it performs _node attestation_: when the agent starts, it must prove to the SPIRE Server that the node it runs on is a legitimate part of the dsystem, using instance metadata. Once the server accepts this proof, the agent receives the trust bundle and is authorized to issue SVIDs to local workloads.

When a service starts and requests an SVID, it connects to the local agent over a Unix domain socket. The agent does not trust the request blindly: it performs _workload attestation_ by inspecting kernel properties of the requesting process that the process itself cannot forge, since they are managed by the OS. These include the Unix UID of the process, the path of the executed binary, or in a Kubernetes environment, the pod name and its labels. The agent then compares these properties against the registration entries received by the SPIRE Server, which specify which combinations of properties correspond to which SPIFFE identity. For example, an entry might state that any process with UID 1001 executed from `/usr/bin/coap-bridge` is entitled to the identity `spiffe://myproject/coap-bridge`. Only if the process matches a registered entry the agent issue the corresponding certificate.

This design has an important security property: the SPIRE Server is never exposed directly to workloads or where application services run. The SPIRE Agent acts as a local intermediary, ensuring that the root CA material is kept in a single and protected location.


== Other Integrations <sec:other_integrations>
Beyond security, firmware updates and service-to-service authentication, there are other potential extensions.
One area of interest is the integration of physical isolation techniques. As described in @sec:multi-tenancy, the current implementation adopts logical isolation to separate tenants within the same physical infrastructure. While this approach is widely adopted and operationally convenient, physical isolation can provide stronger security guarantees by completely separating the hardware resources of different tenants. This is particularly relevant for critical infrastructure or sensitive data processing, where a misconfiguration could expose one tenant's data to another. In practice, physical isolation can be achieved by deploying separate database instances and authentication services per tenant. Given that these components are already containerized, the operational overhead should be relatively low, and the cost is close to zero in terms of additional infrastructure complexity.

A second direction regards the definition of a proper API layer and a UI dashboard. The current system exposes its functionality primarily at the infrastructure level, with no dedicated interface for tenant administrators to manage their own devices and users. A natural extension would be to design a set of REST APIs that expose the core operations, such as device registration, user management, firmware update scheduling and usage monitoring and so on, in an authenticated way. Built on these APIs, a web-based dashboard would allow tenant administrators to perform usual operations without direct access to the infrastructure. This would close the loop between the infrastructure  work described in this thesis and the user experienceo of production deployment.


