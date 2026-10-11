// Resume data and entry point. Edit this file to update content.
// Formatting functions are in functions.typ.
// Sample data is satirical - replace with your own career information.

#import "functions.typ": cvinit, render-basic-info, render-summary, render-education, render-work, render-project, render-custom

// Personal info - update with your details
#let name = "YOUR NAME"
#let title = "Senior Full Stack Engineer"
#let location = "Palo Alto, California, USA"
#let email = "your.name@example.com"
#let phone = "+1 (555) 123-4567"
#let url = "yourname.dev"

// Social profiles: network (platform), username, url
// Add more profiles by adding tuples to this array.
// Fill in username so the contact line shows a label (e.g. "LinkedIn: yourname").
// Any entry with a username or a URL is shown; empty entries are hidden.
#let profiles = (
  (
    network: "LinkedIn",
    username: "yourname",
    url: "linkedin.com/in/yourname",
  ),
  (
    network: "GitHub",
    username: "yourname",
    url: "github.com/yourname",
  ),
)

// Brief professional summary (2-3 sentences max)
#let summary = "Experienced software engineer with a background of building *scalable systems* in the *fintech, health, and media* industries. Expert in *JavaScript, TypeScript, Node.js, React AI, and C++* (and powered almost entirely by coffee and the occasional warp-core energy drink)."

// Education entries
#let educations = (
  (
    institution: "University of California, Berkeley",
    location: "Berkeley, California",
    url: "berkeley.edu",
    area: "Computer Science",
    studyType: "B.S.",
    startDate: "August 2010",
    endDate: "May 2013",
    score: "GPA 3.94",
    courses: ("Graduated Summa Cum Laude", "Machine Learning at Berkeley Club (co-founder)"),
  ),
)

// Work experience - companies with positions and bullet highlights
#let works = (
  (
    name: "Instagram",
    location: "Palo Alto, California",
    url: "instagram.com",
    positions: (
      (
        position: "Engineering Manager - Web App Team",
        startDate: "October 2021",
        endDate: "Present",
        highlights: (
          "Promoted to Engineering Manager, leading the *Web App Team of 6 engineers* behind the *BlockChain news feed*",
          "Scaled the team to *12 engineers* while sustaining a *240fps* caffeine-driven delivery velocity",
          "Drove a *72% improvement* in deployment frequency via *AI based GraphQL* and *orbital arcade hosting*",
          "Managed cross-functional initiative to host the feed on *arcade cabinets in low Earth orbit*, offsetting *$2M/year* in infrastructure costs",
          "Kept the entire org fully caffeinated with *Antarctican beans ground to 14 nm particles*",
        ),
      ),
      (
        position: "Senior Full Stack Engineer - Web App Team",
        startDate: "October 2018",
        endDate: "October 2021",
        highlights: (
          "Built *news feed infrastructure* using *React for AI on BlockChain*",
          "Optimized web app feed performance through new *server-side React larceny AI algorithm* to quickly resolve *big data pipeline*",
          "Led *team of 6 engineers* hosting the feed on *arcade cabinets in low Earth orbit*",
          "Team coffee maker - ensured team of 6 was fully caffeinated with *Antarctican coffee beans ground to 14 nm particles* using a *miniature ion cannon*",
        ),
      ),
    ),
  ),
  (
    name: "Zillow",
    location: "San Francisco, California",
    url: "zillow.com",
    positions: (
      (
        position: "Senior Full Stack Engineer - Web App Team",
        startDate: "June 2015",
        endDate: "September 2018",
        highlights: (
          "Added *AI based GraphQL*, resulting in *72% faster page loads*",
          "Organized team bonding through company potato sack race resulting in increased *team bonding and cohesity*",
          "Rebuilt home display page with *virtualized tables and map* to provide a buttery-smooth *120fps* on screen experience with the design team",
          "Evangelized and adopted an *open-source React UI library*",
        ),
      ),
    ),
  ),
  (
    name: "LinkedIn",
    location: "San Francisco, California",
    url: "linkedin.com",
    positions: (
      (
        position: "Software Engineer - Search Team",
        startDate: "June 2013",
        endDate: "September 2015",
        highlights: (
          "Improved LinkedIn search algorithm *efficiency and accuracy* through the usage of *VoldemortDB, Charizard, and Hadoop*",
          "Tracked down a *reclusive kernel maintainer* on IRC and exchanged /msgs (they actually replied!)",
          "Implemented *data quality improvements* via *deduplication and advanced profile ranking* resulting in *faster big data with React*",
        ),
      ),
    ),
  ),
  (
    name: "Microsoft",
    location: "Redmond, Washington",
    url: "microsoft.com",
    positions: (
      (
        position: "Software Engineer Intern - Edge Team",
        startDate: "May 2011",
        endDate: "August 2012",
        highlights: (
          "Built *React based big data pipeline* to enhance *deployment stability* of *Microsoft Edge* browser on the *Blockchain*",
          "Spearheaded the company's annual *Star Fleet recruitment rally* (gold shirts optional)",
          "Organized an *intern onboarding bootcamp* (snacks provided) that improved *ramp-up time by 60%*",
        ),
      ),
    ),
  ),
  // Add more companies as needed
)

// Technical skills and competencies
#let skills_section = (
  title: "Technical & Core Competencies",
  highlights: (
    (
      summary: "Languages & Runtimes",
      description: "JavaScript, TypeScript, Node.js, C++",
    ),
    (
      summary: "Frontend & AI",
      description: "React, React AI, GraphQL",
    ),
    (
      summary: "Domains",
      description: "Fintech, Health, Media",
    ),
    (
      summary: "Notable Expertise",
      description: "Caffeine Logistics & Meetingology",
    ),
  ),
)

// Notable projects
#let projects = (
  (
    name: "News Feed Infrastructure",
    url: "instagram.com",
    roles: ("React", "AI", "BlockChain"),
    startDate: "2018",
    endDate: "Present",
    highlights: (
      "*Server-side React larceny AI algorithm* for *big data pipeline*",
      "*Arcade-cabinet hosting* in low Earth orbit with a *team of 6*",
    ),
  ),
  (
    name: "Resume & Brag Document Template",
    url: "github.com/vanam-san/resume-bragdoc-template",
    roles: ("Typst", "GitHub Actions", "Template Design"),
    startDate: "2026",
    endDate: "Present",
    highlights: (
      "Built a *reusable Typst template* powering a *resume and brag document* from one shared style system",
      "*Automated PDF releases* via *GitHub Actions* with auto-incremented *v1.N tags* and What's Changed notes",
      "*Dogfooded in production*: this resume was compiled by the template itself",
    ),
  ),
  // Add more projects as needed
)

// Render the resume.
// compact-footer: true = page count only (best for recruiters + ATS).
// compact: true = tighter margins/type to fit 1 page (10.5pt, less spacing).
// For short dates ("Oct 2021 – Present"), pass short: true to daterange_short
// in functions.typ, or simply write short dates in your data below.
// For keyword-first resumes, move #render-custom(skills_section) to right
// after #render-summary(summary).
#show: cvinit.with(author: name, title: title, compact-footer: true)

#render-basic-info(name: name, title: title, location: location, email: email, phone: phone, url: url, profiles: profiles)
#v(1em)
#render-summary(summary)
#v(1em)
#render-work(works)
#v(1em)
#render-custom(skills_section)
#v(1em)
#render-project(projects)
#v(1em)
#render-education(educations)
