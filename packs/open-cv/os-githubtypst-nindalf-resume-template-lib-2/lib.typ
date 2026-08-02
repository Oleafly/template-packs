#import "@preview/fontawesome:0.5.0": *

#let resume(
  name: "",
  title: "",
  email: "",
  phone: "",
  github: "",
  linkedin: "",
  location: "",
  work: (),
  education: (),
  skills: (),
) = {
  // Page setup with reduced margins
  set page(
    paper: "a4",
    margin: (left: 1.5cm, right: 1.5cm, top: 1.5cm, bottom: 1.5cm),
  )
  
  // Font setup
  set text(font: "Noto Sans", size: 9pt, weight: "regular")
  
  // Name and title at the top
  align(center)[
    #text(font: "Spectral", size: 24pt, weight: "regular")[#name]
    #v(2pt)
    #text(font: "Spectral", size: 16pt, weight: "regular", fill: rgb("#424242"))[#title]
    #v(8pt)
  ]
  
  // Helper function for section headings with improved typography - left justified with small caps
  let section-heading(title) = {
    text(font: "Spectral", size: 13pt, weight: "light", tracking: 1pt, fill: rgb("#212121"))[
      #underline(offset:4pt)[#smallcaps[#title]]
    ]
  }
  
  // Helper function for dates with compact formatting
  let date-format(start-date, end-date, duration) = {
    text(size: 9pt, font: "Spectral", weight: "semibold")[
      #smallcaps[#start-date – #end-date]
      #if duration != none [
        #v(2pt)
        #smallcaps[#duration]
      ]
    ]
  }
  
  // Basic section layout with reduced spacing
  let basic-layout(section-name, content) = {
    grid(
      columns: (30%, 70%),
      gutter: 0pt,
      // Section heading column - left justified
      [
        #section-heading(section-name)
      ],
      // Content column with left border
      box(
        width: 100%,
        inset: (left: 12pt),
        stroke: (left: 0.5pt + rgb("#e0e0e0")),
        [#content]
      )
    )
    v(20pt) // Reduced spacing between sections
  }
  // Contact section
  basic-layout(
    "Contact",
    {
      let rows = ()
      
      if email != "" {
        rows.push(fa-icon("envelope"))
        rows.push(text(size: 9pt)[#email])
      }
      
      if phone != "" {
        rows.push(fa-icon("phone"))
        rows.push(text(size: 9pt)[#phone])
      }
      
      if github != "" {
        rows.push(fa-icon("github"))
        rows.push(text(size: 9pt, fill: rgb("#0277bd"))[#link("https://github.com/" + github, [#github])])
      }

      if linkedin != "" {
        rows.push(fa-icon("linkedin"))
        rows.push(text(size: 9pt, fill: rgb("#0277bd"))[#link("https://linkedin.com/in/" + linkedin, [#linkedin])])
      }
      
      grid(
        columns: (5%, 95%),
        row-gutter: 8pt,
        ..rows
      )
    }
  )
  
  // Location section
  basic-layout(
    "Location",
    {
      grid(
        columns: (5%, 95%),
        row-gutter: 8pt,
        fa-icon("location-dot"),
        text(size: 9pt)[#location],
      )
    }
  )
  
  // Work Experience section header
  grid(
    columns: (30%, 70%),
    gutter: 0pt,
    [
      #section-heading("Work Experience")
    ],
    []
  )
  v(6pt)
  
  // Work Experience entries
  for job in work {
    grid(
      columns: (30%, 70%),
      gutter: 0pt,
      // Left column with dates
      align(left)[
        #if job.keys().contains("dates") {
          date-format(job.at("dates").at("start"), job.at("dates").at("end"), job.at("dates").at("duration"))
        }
      ],
      // Right column with job details
      box(
        width: 100%,
        inset: (left: 12pt),
        stroke: (left: 0.5pt + rgb("#e0e0e0")),
        {
          text(size: 9pt, weight: "bold")[#job.at("title")]
          if job.at("company", default: none) != none {
            [ #text(size: 9pt)[at] #text(size: 9pt, fill: rgb("#0277bd"))[
              #if job.at("company").keys().contains("url") {
                link(job.at("company").at("url"), job.at("company").at("name"))
              } else {
                job.at("company").at("name")
              }
            ] #text(size: 9pt)[:]]
          }
          v(3pt)
          text(size: 9pt)[#job.at("description")]
          v(2pt)
          
          // Job highlights/bullet points
          for highlight in job.at("highlights") {
            grid(
              columns: (8pt, auto),
              gutter: 3pt,
              text(size: 9pt)[•],
              text(size: 9pt)[#highlight]
            )
            v(1pt) // Reduced spacing between bullet points
          }
        }
      )
    )
    v(7pt) // Spacing between job entries
  }
  
  // Education section header
  grid(
    columns: (30%, 70%),
    gutter: 0pt,
    [
      #section-heading("Education")
    ],
    []
  )
  v(10pt)
  
  // Education entries
  for edu in education {
    grid(
      columns: (30%, 70%),
      gutter: 0pt,
      // Left column with dates
      align(left)[
        #if "dates" in edu {
          date-format(edu.at("dates").at("start"), edu.at("dates").at("end"), none)
        }
      ],
      // Right column with education details
      box(
        width: 100%,
        inset: (left: 12pt),
        stroke: (left: 0.5pt + rgb("#e0e0e0")),
        {
          text(size: 9pt, weight: "bold")[#edu.at("institution")]
          v(2pt)
          
          // Format for education degree
          grid(
            columns: (8pt, auto),
            gutter: 3pt,
            text(size: 9pt)[•],
            text(size: 9pt)[Bachelors: #edu.at("degree")]
          )
        }
      )
    )
    v(6pt) // Spacing between education entries
  }
  
  // Skills section with compact formatting
  basic-layout(
    "Skills",
    {
      for (category, items) in skills {
        grid(
          columns: (1fr),
          row-gutter: 2pt,
          text(size: 9pt)[#text(weight: "bold")[#category]: #items.join(", ")]
        )
        v(2pt)
      }
    }
  )
}