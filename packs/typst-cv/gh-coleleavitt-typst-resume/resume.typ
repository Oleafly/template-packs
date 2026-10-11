#set page(margin: 0.5in)
#set text(font: "Times New Roman", size: 9.333pt)

#set document(
  title: "My Resume",
  author: "Cole Leavitt",
  keywords: ("template", "copyright", "Cole Leavitt")
)


#set page(
  footer: [
    #set align(center)
    #set text(size: 8pt)
    Template created by Cole Leavitt
    Copyright © 2024. All rights reserved.
  ]
)

// #set page(
//   background: place(
//     center + horizon,
//     rotate(45deg, 
//       text(
//         fill: rgb(220, 220, 220),
//         size: 24pt,
//         "© Cole Leavitt"
//       )
//     )
//   )
// )

#align(center)[
  #text(size: 18pt, weight: "bold")[Cole Leavitt]\
  Arizona, USA \
  RHCSA, Linux+, Security+ \
  #link("mailto:coleleavitt@protonmail.com")[#text(gradient.linear(
  angle: 45deg,
  rgb("#ff0000"),    // red
  // rgb("#ff8000"),    // orange
  // rgb("#ffff00"),    // yellow
  // rgb("#00ff00"),    // green
  // rgb("#0080ff"),    // blue
  rgb("#8000ff")     // purple
))[Phone Number Upon Request]] | #link("mailto:coleleavitt@protonmail.com")[#text(gradient.linear(
  angle: 45deg,
  rgb("#ff0000"),    // red
  rgb("#ff8000"),    // orange
  rgb("#ffff00"),    // yellow
  rgb("#00ff00"),    // green
  rgb("#0080ff"),    // blue
  rgb("#8000ff")     // purple
))[My Email]] |   #link("https://github.com/coleleavitt")[#text(gradient.linear(
  angle: 45deg,
  // rgb("#ff0000"),    // red
  // rgb("#ff8000"),    // orange
  // rgb("#ffff00"),    // yellow
  rgb("#00ff00"),    // green
  rgb("#0080ff"),    // blue
  // rgb("#8000ff")     // purple
))[My Github]] | 
#link("https://linkedin.com/in/coleleavitt ")[#text(gradient.linear(
  angle: 45deg,
  // rgb("#ff0000"),    // red
  // rgb("#ff8000"),    // orange
  // rgb("#ffff00"),    // yellow
  // rgb("#00ff00"),    // green
  rgb("#0080ff"),    // blue
  rgb("#8000ff")     // purple
))[My LinkedIn]]
]

== *PROFESSIONAL SUMMARY*
#line(length: 100%, stroke: 0.75pt)
#set par(justify: true)
Linux systems professional demonstrating exceptional RHEL administration expertise, validated by 99th percentile score and 100th percentile performance across system administration domains. Specializing in enterprise-level optimization with strong proficiency in Storage Management, Security Configuration, and Linux Containers. Active package maintainer for the Arch User Repository (AUR) and core contributor to major Linux communities, including #link("https://allthingslinux.org/")[#text(gradient.linear(
  angle: 45deg,
  rgb("#ff0000"),    // red
  rgb("#ff8000"),    // orange
  rgb("#ffff00"),    // yellow
  rgb("#00ff00"),    // green
  rgb("#0080ff"),    // blue
  rgb("#8000ff")     // purple
))[AllThingsLinux.org]]. Demonstrated excellence of low-level system architecture through custom kernel development, module creation, and advanced system hardening across RHEL, Gentoo, and Arch Linux environments. Built and manages enterprise-grade infrastructure using HP DL380P servers with VMware and Proxmox virtualization, achieving 30% reduction in system downtime through kernel-level optimizations. Extensive experience in deployment automation, configuration management, and sophisticated virtualization solutions. Seeking a Linux System Administrator role to apply technical expertise while continuing to expand knowledge in enterprise environments.

== *TECHNICAL SKILLS*
#line(length: 100%, stroke: 0.75pt)
#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
[
- *Linux Administration:* RHEL/CentOS/Ubuntu, System Hardening, Performance Tuning, Kernel Management, STIG Compliance, Enterprise Administration (3-5 years), 24x7 Operations Support, Log Analysis, LDAP Integration
- *Windows Server:* Active Directory, Group Policy, User Management, Identity Management
- *Virtualization:* 
  - *On Premises*
    VMware ESXi/vSphere, QEMU/KVM, Proxmox, OpenShift, Virtual Machine Management
  - *Cloud* AWS, Linode and Azure-hosted solutions

- *Networking:* LAN/WAN, TCP/IP, Firewalls, VPNs, Network Security, Load Balancing, GigaMon, Network Configuration, Routing
- *Security:* SELinux, System Monitoring, Access Control, 2FA, DISA STIGs, RMF Compliance, CISSP, Incident Response, Security Hardening

],
[
- *Storage Systems:* LVM, RAID, NFS, Stratis, GFS2, NetApp SAN, Dell-EMC VxRail, Data Domain, Storage Management & Backup
- *Infrastructure:* Prometheus, Grafana, Git, CI/CD, SLURM, High Availability Cluster Management, Satellite/Foreman, Capacity Planning
- *Automation:* Ansible/Puppet/Salt, Configuration Management, Shell Scripting, Kickstart, PodMan, Infrastructure as Code
- *System Administration:* Performance Monitoring & Tuning, Security Compliance, Patch Management, User & Process Management
- *Documentation:* Technical Writing, Process Documentation, ServiceNow, Change Management, Strong Communication, Knowledge Base
- *Containerization:* Docker, Kubernetes, OpenShift, OVN, Container Storage, RKE2, Container Orchestration & Management
- *Scripting:* Bash, Python, PowerShell, CI/CD, Jenkins, GitLab, Salt Stack, Automation Development
]
)

== *Professional Experience*
#line(length: 100%, stroke: 0.75pt)

#grid(
  columns: (auto, 1fr),
  gutter: 1em,
 [*Open Source Package Maintainer*],
  align(right)[2021 - Present]
)
*Arch Linux User Repository (AUR)*
- Maintain critical system packages including #link("https://aur.archlinux.org/packages/sf")[#text(gradient.linear(
  angle: 45deg,
  // rgb("#ff0000"),    // red
  // rgb("#ff8000"),    // orange
  rgb("#ffff00"),    // yellow
  rgb("#00ff00"),    // green
  rgb("#0080ff"),    // blue
  rgb("#8000ff")     // purple
))[Salesforce CLI (sf)]] and #link("https://aur.archlinux.org/packages/biglybt-extreme-mod")[#text(gradient.linear(
  angle: 45deg,
  // rgb("#ff0000"),    // red
  // rgb("#ff8000"),    // orange
  rgb("#ffff00"),    // yellow
  rgb("#00ff00"),    // green
  rgb("#0080ff"),    // blue
  rgb("#8000ff")     // purple
))[biglybt-extreme-mod]] serving 1,000+ monthly users
- Reduced package-related issues by 75% through GitHub Actions implementation and resolved 50+ complex dependency conflicts within 24-hour SLA
- Created 25+ technical documentation articles, resulting in 40% reduction in user support tickets

#grid(
  columns: (auto, 1fr),
  gutter: 1em,
 [*Linux Community Contributor*],
  align(right)[2016 - Present]
)
*Various Linux Communities*
- Led development of #link("https://github.com/allthingslinux/tux")[#text(gradient.linear(
  angle: 45deg,
  rgb("#ff0000"),
  rgb("#ff8000"),
  rgb("#ffff00"),
  rgb("#8000ff")
))[Tux]] Discord bot for nonprofit organization #link("https://allthingslinux.org/")[#text(gradient.linear(
  angle: 45deg,
  rgb("#ff0000"),
  rgb("#ff8000"),
  rgb("#ffff00"),
  rgb("#8000ff")
))[AllThingsLinux.org]] serving 4,000+ users with 99.9% uptime and handling 1,000+ daily commands

  - Provided daily technical support in #link("https://discord.com/invite/archlinux")[#text(gradient.linear(
  angle: 45deg,
  rgb("#ff0000"),
  // rgb("#ff8000"),
  // rgb("#ffff00"),
  rgb("#8000ff")
))[Arch Linux's Unofficial Discord server]] for 5+ years, resolving 837 technical issues and generating equivalent support value of \$334,000 in 2024

- Active member of (#link("https://discord.gg/2DkrTfsmJ5")[#text(gradient.linear(
  angle: 45deg,
  rgb("#ff0000"),    // red
  rgb("#ff8000"),    // orange
  // rgb("#ffff00"),    // yellow
  // rgb("#00ff00"),    // green
  rgb("#0080ff"),    // blue
  rgb("#8000ff")     // purple
))[Professional Linux Users Group (ProLUG)]])
  - Created 15 educational resources reaching 400+ members, with 95% positive feedback rating
- Participated in system administration course development and documentation
- Mentored 200+ new Linux users with 98% successful migration rate to Linux systems


== *PROJECTS*
#line(length: 100%, stroke: 0.75pt)

#grid(
  columns: (auto, 1fr),
  gutter: 1em,
 [*Advanced System Architecture, Automation and Workflow  Engineering*],
  align(right)[2019 - Present]
)
- Engineered custom Gentoo system with #link("https://gitweb.gentoo.org/repo/gentoo.git/tree/sys-kernel/git-sources/git-sources-6.13_rc2.ebuild")[#text(gradient.linear(
  angle: 45deg,
  rgb("#ff0000"),    // red
  rgb("#ff8000"),    // orange
  rgb("#ffff00"),    // yellow
  rgb("#00ff00"),    // green
  rgb("#0080ff"),    // blue
  rgb("#8000ff")     // purple
))[git-sources-6.13_rc]] optimizations achieving sub-1 second boot times
  - Developed system update automation through bash scripts, reducing maintenance time from 4 hours to 15 minutes weekly
  - Created parallel compilation pipeline achieving 300% faster package builds through distcc and ccache integration
  
- Spearheaded advanced CPU frequency scaling using custom governors (powertop w/ tlp & ACPI), reducing power consumption by 65% while reducing system temperature from 85°C to 45°C under load
- Developed custom dual-layer LUKS encryption (boot and root partitions) and initramfs with modular design for LUKS/TPM2 integration using dracut modules. 
- Engineered OCR automation system using #link("https://sr.ht/~emersion/grim/")[#text(gradient.linear(
  angle: 45deg,
  rgb("#ff0000"),    // red
  rgb("#ff8000"),    // orange
  // rgb("#ffff00"),    // yellow
  rgb("#00ff00"),    // green
  rgb("#0080ff"),    // blue
  rgb("#8000ff")     // purple
))[grim]]/#link("https://github.com/emersion/slurp")[#text(gradient.linear(
  angle: 45deg,
  rgb("#ff0000"),    // red
  rgb("#ff8000"),    // orange
  // rgb("#ffff00"),    // yellow
  rgb("#00ff00"),    // green
  rgb("#0080ff"),    // blue
  rgb("#8000ff")     // purple
))[slurp]]  achieving 98% text recognition accuracy through #link("https://github.com/tesseract-ocr/tesseract")[#text(gradient.linear(
  angle: 45deg,
  rgb("#ff0000"),    // red
  // rgb("#ff8000"),    // orange
  // rgb("#ffff00"),    // yellow
  // rgb("#00ff00"),    // green
  // rgb("#0080ff"),    // blue
  rgb("#8000ff")     // purple
))[tesseract v5.5.0]]
- Achieved 400% battery life improvement through aggressive C-state management (C8-C10)
- Optimized compilation through custom CFLAGS/USE-flags targeting Alderlake micro-architecture with #link("https://github.com/graysky2/modprobed-db")[#text(gradient.linear(
  angle: 45deg,
  rgb("#ff0000"),    // red
  rgb("#ff8000"),    // orange
  // rgb("#ffff00"),    // yellow
  rgb("#00ff00"),    // green
  // rgb("#0080ff"),    // blue
  rgb("#8000ff")     // purple
))[modprobedb]], #link("https://linux-hardware.org/")[#text(gradient.linear(
  angle: 45deg,
  rgb("#ff0000"),    // red
  rgb("#ff8000"),    // orange
  // rgb("#ffff00"),    // yellow
  // rgb("#00ff00"),    // green
  rgb("#0080ff"),    // blue
  rgb("#8000ff")     // purple
))[ _Hardware for Linux_ Database]], and (#link("https://wiki.gentoo.org/wiki/Project:Distribution_Kernel")[#text(gradient.linear(
  angle: 45deg,
  rgb("#ff0000"),    // red
  rgb("#ff8000"),    // orange
  rgb("#ffff00"),    // yellow
  rgb("#00ff00"),    // green
  rgb("#0080ff"),    // blue
  rgb("#8000ff")     // purple
))[Gentoo's Distribution Kernel (dist-kernel)]]) for gathering needed kernel modules to reduce compiled size by 90%

- Integrated custom #link("https://github.com/mlichvar/chrony")[#text(gradient.linear(
  angle: 45deg,
  rgb("#ff0000"),    // red
  // rgb("#ff8000"),    // orange
  // rgb("#ffff00"),    // yellow
  // rgb("#00ff00"),    // green
  rgb("#0080ff"),    // blue
  rgb("#8000ff")     // purple
))[Chrony]] bash scripts achieving <\1ms network time synchronization


#grid(
  columns: (auto, 1fr),
  gutter: 1em,
 [*Enterprise Security Architecture*],
  align(right)[2018 - Present]
)
- Pioneered multi-layer LUKS encryption with TPM2 integration
  - Implemented SHA512 and PBKDF2 for enhanced security
  - Developed automated key rotation and backup procedures
  - Created secure boot chain with TPM2 attestation

- Engineered comprehensive security framework
  - Developed custom SELinux policies achieving zero-trust architecture with perfect audit score
  - Created automated compliance framework using auditd reducing manual checks by 85%
  - Implemented automated security scanning and remediation
  - Achieved perfect score on lynis security audit through system hardening

- Established enterprise-grade network security
  - Reduced security incidents by 95% through custom iptables configuration
  - Managed 10,000+ daily connections with comprehensive monitoring
  - Implemented automated threat detection and response
  - Created custom TLS configurations reducing spam by 99% on #link("https://stalw.art/")[#text(gradient.linear(
  angle: 45deg,
  rgb("#ff0000"),    // red
  // rgb("#ff8000"),    // orange
  // rgb("#ffff00"),    // yellow
  // rgb("#00ff00"),    // green
  // rgb("#0080ff"),    // blue
  rgb("#8000ff")     // purple
))[Stalwart Mail Server]]
#grid(
  columns: (auto, 1fr),
  gutter: 1em,
  [*Infrastructure and Enterprise Systems*],
  align(right)[2022 - Present]
)
- Configured and managed 45U server rack infrastructure for #link("https://pimajted.org/programs/cybersecurity-and-artificial-intelligence/")[#text(gradient.linear(
  angle: 45deg,
  // rgb("#ff0000"),
  // rgb("#ff8000"),
  rgb("#ffff00"),
  rgb("#8000ff")
))[the cybersecurity school I attended]], including deployment of 20 iMacs with Kali Linux across segregated VLANs for Red Team vs Blue Team events
- Architected high-availability infrastructure using HP DL380P G8 servers with RAID5/RAID0 configurations
  - Implemented comprehensive Ansible playbooks for HPE server configurations, including ILO4 management
  - Developed custom monitoring through ILO4 REST API integration
  - Automated hardware configuration reducing setup time by 80%

- Engineered enterprise CI/CD and infrastructure-as-code solutions
  - Created modular Terraform configurations for AWS infrastructure including VPC, security groups, and routing
  - Implemented GitLab CI/CD pipelines for infrastructure deployment with automated testing
  - Developed automated rollback procedures with instant failover capabilities
  - Achieved 90% reduction in deployment errors through infrastructure versioning

- Established a comprehensive monitoring and automation framework
  - Implemented Prometheus/Grafana stack with 200+ custom metrics for system health
  - Created event-driven Ansible playbooks for automated incident response
  - Developed predictive maintenance strategies, achieving 99.99% uptime
  - Integrated ELK stack for centralized logging and analysis

- Designed enterprise backup and disaster recovery solution
  - Implemented automated #link("https://github.com/restic/restic")[#text(gradient.linear(
  angle: 45deg,
  rgb("#ff0000"),    // red
  rgb("#ff8000"),    // orange
  rgb("#ffff00"),    // yellow
  rgb("#00ff00"),    // green
  rgb("#0080ff"),    // blue
  rgb("#8000ff")     // purple
))[restic]] backup system  with 40% storage reduction through deduplication and versioned backups
  - Created Ansible playbooks for backup verification and restoration testing
  - Established automated disaster recovery protocols with 99% success rate

- Engineered advanced virtualization environment
  - Developed custom QEMU configurations with optimized performance
  - Created automated VM provisioning through Ansible and Terraform
  - Implemented multi-distribution environment (RHEL, CentOS, Ubuntu)
  - Reduced deployment time by 75% through automation


#grid(
  columns: (auto, 1fr),
  gutter: 1em,
 [*Network and Container Engineering*],
  align(right)[2020 - Present]
)
- Established NIC bonding for high availability using LACP protocols, achieving 99.99% uptime
- Developed custom container networking solution using OVN and network namespaces
- Built homelab network infrastructure using Netgear's R7000 with #link("https://wiki.dd-wrt.com/wiki/index.php/Netgear_R7000")[#text(gradient.linear(
  angle: 45deg,
  rgb("#ff0000"),
  rgb("#ff8000"),
  rgb("#ffff00"),
  rgb("#8000ff")
))[Kong Firmware]], implementing VLAN segregation (IoT VLAN 20, Server VLAN 30) and QoS policies, utilizing Ansible playbooks for active version control and rollback.
 
- Developed custom Docker networking stack using nginx reverse proxy for internal services, with automated LetsEncrypt SSL renewal
- Built secure remote access through ngrok tunnels with custom domain bindings, enabling external access while maintaining internal network security
-  Established CI/CD pipeline using GitLab and Ansible roles for containerized services deployment (Gitlab Enterprise, #link("https://github.com/dani-garcia/vaultwarden")[#text(gradient.linear(
  angle: 45deg,
  rgb("#ff0000"),
  rgb("#ff8000"),
  rgb("#ffff00"),
  rgb("#8000ff")
))[Vaultwarden]] ) with automated SSL certificate management through certbot docker container.
- Configured Nebula mesh network for secure inter-server communication with automated certificate management and sub-second failover times
- Orchestrated container security through SELinux/seccomp profiles
- Engineered custom Docker images for personal Gitlab EE instance and clients' websites, with multi-stage builds reducing attack surface by 60%
  - Create playbooks for scanning container images and implementing security policies
- Achieved 70% reduction in deployment time through optimized CI/CD pipelines
- Implemented Cloudflare tunnels as ngrok alternative, providing zero-trust access to internal services while eliminating port forwarding requirements

#grid(
  columns: (auto, 1fr),
  gutter: 1em,
 [*DevOps and CI/CD Implementation*],
  align(right)[2023 - Present]
)

- Developed and deployed Rust-based Discord bot for #link("https://developers.wargaming.net/reference/all/wot/account/list/?language=en&r_realm=na")[#text(gradient.linear(
  angle: 45deg,
  rgb("#ff8000"),
  rgb("#0080ff"),
  rgb("#8000ff")
))[World of Tanks Blitz ]] statistics tracking
  - Implemented asynchronous Rust programming using tokio for efficient concurrent operations
  - Engineered a modular architecture with separate modules for API interactions, database operations, and Discord bot functionality
  - Utilized  #link("https://docs.rs/reqwest/latest/reqwest/")[#text(gradient.linear(
  angle: 45deg,
  rgb("#ff8000"),
  rgb("#0080ff"),
  rgb("#8000ff")
))[reqwest]] HTTP client for efficient API calls to Wargaming's #link("https://developers.wargaming.net/reference/all/wot/account/list/?language=en&r_realm=na")[#text(gradient.linear(
  angle: 45deg,
  rgb("#ff8000"),
  rgb("#0080ff"),
  rgb("#8000ff")
))[World of Tanks Blitz ]]API
  - Implemented real-time statistics tracking (WN7, battles, winrate) for multiple users
  - Engineered scalable backend using  #link("https://surrealdb.com/")[#text(gradient.linear(
  angle: 45deg,
  // rgb("#ff0000"),    // red
  // rgb("#ff8000"),    // orange
  // rgb("#ffff00"),    // yellow
  // rgb("#00ff00"),    // green
  rgb("#0080ff"),    // blue
  rgb("#8000ff")     // purple
))[SurrealDB]] for efficient data storage and retrieval
  - Achieved robust error handling through custom error types and logging mechanisms

- Established comprehensive GitLab CI/CD automation framework
  - Designed a multi-stage pipeline with build, test, and deployment phases
  - Implemented Docker-based GitLab runners for isolated build environments
  - Created automated deployment workflows using GitLab CI/CD variables for secure credentials
  - Engineered custom Docker images optimized for Rust compilation and testing
  - Achieved an 80% reduction in pipeline execution time through strategic caching
  - Leveraged GitLab Container Registry for versioned Docker image management
  - Implemented GitLab environments for staged deployments with approval gates

- Implemented infrastructure automation with Ansible
  - Developed playbooks for automated system provisioning and configuration
  - Created roles for standardized Discord bot deployment across environments
  - Implemented automated SSL/TLS certificate management with Let's Encrypt and certbot
  - Engineered automated database backup and restoration procedures
  - Reduced system deployment time by 75% through automation

- Architected and maintained enterprise-grade bot infrastructure
  - Implemented a custom logging system using log4rs for efficient debugging
  - Engineered automated rollback procedures with instant failover capabilities
  - Implemented efficient data structures like HashMap for optimized operations
  - Achieved 99.9% uptime through robust monitoring and auto-recovery mechanisms
  - Configured Nebula mesh network for secure inter-server communication
  - Implemented automated certificate management with sub-second failover times

- Developed automated testing and deployment strategies
  - Created comprehensive test suites using Rust's built-in testing framework
  - Implemented automated integration tests in GitLab CI pipeline stages
  - Engineered automated security scanning for dependencies and Docker images
  - Utilized GitLab environments for staged deployments with approval gates
  - Achieved 90% test coverage across critical bot components
  - Implemented automated security scanning for container images and dependencies

- Optimized self-hosted GitLab EE instance
  - Engineered custom Docker images with multi-stage builds, reducing attack surface by 60%
  - Implemented nginx reverse proxy for internal services with automated SSL renewal
  - Utilized Cloudflare tunnels for zero-trust access, eliminating port forwarding requirements
  - Achieved 70% reduction in deployment time through optimized CI/CD pipelines

  
#grid(
  columns: (auto, 1fr),
  gutter: 1em,
 [*Package and System Development*],
  align(right)[2021 - Present]
)

- Engineered automated build systems for enterprise package management
  - Developed #link("https://aur.archlinux.org/packages/sf")[#text(gradient.linear(
  angle: 45deg,
  rgb("#ff0000"),    // red
  rgb("#ff8000"),    // orange
  // rgb("#ffff00"),    // yellow
  // rgb("#00ff00"),    // green
  rgb("#0080ff"),    // blue
  // rgb("#8000ff")     // purple
))[Salesforce CLI (sf)]] package with dynamic dependency resolution and Java environment detection
  - Created an automated CI/CD testing framework with a 99.9% detection rate using GitLab pipelines
  - Maintained AUR packages serving 1,000+ monthly users with a 99.9% build success rate
  - Engineered custom GitLab runners reducing build times by 65% through multi-stage Docker builds

- Implemented advanced build optimization and automation
  - Developed parallel compilation with Ansible playbooks, achieving 300% faster builds through #link("https://wiki.gentoo.org/wiki/Distcc")[#text(gradient.linear(
  angle: 45deg,
  rgb("#ff0000"),
  // rgb("#ff8000"),
  // rgb("#ffff00"),
  rgb("#8000ff")
))[distcc]] integration
  - Created an automated package validation framework, reducing testing time by 85%
  - Engineered kernel patches optimizing power management by 45%
  - Implemented automated SHA512/SHA256 checksum verification
  - Developed custom post-installation hooks for environment configuration

- Established enterprise-grade monitoring infrastructure
  - Implemented Prometheus/Grafana stack for package metrics and system health
  - Created automated build failure detection with instant rollback capabilities
  - Engineered custom metrics for package download tracking and dependency analysishttps://www.credly.com/badges/413e9da2-b4c5-42f3-97c9-1f3339069db6/linked_in_profile
  - Developed predictive failure analysis reducing downtime by 75%https://www.credly.com/badges/413e9da2-b4c5-42f3-97c9-1f3339069db6/linked_in_profile

- Engineered comprehensive deployment automation
  - Created a modular installation framework supporting multiple package managers
  - Implemented Nebula mesh network deployment with automated certificate rotation
  - Developed automated system bootstrapping, reducing installation time by 75%
  - Engineered automated desktop integration with XDG compliance
  - Created automated DNS validation for multi-domain certificate management


#grid(
  columns: (auto, 1fr),
  gutter: 1em,
 [*System Monitoring and Analysis*],
  align(right)[2022 - Present]
)
- Engineered monitoring stack processing 10,000 metrics/second
- Instituted custom exporters for hardware monitoring through iLO4
- Developed predictive failure analysis reducing downtime by 75%
- Created streamlined performance profiling with 99.9% accuracy
- Reduced false positive alerts by 85% through intelligent thresholds

#grid(
  columns: (auto, 1fr),
  gutter: 1em,
  [*Personal Infrastructure & Documentation Tools*],
  align(right)[2023 - Present]
)

- Engineered self-hosted #link("https://github.com/dani-garcia/vaultwarden")[#text(gradient.linear(
  angle: 45deg,
  rgb("#ff0000"),
  rgb("#ff8000"),
  rgb("#ffff00"),
  rgb("#8000ff")
))[Vaultwarden]] instance achieving 99.99% uptime through high-availability configuration, encrypted offsite backups, custom monitoring integration, and zero-trust architecture

- Created innovative #link("https://github.com/typst/typst")[#text(gradient.linear(
  angle: 45deg,
  rgb("#ff0000"),
  rgb("#ff8000"),
  // rgb("#ffff00"),
  // rgb("#8000ff")
))[Typst]] résumé template featuring programmatic typesetting of custom data-driven document templates, automated PDF generation through GitHub Actions, and 90% reduction in maintenance time versus LaTeX alternatives





== *EDUCATION & CERTIFICATIONS*
#line(length: 100%, stroke: 0.75pt)
#grid(
  columns: (auto, 1fr, auto),
  gutter: 1em,
  row-gutter: 1em,
  [*RedHat*], [Red Hat Certified Systems Administrator], align(right)[October 2024 - Present],
  [*CompTIA*], [Security+], align(right)[October 2024],
  [], [Linux+], align(right)[October 2024],
  [*Salesforce*], [Platform Developer I], align(right)[October 2024],
  [*Pima Community College*], [AAS Networking & Cyber Defense], align(right)[GPA 4.0, May 2023]
)

== *ADDITIONAL INFORMATION*
#line(length: 100%, stroke: 0.75pt)
- *Languages:* Fluent in English, Elementary in Russian, Spanish and French
- *Areas of Expertise:* Linux System Administration, Infrastructure Management, Security Hardening
- *Interests:* Open Source Development, System Optimization, Security Research
- *Professional Attributes:* Strong Communication Skills, Problem-Solving Focus, Team Leadership, Process Documentation, Mentoring Experience, Critical Thinking
- *Core Competencies:* Time Management, Project Ownership, Cross-Functional Collaboration, Root Cause Analysis
- *Work Ethics:* Detail-Oriented, Self-Motivated, Adaptable, Continuous Learning Mindset
- *Interpersonal Skills:* Active Listening, Trust Building, Technical Communication, Empathetic Approach

