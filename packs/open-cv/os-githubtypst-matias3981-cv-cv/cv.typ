#import "@preview/silver-dev-cv:1.0.2": *

#show: cv.with(
  font-type: "PT Serif",
  continue-header: "false",
  name: "Matias Torreblanca",
  address: "Valencia, Spain",
  lastupdated: "true",
  pagecount: "true",
  date: "2025-01-19",
  contacts: (
    (text: "LinkedIn", link: "https://www.linkedin.com/in/matias-torreblanca/"),
    (text: "+34 627384994", link: "tel:+34627384994"),
    (text: "matias3981@gmail.com", link: "mailto:matias3981@gmail.com"),
  ),
)

// About - Concise, niche-focused
#section[About Me]
#descript[Senior Frontend Developer specializing in FinTech, payments, and KYC compliance with 6 years of experience. Built real-time analytics dashboards, payment integrations (Stripe/dLocal), and identity verification flows serving 300k+ daily users. Previously at Mercado Libre (300M+ users).]

#sectionsep

// Experience
#section("Experience")

#job(
  position: "Sr Frontend Engineer",
  institution: [Parser],
  location: "Remote",
  date: "Jul 2025 - Present",
  description: [
    - Integrated Unico KYC library into authentication flows, implementing identity verification, document upload, and liveness detection for 300k daily users in the Brazilian market.
    - Led architecture of the new Wallet product, migrating from CRA to Vite + Tailwind to support future React versions, reducing build times by 36%.
    - Architected Lit-based web components for Login and Registration flows using Event Bus pattern for cross-component communication.
    - Ran product demos for stakeholders to validate features and gather feedback before production releases.
  ],
)

#job(
  position: "Product Engineer",
  institution: [Sanlo],
  location: "Remote",
  date: "Dec 2022 - Jul 2025",
  description: [
    - Built Webshop Builder, a no-code e-commerce platform with Stripe/dLocal payments enabling game studios to sell virtual goods outside App Store fees.
    - Developed Financial Analytics, real-time dashboards displaying revenue, ROI, and performance metrics for 50 game studios handling millions of data rows.
    - Led migration from Styled Components to Chakra UI, improving development velocity by 40%.
    - Owned frontend technical decisions with direct CTO/CEO feedback, and drove improvements to testing practices across the frontend codebase.
  ],
)

#job(
  position: "Sr Frontend Engineer",
  institution: [MajorKey],
  location: "Remote",
  date: "Jul 2022 - Dec 2022",
  description: [
    - Built frontend from scratch for a platform connecting college athletes with university coaches for scholarship opportunities using React and Redux Toolkit.
    - Collaborated with designers to translate Figma specs into responsive, pixel-perfect interfaces.
  ],
)

#job(
  position: "Frontend Engineer",
  institution: [Spark Digital | Intive],
  location: "Remote",
  date: "Sep 2021 - Jul 2022",
  description: [
    - Shipped features for The Knot, a leading U.S. wedding e-commerce platform, using Next.js, GraphQL, and Contentful CMS.
    - Optimized page performance and integrated headless CMS for dynamic content management.
  ],
)

#job(
  position: "Frontend Developer",
  institution: [Mercado Libre],
  location: "Argentina",
  date: "Mar 2019 - Sep 2021",
  description: [
    - Migrated Addresses microfrontend from Handlebars to React, improving address management for millions of users across 5 LATAM countries.
    - Shipped loan application flows for Mercado Crédito, a consumer finance product within Mercado Pago serving millions of users.
    - Mentored junior developers on React best practices and participated in frontend guild meetings defining stack and coding standards.
    - Ran product demos for Product Owners to validate features and ensure alignment with business requirements.
  ],
)

#section("Skills")
#oneline-title-item(
  title: "Frontend",
  content: [JavaScript ES6+, TypeScript, React, Next.js, HTML5, CSS3, Tailwind, Shadcn, Chakra UI, Redux Toolkit, React Query, Vite, Lit Web Components],
)
#oneline-title-item(
  title: "Backend & Tools",
  content: [Node.js, Python, GraphQL, REST APIs, Contentful CMS, Jest, React Testing Library, Git, CI/CD, Stripe, dLocal],
)
#oneline-title-item(
  title: "Industries",
  content: [FinTech, Payments, KYC/Compliance, E-commerce, Real-time Analytics, SaaS Platforms],
)

#sectionsep

#section("Education")
#education(
  institution: [Universidad Siglo 21],
  major: [Software Engineering],
  date: "2016 - 2020",
  location: "Argentina",
)

#set document(author: "Matias Torreblanca", title: "Matias Torreblanca - Senior Frontend Developer")
