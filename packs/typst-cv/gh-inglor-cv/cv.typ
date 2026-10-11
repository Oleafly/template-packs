// CV — converted from a moderncv "banking" style LaTeX template to Typst.
// Build: typst compile cv.typ

#let accent = black

// ---------------------------------------------------------------------------
// Personal information
// ---------------------------------------------------------------------------
#let firstname = "Leonidas"
#let familyname = "Spyropoulos"
#let mobile = "+44(0)7732702059"
#let email = "leonidas@spyropoulos.eu"
#let linkedin = "leonidas-spyropoulos"
#let github = "inglor"
#let extrainfo = "OpenPGP 0x59E43E106B247368"

// ---------------------------------------------------------------------------
// Document setup
// ---------------------------------------------------------------------------
#set document(title: firstname + " " + familyname + " — CV", author: firstname + " " + familyname)
#set page(paper: "a4", margin: (x: 1.8cm, y: 1.6cm))
#set text(font: ("Helvetica", "Arial", "DejaVu Sans"), size: 9.5pt, fill: rgb("#333333"))
#set par(justify: false, leading: 0.5em)
#set list(spacing: 0.5em, indent: 0.4em)

// ---------------------------------------------------------------------------
// Icons (inline SVG — keeps the file self-contained, no extra fonts needed)
// ---------------------------------------------------------------------------
#let icon-color = "#666666"
#let icon-phone = "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'><path fill='" + icon-color + "' d='M6.62 10.79c1.44 2.83 3.76 5.14 6.59 6.59l2.2-2.2c.27-.27.67-.36 1.02-.24 1.12.37 2.33.57 3.57.57.55 0 1 .45 1 1V20c0 .55-.45 1-1 1-9.39 0-17-7.61-17-17 0-.55.45-1 1-1h3.5c.55 0 1 .45 1 1 0 1.25.2 2.45.57 3.57.11.35.03.74-.25 1.02l-2.2 2.2z'/></svg>"
#let icon-email = "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'><path fill='" + icon-color + "' d='M0 4v16h24V4H0zm21.518 2L12 13.713 2.482 6h19.036zM2 7.183l10 8.104 10-8.104V18H2V7.183z'/></svg>"
#let icon-linkedin = "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'><path fill='" + icon-color + "' d='M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z'/></svg>"
#let icon-github = "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'><path fill='" + icon-color + "' d='M12 .297c-6.63 0-12 5.373-12 12 0 5.303 3.438 9.8 8.205 11.385.6.113.82-.258.82-.577 0-.285-.01-1.04-.015-2.04-3.338.724-4.042-1.61-4.042-1.61C4.422 18.07 3.633 17.7 3.633 17.7c-1.087-.744.084-.729.084-.729 1.205.084 1.838 1.236 1.838 1.236 1.07 1.835 2.809 1.305 3.495.998.108-.776.417-1.305.76-1.605-2.665-.3-5.466-1.332-5.466-5.93 0-1.31.465-2.38 1.235-3.22-.135-.303-.54-1.523.105-3.176 0 0 1.005-.322 3.3 1.23.96-.267 1.98-.399 3-.405 1.02.006 2.04.138 3 .405 2.28-1.552 3.285-1.23 3.285-1.23.645 1.653.24 2.873.12 3.176.765.84 1.23 1.91 1.23 3.22 0 4.61-2.805 5.625-5.475 5.92.42.36.81 1.096.81 2.22 0 1.606-.015 2.896-.015 3.286 0 .315.21.69.825.57C20.565 22.092 24 17.592 24 12.297c0-6.627-5.373-12-12-12'/></svg>"

// Render an inline SVG icon, vertically aligned with the surrounding text.
#let ico(svg) = box(baseline: 0.14em, height: 0.85em, image(bytes(svg), format: "svg"))

// ---------------------------------------------------------------------------
// Building blocks
// ---------------------------------------------------------------------------

// Section heading with a thin rule, mimicking moderncv \section
#let section(title) = {
  v(0.5em)
  block(below: 0.5em)[
    #text(size: 13pt, weight: "bold", fill: accent, upper(title))
    #v(-0.4em)
    #line(length: 100%, stroke: 0.5pt + rgb("#aaaaaa"))
  ]
}

#let subsection(title) = {
  block(above: 0.6em, below: 0.4em)[
    #text(size: 11pt, weight: "bold", fill: accent)[#title]
  ]
}

// A dated entry: dates in the left hints column, content on the right.
#let cventry(dates, title, org, location, role, body) = {
  block(above: 0.55em, below: 0.3em, breakable: false)[
    #grid(
      columns: (3.2cm, 1fr),
      column-gutter: 0.6em,
      align(right + top)[#text(fill: rgb("#666666"))[#dates]],
      [
        #if title != "" or org != "" {
          text(weight: "bold")[#title]
          if title != "" and org != "" [ — ]
          smallcaps(org)
          if location != "" {
            h(1fr)
            text(fill: rgb("#666666"))[#location]
          }
          if role != "" {
            linebreak()
            emph(role)
          }
          linebreak()
        }
        #body
      ],
    )
  ]
}

// An item with a label, value and a trailing comment (\cvitemwithcomment).
#let cvitemwithcomment(label, value, comment) = {
  block(above: 0.3em, below: 0.3em)[
    #grid(
      columns: (3.2cm, 1fr, auto),
      column-gutter: 0.6em,
      align(right + top)[#text(weight: "bold")[#label]],
      [#value],
      align(right)[#text(fill: rgb("#666666"))[#comment]],
    )
  ]
}

// A simple label/value item (\cvitem).
#let cvitem(label, value) = {
  block(above: 0.3em, below: 0.3em)[
    #grid(
      columns: (3.2cm, 1fr),
      column-gutter: 0.6em,
      align(right + top)[#text(weight: "bold")[#label]],
      [#value],
    )
  ]
}

// ---------------------------------------------------------------------------
// Title / header
// ---------------------------------------------------------------------------
#align(center)[
  #text(size: 24pt)[#firstname #text(weight: "bold")[#familyname]]

  #v(0.3em)
  #set text(size: 9pt, fill: rgb("#666666"))
  #ico(icon-phone)#h(0.3em)#mobile
  #h(0.9em)
  #ico(icon-email)#h(0.3em)#link("mailto:" + email)[#email]
  #h(0.9em)
  #ico(icon-linkedin)#h(0.3em)#link("https://www.linkedin.com/in/" + linkedin)[in/#linkedin]
  #h(0.9em)
  #ico(icon-github)#h(0.3em)#link("https://github.com/" + github)[github.com/#github]
  #linebreak()
  #extrainfo
]

// ===========================================================================
// Experience
// ===========================================================================
#section("Experience")

#cventry("Mar 2020 – Present", "Lead Software Engineer", "LSEG", "London, UK", "Software Development")[
  Leading the design and delivery of TradeAgent, a cloud native OTC derivatives post-trade platform build on event-driven micro-services. Domain spans across SwapClear, Swaptions and Exercise (cash and physical), with FpML/CDM and PTML trade representation and regulatory reporting.
  - Java 21, Spring Boot 4 / Spring Framework 7, Spring Kafka, Spring GraphQL
  - Event-driven architecture: Apache Kafka, transactional outbox, Change Data Capture (CDC), PostgresQL, Liquibase
  - Testing: JUnit 5, Cucumber BDD, Testcontainers, Pact consumer/provider contract testing
  - AWS EKS, Kong API Gateway, MSK (Managed Kafka) Docker, Helm, Terraform/Terragrunt, GitLab DI/CD
  - Observability \& quality: Micrometer, Prometheus, SonarQube, Spotless, Trivy CVE remediation
  - AI-Native Engineering: authored the TradeAgent engineering consistuion and Github Copilot review rules, skills and Spec-kit tooling (Go Lang)
  - Kubernetes K8, Google Anthos, Docker, Nginx 
]

#cventry("Apr 2016 – Mar 2020", "System Developer Associate Manager", "Accenture", "London, UK", "Developer, SysAdmin")[
  Joined Accenture Capital Markets Trading Platforms with the acquisition of Formicary Ltd. Continuing my roles as a Murex & Java SME and Administrator. Implemented Murex on Cloud on the Accenture private cloud and later on public cloud (Amazon AWS).
  - AWS Certified Solutions Architect
  - Murex on Cloud, DevOps, Accenture Private Cloud
  - Accenture MxMon product owner
  - Murex install, Ansible automation, git
  - Kotlin, React, Typescript, Spring Boot 2.x, Jenkins Rest API, Ansible
  - Artifactory, NGINX, Reverse Proxy, SSL certificates
]

#cventry("Nov 2016 – Feb 2019", "Murex Migration Technical Lead", "Rabobank", "London, UK", "Consulting")[
  Responsible for the implementation of migrating existing systems into Murex 3.1. The scope involved Interest Rate Derivatives, Fixed Income and FX/MM products. Led a team of 10 developers across different time zones with responsibilities on delivering a migration tooling framework and configurations for Murex 3.1 in order to migrate trades and static data (counter parties, settlement instructions, accounts etc.).
  - Java 8, Camel, Spring Boot 1 & 2, Hibernate, JUnit, Multi-thread, Oracle, Derby, Flyway
  - Angular (1.x & 2+), UIGrid, CSS, HTML 5, VMware Clarity, RESTful web services, MVC
  - Maven, Microsoft TFS, git, Continuous Integration with Jenkins
  - Murex
    - MxML Exchange, Datamart
    - Performance optimizations, SME support
  - Reformx specialist
]

#cventry("Mar 2016 – Nov 2016", "Murex Migration Senior Developer - Static Data", "UBS", "London, UK", "Consulting")[
  As a member of the largest migration and re-platforming project in the world I was responsible for implementing SIMM regulatory changes and optimizing the static data interface. I also did the performance analysis for Murex application stack and suggested improvements on bottlenecks which would be arising from the incoming regional release.
]

#cventry("Nov 2010 – Apr 2016", "Senior Systems Engineer", "Formicary", "London, UK", "Administrator")[
  Part of the software development team which implemented various projects involving multiple software technologies and finally led to the creation of Reformx and Calmon products. Member of the admin team for administrating multiple servers for the DevOps tools of software development and Databases.
  - Spring Boot, Java 8, JPA, JDBC, JUnit, Spring Security, JGit, Camel, XSL
  - AngularJS, UIGrid, CSS, HTML5
  - Oracle, Derby, Postgres, MySQL, MongoDB
  - RESTful web services, ActiveMQ, JMS
  - Microservices
  - svn, git, clearcase
  - Calypso, Murex, Nvidia CUDA, Maven, Ant
  - Continuous Integration (Teamcity), Continuous Deployment (Ansible) servers setup
  - Linux/Unix administrator
]

#cventry("Jan 2016 – Feb 2016", "Lead Developer", "Société Générale", "London, UK", "Consulting")[
  Lead developer for a Murex external Feed to InterContinental Exchange (ICE) to support initial margin calculations as part of the client's ongoing Murex OTC clearing implementation.
  - Design architecture of ICE-IM adaptor service and components
  - Development according to coding standards and AGILE workflow
  - Management of project's release cycles and testing approach
]

#cventry("Mar 2014 – Jan 2016", "Quant risk analyst and Java engineer", "LCH Clearnet", "London, UK", "Consulting")[
  Responsible for the implementation of the Risk Calculation engine for Listed Derivatives.
  - Deliverable Swap Futures, Options on Future Bonds, Options on Future STIR, short-term interest rate (STIRs) and long-term interest rate (LTIRs) Euro and Sterling-based listed derivatives, Options on Future Equities, Future Equities
  - OpenGamma engine, Java 8, Weblogic, XSLT, Apache Camel, Spring Boot, Hibernate, Maven, Oracle, Multi-thread
  - Historical Value at Risk pricing (VaR)
]

#cventry("Mar 2013 – Jan 2014", "Murex and Java developer", "LCH Clearnet", "London, UK", "Consulting")[
  Member of the LCH Clearnet project for implementing Inflation Swaps and Swaptions.
  - Murex MxML Exchange, Murex Pre-Trade Rules (MSL)
  - SwapClear Services, ClearLink, SMART tool
]

#cventry("Mar 2012 – Feb 2013", "Murex and Java developer", "Standard Bank Group", "London, UK", "Consulting")[
  Developing a Murex to MarkitWire Feed (STP) for Swaps and derivatives along with a Reconciliation framework.
  - MarkitWire DealSink API, MarkitWire Deal, Extractor API
  - XSLT, Spring, Spring Integration, Murex, Maven
]

#cventry("Feb 2011 – Aug 2011", "Developer", "Royal Bank of Scotland", "London, UK", "Consulting")[
  Various back-end and front-end developer in the internals training team.
  - Java EE technology, JSP, ASP, ExtJS, JQuery CQ 5.0
]

#subsection("Other")

#cventry("Oct 2021 – Present", "Developer, Packager & DevOps", "Arch Linux", "Worldwide", "Volunteering")[
  Core contributor across packaging and project infrastructure — work hosted at #link("https://gitlab.archlinux.org/artafinde")[gitlab.archlinux.org/artafinde].
  - Maintain #link("https://archlinux.org/packages/?maintainer=artafinde")[240+ official packages] in the Core and Extra repositories
  - Toolchain & language ecosystems: LLVM / Clang / LLD / LLDB, OpenJDK (8–26), Maven, Gradle, IntelliJ IDEA, VS Code
  - Infrastructure as Code & DevOps for Arch services: GitLab CI/CD pipelines, Ansible, Terraform, reproducible and automated package builds
  - Authored a GitLab metrics exporter in Rust to surface project and CI/CD telemetry
  - Security & stability: upstream version tracking, CVE patching and coordinated rebuilds
]

#cventry("Mar 2009 – Sep 2009", "", "Hellas On Line - Technical Support Agent", "Athens, Greece", "")[]

#cventry("Dec 2004 – Dec 2005", "", "Freelance Web Designer / Developer", "Athens, Greece", "")[]

// ===========================================================================
// Education
// ===========================================================================
#section("Education")

#cventry("2007 – 2008", "Distributed and Multimedia Information Systems", "Heriot-Watt University", "Edinburgh, UK", "MSc")[
  Thesis: Multicore and Distributed-memory implementations of Haskell - Performance Comparison.
]

#cventry("2000 – 2007", "Computer Sciences", "Technologiko Ekpaideutiko Idrima", "Athens, Greece", "Bachelor")[
  Thesis: Parallel Algorithms for Matrix Multiplication and Document Clustering - Implementation and Testing on a PC-Cluster environment using MPI (MPICH).
]

// ===========================================================================
// Certificates
// ===========================================================================
#section("Certificates")

#cvitemwithcomment("AWS Certification")[
  #link("https://www.credly.com/badges/c39c3bb6-fa6d-4f69-b69c-005cbdca67ed/public_url")[AWS Certified Solutions Architect – Associate]
][2019 – 2022]

#cvitemwithcomment("Coursera Certificates")[Programming Mobile Applications for Android, Heterogeneous Parallel Programming][2014]

#cvitemwithcomment("London School of Computer Education")[Oracle 11g Database Administrator - OCA, OCP][2012]

#cvitemwithcomment("Udacity")[Artificial Intelligence for Robotics, Web Development][2012]

// ===========================================================================
// Languages
// ===========================================================================
#section("Languages")

#cvitem("Greek")[Mother tongue]
#cvitem("English")[Professional]
