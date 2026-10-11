#import "template.typ": resume, header, resume_heading, edu_item, exp_item, project_item, skill_item, set_variables

#set page(
    paper: "us-letter",
    margin: (x: 0.3in,
             y: 0.2in)
  )

#set_variables(rgb("#0f55cb"), "", 11pt, rgb("#050505"))

#show: resume

#header(
  name: "Sathya Tadinada",
  title: "Computer Science M.S. Student",
  phoneNumber: "(385) 202-8698",
  email: "sathya@tadinada.com",
  linkedinLink: "linkedin.com/in/sathya-tadinada/",
  linkedinUsername: "sathya-tadinada",
  githubLink: "github.com/SathyaTadinada",
  githubUsername: "SathyaTadinada",
  site: "tadinada.com",
)

#resume_heading[Education]
#edu_item(
  name: "University of Utah",
  degree: "Master of Science in Computer Science",
  location: "Salt Lake City, UT",
  date: "Expected 2027",
  [#text(weight:600, "GPA:") 4.000],
)

#edu_item(
  name: "University of Utah",
  degree: "Honors B.S. in Computer Science; B.S. in Applied Mathematics",
  location: "Salt Lake City, UT",
  date: "Aug. 2022 – May 2026",
  [#text(weight:600, "GPA:") 3.950; #text(weight:600, "Minor:") Psychology; Dean's List],
)

#resume_heading[Experience]
#exp_item(
  role: "Lead Teaching Assistant",
  name: "University of Utah / Kahlert School of Computing",
  location: "Salt Lake City, UT",
  date: "Aug. 2024 – Present",
  [Lead weekly review sessions for 100+ students, clarifying theoretical computer science concepts and formal proof strategies.],
  [Design and validate homework assignments, solution keys, and automata diagrams in LaTeX and Typst across regular languages, finite automata, and non-regularity proofs.],
  [Grade assessments and provide detailed feedback on automata, formal languages, and computability.],
  [Nominated for TA of the Year for the 2024–2025 academic year.],
)
#exp_item(
  role: "Software Engineering Intern",
  name: "Select Portfolio Servicing, Inc.",
  location: "West Valley City, UT",
  date: "May 2026 – Aug. 2026",
  [Built and operated a production voice-and-chat AI concierge that handled 52,000+ calls across 33,000 customers and processed 16,000+ payments worth \$25M+ in its first five weeks live.],
  [Designed a server-owned mandatory-disclosure system that measured actual audio playout and re-read interrupted scripts, closing a compliance gap affecting 21% of payment calls.],
  [Integrated 11+ internal services with a two-tier parallel fetch, cutting customer-record latency 2.9x from 1.79 s to 615 ms.],
  [Built a .NET and SQL Server observability stack with idempotent push-based ingest, high-availability leader election, and call/chat analytics.],
)
#exp_item(
  role: "Data Analytics Intern",
  name: "Select Portfolio Servicing, Inc.",
  location: "West Valley City, UT",
  date: "May 2025 – Aug. 2025",
  [Rebuilt the Advance Continuation Model (ACM) pipeline by porting 10 SAS regression models into Python and SQL, reducing runtime from 5 days to 30 seconds (99.99% improvement) while preserving statistical fidelity.],
  [Reduced failed LLM-generated call summaries by 80% through retry logic, structured error logging, and pipeline validation.],
)
#exp_item(
  role: "Undergraduate Researcher",
  name: "University of Utah / Human-Centered Computing Research Lab",
  location: "Salt Lake City, UT",
  date: "Feb. 2023 – Aug. 2023",
  [Standardized code across research prototypes and synthesized qualitative data into 8 instructional recommendations, improving coding-style test metrics by 10%.],
)

#resume_heading("Projects")
#project_item(
  name: "FreezeTag: Self-Hosted Image Tagging Platform",
  details: "Go, Next.js, TypeScript, Python, REST APIs",
  date: "Aug. 2025 – Apr. 2026",
  [Co-developed a self-hosted photo management platform with a Go (Gin) backend and Next.js frontend.],
  [Built a typed query parser and predictive search UI for tag, date, metadata, and geospatial filters, with cached metadata to reduce repeated API requests.],
  [Improved gallery responsiveness and accessibility with keyboard navigation, image preloading, custom themes, and map-based photo metadata.],
)
#project_item(
  name: "Deferred Rendering Engine",
  details: "C++, OpenGL, FreeGLUT",
  date: "Mar. 2025 – Apr. 2025",
  [Built a deferred rendering pipeline with geometry and lighting passes, multiple render targets, and physically based shading.],
  [Implemented light volume rendering supporting 128 dynamic lights and optimized fragment shading for high-density scenes.],
)

#resume_heading("Activities")
#exp_item(
  name: "Software Development Club",
  role: "Co-Founder, President",
  location: "Salt Lake City, UT",
  date: "May 2023 – Present",
  [Coordinated a month-long online hackathon and portfolio website competition, achieving 90%+ member participation.],
  [Increased active member participation by 60% through strategic partnerships and high-impact events.],
)

#resume_heading("Skills")
#skill_item(
  category: "Languages",
  skills: "Java, Python, TypeScript/JavaScript, Rust, C#, C++, C, Swift, SQL, Go"
)
#skill_item(
  category: "Frameworks & Runtimes",
  skills: "Node.js, Next.js, React, ASP.NET Core, Gin, Spring Boot"
)
#skill_item(
  category: "Technologies & Tools",
  skills: "SQL Server, Docker, CI/CD, Git/GitHub, IIS, PowerShell, WebSockets, REST/SOAP, OpenGL, LLM Integration"
)
