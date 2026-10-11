// Document metadata
#let doc = (
  author: "John Doe",
  title: "Jarmos's Resume",
  description: "Jarmos's Software Development Engineering (SDE) resume written and built using Typst.",
  keywords: ("resume", "engineering", "typst"),
)

// College related information
#let college = (
  name: "University of Georgia",
  degree: "MSc",
  subject: "Computer Science and Information Technology",
  start: 2013,
  end: 2015,
)

// Skills
#let skills = (
  "Software Development": "Python, Golang, Lua, TypeScript (and JavaScript)",
  "Frameworks & Libraries": "FastAPI, Nuxt.js, Chi, SQLAlchemy",
  "Miscellaneous": "Terraform, Ansible, Git, Packer, PostgreSQL",
)

// Header related information
#let details = (
  name: "John Doe",
  links: (
    (type: "email", url: "contact@jarmos.dev", display: "contact@jarmos.dev"),
    (url: "https://jarmos.dev", display: "jarmos.dev"),
    (url: "https://github.com/Jarmos-San", display: "github.com/Jarmos-san"),
  ),
)

// Past work experience and achievements
#let experiences = (
  (
    designation: "Chief Technology Officer (CTO)",
    company: "Confidential Company",
    location: "Remote",
    start: "2022",
    end: datetime.today().year(),
    achievements: (
      [*Co-founded* a company specializing in *custom web-based software solutions*, empowering *online businesses and digital content creators* with tailored tools to streamline operations and enhance their digital presence.],
      [*Established and led the engineering team*, overseeing Software Development, Cybersecurity, and DevOps, and *implemented best practices* to ensure scalability, security, and operational efficiency.],
      [*Designed and led* the development of flagship products (including open-source initiatives), built for e-commerce and content workflows, increasing user adoption and contributing to revenue growth.],
      [*Spearheaded* the company's *open-source initiative*, establishing contribution guidelines, promoting adoption, and engaging with the developer community to strengthen the ecosystem.],
    ),
  ),
  (
    designation: "Senior Software Engineer",
    company: "Confidential Technology Firm",
    location: "Remote",
    start: 2021,
    end: 2022,
    achievements: (
      [*Built an engineering team from the ground up*, establishing development workflows and collaboration practices that improved team productivity.],
      [*Led a cross-functional engineering team* (Frontend, Backend, DevOps) to *design*, *develop*, and *launch an MVP*, accelerating product validation and time-to-market.],
      [*Designed the foundational architecture* for a product leveraging *photogrammetry and Machine Learning (ML)* to generate high-quality 3D models from 2D inputs.],
    ),
  ),
  (
    designation: "Technical Writer",
    company: "Confidential AI Company",
    location: "Remote",
    start: "2020",
    end: "2021",
    achievements: (
      [*Collaborated with marketing teams* to define a technical content strategy around *Computer Vision (CV) and Machine Learning (ML)*, improving clarity and accuracy of published material.],
      [*Published technical articles on CV and Autonomous Systems*, contributing to a *~25% improvement in keyword effectiveness* and overall content quality.],
      [*Optimized blog content for SEO* through structured keyword integration, resulting in a *~3x increase in organic traffic*.],
    ),
  ),
  (
    designation: "Software Support Engineer",
    company: "Confidential SaaS Company",
    location: "Major Tech Hub, India",
    start: "2019",
    end: "2020",
    achievements: (
      [*Triaged and analyzed* support tickets daily, prioritizing and escalating critical issues, enabling significantly faster bug resolution and reduced downtime.],
      [*Monitored system behavior proactively*, diagnosing frontend and backend issues and resolving them within defined SLAs, ensuring a consistent user experience.],
      [*Facilitated cross-functional collaboration* between support and engineering teams, improving documentation and communication, and significantly reducing miscommunication-related delays.],
    ),
  ),
)
