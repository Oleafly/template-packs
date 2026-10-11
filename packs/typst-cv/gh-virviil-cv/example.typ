#import "cv/cv.typ": cv

#let jobs = (
    (
        title: "Tech Lead ➤ Architect",
        company: "Root.io",
        company_url: "https://root.io",
        start_date: datetime(year: 2024, month: 1, day: 1),
        highlights: (
            "Joined as the first developer and led the greenfield development of the company's core product in Go, later transitioning into the role of Architect as the team scaled",
            "Designed a scalable infrastructure on Kubernetes, implementing Argo Workflows for asynchronous job orchestration and managing the full DevOps toolchain with Terraform, Helm, GitOps (ArgoCD), and robust monitoring/alerting systems",
            "Spearheaded R&D efforts into low-level OCI container operations—developing tooling for merging layers, injecting files, and modifying Docker image history—enabling the company's flagship feature: live patching of containers to reduce vulnerabilities",
            "Drove technical strategy across the organization: established a tech radar, evaluated and selected core tools, libraries, and ecosystems, and led proof-of-concept work on the MCP protocol and distributed agent architecture"
        )
    ),
    (
        title: "Team Lead - Core",
        company: "Cyolo",
        company_url: "https://cyolo.io/",
        start_date: datetime(year: 2022, month: 3, day: 1),
        end_date: datetime(year: 2024, month: 1, day: 1),
        summary: none,
        highlights: (
            "Leading the main product development cycle for core product functionality - a team of 8 senior developers, including full scrumming process, refinements and cross-stakeholder communications",
            "Developing cluster management solutions with Raft protocol",
            "Applying network and system programming to implement ZTNA-based product",
            "Building CI/CD pipelines for different environments and purposes"
        ),
    ),
    (
        title: "Senior Software Developer ➤ Team Lead - Data",
        company: "Syte.ai",
        company_url: "https://syte.ai/",
        start_date: datetime(year: 2020, month: 1, day: 1),
        end_date: datetime(year: 2022, month: 2, day: 1),
        summary: none,
        highlights: (
            "Taking responsibility for overall research-to-production cycle for Computer Vision part of the company",
            "Applying ML-Ops practices to increase time-to-market, quality and order for Computer Vision software parts and related software",
            "Leading the squad with full-cycle development capabilities: from research and model training to QA and production deployment",
            "Developing architecture for backend-to-ml software communication, increasing performance for end-to-end inference in real-time",
            "Developing design and architecture for the main ETL pipelines and data flows, using multiple instruments including Spark, Python Data Science stack, Erlang|Elixir/OTP based distributed systems",
            "Maintaining the data flow operations",
            "Migrating companies services stack from bare-metal deployment into Docker and Kubernetes",
        ),
    ),
    (
        title: "Software Developer",
        company: "Cheetah",
        company_url: "https://gocheetah.com/",
        start_date: datetime(year: 2018, month: 10, day: 1),
        end_date: datetime(year: 2020, month: 1, day: 1),
        summary: none,
        highlights: (
            "Execute migration from monolith to micro-service architecture in Ruby ecosystem",
            "Implementing bunch of service-type micro-services",
            "Designing service-communication flows, events and message passing solutions, including RPCs, message brokers, HTTP request-response calls, etc.",
            "Implementing CI/CD for services swarms",
            "Designing and developing integration for Data Science solutions in main operation flow - inside Python ecosystem",
        ),
    ),
    (
        title: "Senior Software Developer",
        company: "CTI",
        company_url: "https://www.cti.ru/",
        start_date: datetime(year: 2017, month: 8, day: 1),
        end_date: datetime(year: 2018, month: 9, day: 1),
        summary: none,
        highlights: (
            "Developing high-load enterprise software in Elixir/OTP language",
            "Creating web applications in Phoenix framework",
            "Developing solutions based on GraphQL and WebSockets",
            "Creating software architecture",
            "Managing SCRUM workflow",
            "Developing Telegram bots with Agala framework",
        ),
    ),
    (
        title: "Software Developer",
        company: "BetterTrader",
        company_url: "https://bettertrader.co/",
        start_date: datetime(year: 2016, month: 1, day: 1),
        end_date: datetime(year: 2017, month: 7, day: 1),
        summary: none,
        highlights: (
            "Developing various of web applications in Flask framework in Python",
            "Developing data analyses system using Python Data Science frameworks, including Scipy, Numpy and Pandas",
            "Developing bot-type applications for advertising and marketing purposes in Elixir/OTP including Phoenix framework",
        ),
    ),
)

#let skills = (
    (
        skill: "Backend Development",
        tags: ("Go", "Elixir", "Erlang/OTP", "Python", "Microservices", "Distributed Systems", "Phoenix", "FastAPI", "Concurrency", "Performance", "System Programming", "Network Programming", "Solution Implementation")
    ),
    (
        skill: "Systems Engineering",
        tags: ("Rust", "NIFs for BEAM", "FFI", "CLI Tools", "Memory Safety", "Performance Optimization", "Container Layer Manipulation", "Proxy Development", "Technical Problem Solving", "Low level wire protocols")
    ),
    (
        skill: "Cloud & Infrastructure",
        tags: ("Kubernetes", "Docker", "AWS", "Terraform", "GitOps", "ArgoCD", "Containerization", "Orchestration", "OCI", "Helm", "Service Mesh", "Auto-scaling", "Infrastructure as Code")
    ),
    (
        skill: "Software Architecture & Paradigms",
        tags: ("Event-Driven Architecture", "SOLID", "Design Patterns", "Clean Code", "Functional Programming", "OOP", "System Design", "Raft", "Cluster Management", "KISS", "DRY", "Application Architecture", "Enterprise Architecture Design")
    ),
    (
        skill: "Data Engineering & Storage",
        tags: ("PostgreSQL", "Redis", "Kafka", "ETL Pipeline Development", "ORMs", "Query Optimization", "Database Design", "Message Queues", "Event Streaming")
    ),
    (
        skill: "API & Communication",
        tags: ("REST", "gRPC", "Protocol Buffers", "GraphQL", "Websockets", "Service Discovery", "Consul", "etcd")
    ),
    (
        skill: "DevOps Practices",
        tags: ("CI/CD", "Linux Administration", "Shell Scripting", "Security", "Container Security")
    ),
    (
        skill: "Observability & Reliability",
        tags: ("Monitoring", "Grafana", "Loki", "CloudWatch", "Tracing", "Jaeger", "OpenTelemetry", "Logging", "Rate Limiting", "Circuit Breaking", "Fault Tolerance")
    ),
    (
        skill: "Frontend Development",
        tags: ("JavaScript", "TypeScript", "React", "Vue", "Svelte", "Node.js", "Web Development")
    ),
    (
        skill: "Development Practices",
        tags: ("TDD/BDD", "Code Review", "Static Analysis", "Feature Flagging", "VCS Flows", "Software Development Lifecycle", "Requirements Gathering")
    ),
    (
        skill: "Project Management & Analysis",
        tags: ("Business Analysis", "Team Collaboration", "Technical Problem Solving", "Solution Implementation")
    ),
)

#let education = (
    (
        institution: "Belorussian National Technical University",
        major: "M.Sc. in Power Engineering, 2009-2015"
    )
)

#let public_contributions = (
    (
        title: "Top-5 Itransition Opener 2015 Programming Contest",
        description: none,
        link: "https://devby.io/news/itransition-opener-2015-otseyal-pyat-finalistov-iz-4000-uchastnikov"
    ),
    (
        title: "GopherCon Israel 2025 speaker",
        description: "Preemptive Scheduling Strikes Back: How to Avoid CPU-Hogging Goroutines",
        link: "https://www.gophercon.org.il/#speakers"
    ),
    (
        title: "FuncBy Reboot speaker",
        description: "SOLID in Elixir",
        link: "https://www.facebook.com/share/p/19P7J6oLeQ/"
    ),
    (
        title: "F(by) Conference organizer",
        link: "https://www.facebook.com/events/space-eventspaceby/fby-conference-2020/544926146264556/"
    ),
    (
        title: "Elixir ecosystem contributor",
        description: "Dozen hex packages under maintenance, contributions to Elixir Nx",
        link: "https://hex.pm/users/virviil",
    )
)

#cv(
    name: "Dmitry Rubinstein",
    title: "Systems Architect | TechLead Backend",
    summary: "Systems Architect and Engineering Leader with over 10 years of experience designing and delivering robust, scalable backend platforms and distributed systems. Expert in Go, Elixir, System Architecture, and Cloud-Native ecosystem. Proven track record in greenfield development, leading high-performing teams, and driving technical strategy in fast-paced environments. Passionate about building fault-tolerant infrastructure and solving complex systems-level challenges.",
    jobs: jobs,
    skills: skills,
    education: education,
    public_contributions: public_contributions,
)
