#import "@preview/basic-resume:0.2.9": *

// Load CV data from YAML (default: cv.yaml, override with --input cv=filename.yaml)
#let cv-file = sys.inputs.at("cv", default: "cv.yaml")
#let cv = yaml(cv-file)

// Parse markdown-style links [text](url) and render as Typst links
#let parse-links(text) = {
  let result = ()
  let remaining = text
  let link-pattern = regex("\[([^\]]+)\]\(([^)]+)\)")

  while true {
    let match = remaining.match(link-pattern)
    if match == none {
      result.push(remaining)
      break
    }

    // Add text before the link
    if match.start > 0 {
      result.push(remaining.slice(0, match.start))
    }

    // Add the link
    let link-text = match.captures.at(0)
    let link-url = match.captures.at(1)
    result.push(link(link-url)[#link-text])

    // Continue with remaining text
    remaining = remaining.slice(match.end)
  }

  result.join()
}

#show: resume.with(
  author: cv.name,
  location: cv.location,
  email: cv.email,
  github: cv.github,
  linkedin: cv.linkedin,
  phone: cv.phone.join(" | "),
  personal-site: cv.personal_site,
  accent-color: "#26428b",
  font: "Libertinus Serif",
  paper: "us-letter",
  author-position: left,
  personal-info-position: left,
)

// Summary
#cv.summary

== Work Experience

#for job in cv.work_experience [
  #work(
    title: job.title,
    company: job.company,
    location: job.location,
    dates: dates-helper(start-date: job.start_date, end-date: job.end_date),
  )
  #for detail in job.details [
    - #parse-links(detail)
  ]
  #if "tech_stack" in job and job.tech_stack.len() > 0 [
    - *Tech Stack*: #job.tech_stack.join(", ")
  ]
]

== Education

#for edu_item in cv.education [
  #edu(
    institution: edu_item.institution,
    location: edu_item.location,
    degree: edu_item.degree,
    dates: text(font: "Liberation Serif")[#dates-helper(start-date: edu_item.start_date, end-date: edu_item.end_date)],
  )
  #for detail in edu_item.details [
    - #detail
  ]
]

== Skills & Languages

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    *Programming Languages*\
    Advanced: #cv.programming_languages.advanced.join(", ")\
    Intermediate: #cv.programming_languages.intermediate.join(", ")
  ],
  [
    *Languages*\
    #cv.languages.join(", ")

    *Soft Skills*\
    #cv.soft_skills.join(", ")
  ],
)

#if "publications" in cv and cv.publications.len() > 0 [
  == Publications

  #for pub in cv.publications [
    #work(
      title: pub.title,
      company: pub.publisher,
      location: link(pub.url)[#pub.url],
      dates: pub.year,
    )
    - #pub.description
  ]
]

#if "projects" in cv and cv.projects.len() > 0 [
  == Projects & Open Source

  #for project in cv.projects [
    #work(
      title: project.name + " — " + project.type,
      company: link(project.url)[#project.url],
      location: "",
      dates: "",
    )
    - #project.description
    #if "tech_stack" in project and project.tech_stack.len() > 0 [
      - *Tech Stack*: #project.tech_stack.join(", ")
    ]
  ]
]

#if "achievements" in cv and cv.achievements.len() > 0 [
  == Achievements

  #for achievement in cv.achievements [
    - #achievement
  ]
]

