// =============================================================================
// Resume data — edit this file to update your resume content.
// Layout and styling live in templates/modern.typ and templates/original.typ.
// =============================================================================

// --- Header ---
#let name = "Yash Sharma"
#let tagline = "Senior Technical Lead · Senior Software Engineer (10+ yrs)"
#let years-note = "Scaling high-availability enterprise systems across FinTech, E-commerce & Healthcare"
#let email = "yasharma9391@gmail.com"
#let phone = "+91-9910448265"
#let phone-alt = "7795455436"
#let website = "linkedin.com/in/yasharmays"
#let location = "Bangalore, India"

// --- Professional summary ---
#let summary = "Innovative and resilient Senior Software Engineer with over a decade of experience designing and scaling high-availability enterprise applications across FinTech, E-commerce, and Healthcare domains. Demonstrated expertise in orchestrating cross-functional migrations, engineering resilient RESTful microservices, and leading agile development teams to accelerate product delivery. Adept at bridging the gap between complex business requirements and robust, scalable technical architectures."

// --- Profile photo toggle ---
// Plain builds omit the photo. Compile with `--input photo=true` for photo variants.
// To use a different photo, replace `assets/profile_pic.jpg` (or update photo-file below).
#let show-photo = sys.inputs.at("photo", default: "false") == "true"
#let photo-file = "assets/profile_pic.jpg"

// --- Experience ---
#let experience = (
  (
    title: "Senior Technical Lead",
    company: "Infovision Labs India Private Limited (Project: Wayfair)",
    dates: "Mar 2026 – Present",
    bullets: (
      "Led delivery of 22+ initiatives across the Material Catalog and Catalog Foundations domains, driving feature development, legacy modernization, and platform hardening for enterprise-scale catalog systems.",
      "Spearheaded legacy modernization by migrating a batch of product-data GraphQL integrations off legacy systems (CDF2), reducing coupling and technical debt.",
      "Built reusable automation tooling to accelerate migration, impact analysis, and dependency mapping across the catalog domain.",
      "Added traffic monitoring and test instrumentation before retiring unused database code, and contributed shared utilities and metrics analysis to support broader catalog decoupling.",
    ),
  ),
  (
    title: "Senior Software Engineer L3",
    company: "Canterr (Project: Wayfair)",
    dates: "Aug 2023 – Feb 2026",
    bullets: (
      "Spearheaded the Product Migration Team to execute a large-scale database migration for the Supplier Domain, supporting a platform that generates $12.5B+ in annual revenue and processes 40M+ annual orders, ensuring a seamless structural transition with zero unplanned system downtime.",
      "Orchestrated complex code migrations by implementing robust Feature Toggle strategies, reducing deployment risks and enabling incremental rollouts of critical new features to production.",
      "Redesigned and decoupled legacy REST APIs, significantly improving system modularity and enabling the engineering team to accelerate subsequent development cycles by 50%.",
      "Championed the end-to-end delivery of comprehensive back-end features—from initial architecture design to production deployment—achieving a 100% on-time release record for assigned technical sprints.",
    ),
  ),
  (
    title: "Software Engineer II",
    company: "ClearTax",
    dates: "Dec 2021 – June 2023",
    bullets: (
      "Engineered scalable REST APIs within a Spring Boot microservices architecture, driving the core back-end development for a high-traffic Vendor Management microservice on a platform processing over 5 billion global B2B transactions annually.",
      "Developed and integrated the Accounts Payable module, empowering enterprise clients to systematically track, manage, and process payable bills and invoices, reducing manual processing time by 30%.",
      "Took full ownership of the service lifecycle from scratch to production-ready deployment, ensuring high availability and robust performance across mission-critical FinTech SaaS applications.",
    ),
  ),
  (
    title: "Associate Consultant",
    company: "GlobalLogic India (Project: Adobe Commerce / Magento)",
    dates: "Mar 2021 – Dec 2021",
    bullets: (
      "Collaborated directly with cross-functional stakeholders to establish the foundational security team for Adobe Commerce, taking responsibility for the rapid identification and resolution of critical platform vulnerabilities.",
      "Fortified the e-commerce platform by patching high-priority security bugs, significantly reducing potential exploit vectors and improving overall system reliability for enterprise-level clients.",
    ),
  ),
  (
    title: "Software Development Engineer II",
    company: "Medlife (Now PharmEasy)",
    dates: "Jan 2019 – Mar 2021",
    bullets: (
      "Architected and implemented comprehensive back-end features and Microservice APIs utilizing Node.js, PHP, and Java Spring Boot, efficiently handling complex health-diagnostic e-commerce transactions and data flows supporting a scale of 17 million+ monthly active users.",
      "Automated dynamic data reporting systems and seamlessly integrated third-party LIS (Laboratory Information Systems), accelerating report generation speeds and reducing manual data entry overhead by 100%.",
      "Mentored and managed a small team of software developers, establishing robust Agile development methodologies that accelerated sprint delivery timelines and elevated overall code quality.",
    ),
  ),
  (
    title: "Software Developer / Front-End Team Lead",
    company: "Ailoitte Technologies / Arnit Retail / Nexia Digital",
    dates: "July 2016 – Jan 2019",
    bullets: (
      "Developed responsive front-end user interfaces and comprehensive back-end RESTful APIs for scalable e-commerce and logistics applications utilizing PHP, Node.js, and modern JS frameworks.",
      "Led front-end engineering initiatives at Arnit Retail, overseeing code quality and successful implementation of UI/UX improvements based on A/B testing (Google Optimize) results.",
      "Collaborated directly with clients at Nexia Digital to accurately document, troubleshoot, and deliver custom technical solutions tailored to complex business requirements.",
    ),
  ),
)

// --- Education ---
#let education = (
  (degree: "M.Tech in Computer Science Engineering (CSE)", institution: "Sharda University, Greater Noida", dates: "2015", note: "78%"),
  (degree: "B.Tech in Information Technology (IT)", institution: "Lovely Professional University, Jalandhar", dates: "2012", note: "70%"),
)

// --- Skills ---
#let skills-heading = "Core Technical Proficiencies"
#let skills-languages = ("Java (8/11/17)", "Python 3.x", "Node.js", "PHP", "JavaScript", "HTML5", "CSS3")
#let skills-databases = ("MySQL", "PostgreSQL", "MongoDB", "Redis")
#let skills-frameworks = ("Spring Boot 2.7.x", "Express.js", "Symfony", "CodeIgniter", "Angular.js", "React.js")
#let skills-cloud = ("AWS (EC2, Lambda, API Gateway, S3, SQS, Route 53)", "Docker", "Apache Kafka", "Git")
#let skills-methods = ("Microservices Architecture", "RESTful API Design", "Agile/Scrum", "Retool")
#let skills-testing = ("PHPUnit", "JUnit", "Mockito", "Jenkins", "Buildkite", "GitHub Actions")

// --- Optional: talks, OSS, or side projects (hidden — set entries to show) ---
#let projects = ()
