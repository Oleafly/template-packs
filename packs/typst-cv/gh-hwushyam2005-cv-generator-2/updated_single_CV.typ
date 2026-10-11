// ============================================================
// SINGLE-FILE TYPST CV
// Merged from: utils.typ + main.typ + samplemetadata.yml
// ============================================================

// ------------------------------------------------------------
// 1. UTILITIES
// ------------------------------------------------------------

#let resume(
  author: "",
  author-position: left,
  personal-info-position: left,
  pronouns: "",
  location: "",
  email: "",
  github: "",
  linkedin: "",
  phone: "",
  personal-site: "",
  visa: "",
  driving-license: "", 
  orcid: "",
  accent-color: "#000000",
  font: "New Computer Modern",
  paper: "us-letter",
  author-font-size: 20pt,
  font-size: 10pt,
  lang: "en",
  body,
) = {

  // Sets document metadata
  set document(author: author, title: author)

  // Document-wide formatting, including font and margins
  set text(
    // LaTeX style font
    font: font,
    size: font-size,
    lang: lang,
    // Disable ligatures so ATS systems do not get confused when parsing fonts.
    ligatures: false
  )

  // Recommended to have 0.5in margin on all sides
  set page(
    margin: (0.5in),
    paper: paper,
  )

  // Link styles
  show link: underline

  // Small caps for section titles
  show heading.where(level: 2): it => [
    #pad(top: 0pt, bottom: -10pt, [#smallcaps(it.body)])
    #line(length: 100%, stroke: 1pt)
  ]

  // Accent Color Styling
  show heading: set text(
    fill: rgb(accent-color),
  )

  show link: set text(
    fill: rgb(accent-color),
  )

  // Name will be aligned left, bold and big
  show heading.where(level: 1): it => [
    #set align(author-position)
    #set text(
      weight: 700,
      size: author-font-size,
    )
    #pad(it.body)
  ]

  // Personal Info Helper
  let contact-item(value, prefix: "", link-type: "") = {
    if value != "" {
      if link-type != "" {
        link(link-type + value)[#(prefix + value)]
      } else {
        value
      }
    }
  }

  // Level 1 Heading
  grid(
    columns: (auto, 1fr),
    align: (left, right),
    [= #(author)],
    [#contact-item(location) \
      Phone: #contact-item(phone)],
  )

  // Personal Info
  pad(
    top: -0.15em,
    align(personal-info-position)[
      #{
        let items = (
          contact-item(pronouns),
          contact-item(email, link-type: "mailto:"),
          contact-item(github, link-type: "https://"),
          contact-item(linkedin, link-type: "https://"),
          contact-item(visa, link-type: "https://"),
          contact-item(driving-license, link-type: "https://"),
          contact-item(personal-site, link-type: "https://"),
          // Plain glyph instead of the scienceicons orcid-icon, so no
          // external package import is needed.
          contact-item(orcid, prefix: "\u{25C9} orcid.org/", link-type: "https://orcid.org/"),
        )
        items.filter(x => x != none).join("  |  ")
      }
    ],
  )

  // Main body.
  set par(justify: true)

  body
}

// Generic two by two component for resume
#let generic-two-by-two(
  top-left: "",
  top-right: "",
  bottom-left: "",
  bottom-right: "",
) = [
  #top-left #h(1fr) #top-right #v(-6pt)
  #grid(columns: (1fr, auto), column-gutter: 1em, bottom-left, align(right)[#bottom-right])
]

// Generic one by two component for resume
#let generic-one-by-two(
  left: "",
  right: "",
) = [
  #left #h(1fr) #right
]

// Cannot just use normal --- ligature because ligatures are disabled for good reasons
#let dates-helper(
  start-date: "",
  end-date: "",
) = {
  start-date + " " + $dash.em$ + " " + end-date
}

// Section components below
#let edu(
  institution: "",
  dates: "",
  degree: "",
  gpa: "",
  location: "",
  // Makes dates on upper right like rest of components
  consistent: false,
) = {
  if consistent {
    // edu-constant style (dates top-right, location bottom-right)
    generic-two-by-two(
      top-left: strong(institution),
      top-right: dates,
      bottom-left: emph(degree),
      bottom-right: emph(location),
    )
  } else {
    // original edu style (location top-right, dates bottom-right)
    generic-two-by-two(
      top-left: strong(institution),
      top-right: location,
      bottom-left: emph(degree),
      bottom-right: emph(dates),
    )
  }
}

#let work(
  title: "",
  dates: "",
  company: "",
  location: "",
) = {
  generic-two-by-two(
    top-left: strong(title),
    top-right: dates,
    bottom-left: company,
    bottom-right: emph(location),
  )
}

#let project(
  role: "",
  name: "",
  url: (),
  dates: "",
  tech: (),
  desc: ""
) = {
  if url == () {
    panic("URL not provided. Please include a URL before proceeding in the format ('Project', '<url>').")
  }

  generic-two-by-two(
    top-left: {
      let entries = url.pairs()
      let last = entries.len() - 1

      if role == "" {
        [*#name*
        (#for (idx, (key, value)) in entries.enumerate() {
          link("https://" + value)[#key]
          if idx != last {", "}
        })]
      } else {
        [*#role*, #name #if url != "" and dates != ""  [
          (#for (idx, (key, value)) in entries.enumerate() {
            link("https://" + value)[#key]
            if idx != last {", "}
          })
        ]]
      }
    },
    top-right: [*Tech:* #tech.join(", ")],
    bottom-left: desc,
    bottom-right: {
      if dates == "" and url != "" {
        [#link("https://" + url)[#url]]
      } else [
        #dates
      ]
    },
  )
}

#let certificates(
  name: "",
  issuer: "",
  url: "",
  date: "",
) = [
    #if url != "" {
      [#link("https://" + url)[*#name*]]
    } else [*#name*] - #issuer
    #h(1fr) #date
  ]

#let extracurriculars(
  activity: "",
  dates: "",
) = {
  generic-one-by-two(
    left: strong(activity),
    right: dates,
  )
}

// ------------------------------------------------------------
// 2. CV CONTENT
// ------------------------------------------------------------

#let name          = "C.Joseph Vijay"
#let location      = "Chennai, India"
#let email         = "CJosephVijay@gmail.com"
#let github        = "github.com/CJV"
#let linkedin      = "linkedin.com/in/C.Joseph Vijay"
#let phone         = "+91 14820 254769"
#let driving-license = "Valid Driving-License"
#let visa          = "Valid Visa"
// #let personal-site = "yourwebsite.com"

#show: resume.with(
  author: name,
  // All the lines below are optional.
  // For example, if you want to to hide your phone number:
  // feel free to comment those lines out and they will not show.
  location: location,
  email: email,
  github: github,
  linkedin: linkedin,
  phone: phone,
  visa: visa,
  driving-license: driving-license,
  // personal-site: personal-site,
  // accent-color: "#26428b",
  font: "New Computer Modern",
  paper: "a4",
  author-position: left,
  personal-info-position: center,
)

/*
* Lines that start with == are formatted into section headings
* You can use the specific formatting functions if needed
* The following formatting functions are listed below
* #edu(dates: "", degree: "", gpa: "", institution: "", location: "")
* #work(company: "", dates: "", location: "", title: "")
* #project(dates: "", name: "", role: "", url: "")
* #extracurriculars(activity: "", dates: "")
* There are also the following generic functions that don't apply any formatting
* #generic-two-by-two(top-left: "", top-right: "", bottom-left: "", bottom-right: "")
* #generic-one-by-two(left: "", right: "")
*/

== Education

#edu(
  institution: "University of Texas at Dallas",
  location: "Richardson, TX",
  dates: dates-helper(start-date: "August 2024", end-date: "May 2025"),
  degree: "Master's of Science in Computer Science",
)
#v(-0.25em)
// #text(size: 9pt)[*Courses:* Introduction to Information Security]
// - Cumulative GPA: 4.0\/4.0 | Dean's List, Harvey S. Mudd Merit Scholarship, National Merit Scholarship

== Work Experience

#work(
  title: "Junior Software Developer",
  location: "Austin, TX",
  company: "TechNova Solutions",
  dates: dates-helper(start-date: "June 2024", end-date: "Present"),
)
#v(-0.5em)

- Developed and maintained RESTful APIs using Node.js and Express, improving application response time by 20%
- Collaborated with cross-functional teams using Agile methodologies to deliver new product features
- Wrote unit and integration tests, increasing code coverage and reducing post-release bugs

#work(
  title: "IT Support Intern",
  location: "Dallas, TX",
  company: "BrightPath Systems",
  dates: dates-helper(start-date: "January 2024", end-date: "May 2024"),
)

#v(-0.5em)

- Provided technical support for 100+ users, resolving hardware and software issues efficiently
- Assisted in network setup, configuration, and troubleshooting for office infrastructure
- Documented technical processes and created user guides to streamline internal support

== Skills

#grid(
  rows: 6,
  columns: (auto, 1fr),
  row-gutter: 0.75em,
  column-gutter: 0.5em,
  // align: (left, right),
  [*Languages:*], [Python, Java, JavaScript, SQL, HTML, CSS],
  [*Tools:*], [Git, Docker, VS Code, Postman, Jira, Linux],
  [*Soft Skills:*], [Communication, Teamwork, Problem-Solving, Adaptability, Time Management],
  [*Business Skills:*], [Data Analysis, Project Coordination, Agile Methodologies, Technical Documentation],
  [*Platforms:*], [AWS (EC2, S3), Google Cloud Basics, Firebase],
  [*Other Skills:*], [Debugging, API Development, Version Control, System Troubleshooting],
)

#v(-0.5em)

== Projects

#project(
  name: "Task Manager Web App",
  dates: "March 2025",
  // role: "",
  url: (
    "Live Project": "jd1234.github.io/task-manager-web",
    "Project Link": "github.com/jd1234/task-manager-web"
  ),
  tech: ("React", "Node.js", "MongoDB"),
  desc: "Built a full-stack task management app with user authentication, CRUD functionality, and responsive UI"
)

#v(-3pt)

#project(
  name: "Student Performance Predictor",
  dates: "January 2025",
  tech: ("Python", "Scikit-learn", "Pandas"),
  url: ("Project Link": "https://github.com/jd1234/student-performance-indicator"),
  desc: "Developed a machine learning model to predict student outcomes based on historical data, achieving 85% accuracy"
)

#v(-3pt)

#project(
  name: "Portfolio Website",
  dates: "January 2025",
  url: (
    "Live Project": "johndoe.dev",
  ),
  tech: ("HTML", "CSS", "JavaScript"),
  desc: "Designed and deployed a personal portfolio website showcasing projects and technical skills"
)

#v(-3pt)

== Awards and Certifications

#certificates(
  name: "AWS Certified Cloud Practitioner",
  issuer: "Amazon Web Services",
  date: "February 2025",
  // url: ""
)

#v(-3pt)

#certificates(
  name: "Google Data Analytics Professional Certificate",
  issuer: "Google",
  date: "December 2024",
)

#v(-3pt)

#certificates(
  name: "Dean's List",
  issuer: "University Academic Board",
  date: "May 2024",
)

#v(-0.5pt)

// == Volunteer Experience
//
// #work(
//   company: link("https://example.org")[Code4Community],
//   title: "Tech Volunteer",
//   dates: dates-helper(start-date: "July 2022", end-date: "June 2023"),
//   // location: "Dallas, TX"
// )
//
// - Assisted in teaching basic programming concepts to underprivileged students
// - Supported development of small web tools for local non-profits
// - Organized coding workshops and mentorship sessions
