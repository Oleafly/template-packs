#set document(title: "Mohit's Resume")
#set page(margin: (x: 1.2cm, y: 1.2cm))
#set par(justify: true)
#set text(
  font: "EB Garamond"
)
#show link: set text(fill: blue)
#set list(marker: [-])

#let phone = sys.inputs.at("PHONE", default: "+91-XXXXXXXXXX")

// ── Header ──────────────────────────────────────────────
#align(center)[
  = Mohit Ranjan
  #link("mailto:mohit.ranjan.910@gmail.com")[mohit.ranjan.910\@gmail.com] |
  #link("https://www.linkedin.com/in/mohit-ranjan-759188169/")[https://www.linkedin.com/in/mohit-ranjan-759188169] |
  #link("https://github.com/MohitR1999")[https://github.com/MohitR1999] |
  #phone | Delhi, India
]


// ── Summary ──────────────────────────────────────────
== #upper("Summary")
#line(length: 100%)

Senior Frontend & Full-Stack Engineer with 4.8+ years of experience designing and building scalable, high-performance web and mobile applications. Proven expertise in system design, microservices architecture, and cloud-native development. Delivered
production systems serving 100K+ users in fintech and telecom domains. Strong background in TDD, CI/CD, performance optimization, and RESTful API design. Experienced shipping cross-platform mobile apps in Agile/Scrum teams, collaborating across product and design to deliver scalable, mobile-first solutions

// ── Skills ──────────────────────────────────────────────
== #upper("Skills")
#line(length: 100%)
- *Programming Languages:* JavaScript, TypeScript, Python \
- *Frontend & Mobile:* React Native, Expo, EAS, React.js, Zustand, Redux, Cross-platform Mobile
- *Backend & APIs:* Node.js, Express.js, Microservices, REST APIs
- *Cloud & DevOps:* AWS, Docker, Terraform, GitHub Actions, Turborepo, CI/CD \
- *Databases:*  MySQL, MongoDB \
- *Practices:* Agile, Scrum, TDD, System Design, Performance Optimization \
- *Testing:* Jest, jest-expo, React Testing Library

// ── Experience ──────────────────────────────────────────
== #upper("Experience")
#line(length: 100%)
*OakNorth India* #h(1fr) *_July 2025 - Present_* \ 
Tech Lead (Individual Contributor) #h(1fr) _Gurugram, Haryana, India_

- Engineered the OakNorth Personal Savings App from scratch using React Native (Expo) & TypeScript, delivering end-to-end mobile banking features including account management, fund transfers, and payment scheduling, catering to over 100K users.
- Established the full engineering foundation: Turborepo monorepo, GitHub Actions CI/CD, EAS deployment pipelines, and TDD standards via jest-expo and React Testing Library.
-  Integrated Equifax & Experian into onboarding flows to automate KYC verification, reducing operational overhead by 90%; integrated TrueLayer for instant payments and VRP, and Segment and Iterable for analytics and lifecycle communications.
- Reduced Sprig operational costs by 50% through systematic audit and filtering of non-essential analytics events.

*Tejas Networks Ltd* #h(1fr) *_July 2021 - July 2025_* \ 
Senior Engineer #h(1fr) _Gurugram, Haryana, India_

- Built the network topology visualisation service from scratch for TejNMS using React.js, Cytoscape, and Express, supporting BSNL's pan-India 4G/5G MPLS-IP rollout, reducing operational mistakes by 90%.
- Replaced manual CLI-based workflows with a GUI-driven BGP provisioning feature, eliminating configuration errors and ensuring 100% accuracy in network element config delivery.
-  Developed a GUI-based RSVP configuration interface, cutting provisioning time from 5 minutes to 1 minute — an 80% reduction in operator effort.
- Established an automated E2E testing framework and real-time performance monitoring utility.

// ── Education ───────────────────────────────────────────
== #upper("Projects")
#line(length: 100%)

- *Bablu (Cloud-Native Discord Bot)*: Built and deployed a containerized, event-driven Discord bot using Node.js, AWS ECS, Terraform-based IaC and GitHub Actions CI/CD pipelines currently being used by over 1.5K users. #link("https://github.com/SelfOverflow/discord-bots")[(GitHub monorepo)]

// ── Education ───────────────────────────────────────────
== #upper("Education")
#line(length: 100%)

*Delhi Technological University* #h(1fr) *_Aug 2017 - July 2021_* \ 
B.Tech (Computer Engineering) CGPA - 8.36 #h(1fr) _Delhi, India_