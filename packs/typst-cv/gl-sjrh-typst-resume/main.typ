#import "@preview/finely-crafted-cv:0.3.0": *

// manage numbering of headings
#let nonumber(..) = " "
#set heading(numbering: nonumber)

// alternative to make sure headings are not numbered
// #let nonumber(body) = {
//   set heading(numbering: none)
//   body
// }

#let pazaz(term) = box[✨ #term ✨]
#let __settings = state("__cv_settings", (:))
#let __get(key) = {
  __settings.final().at(key, default: none)
}

#let school-heading2(title, location: none, start: none, end: none, icon: none, comment: none, body) = {
 let icon_spacing = if icon != none { 0.25em } else { 0em }
block(
    below: 0.3em,
    breakable: false,
    // heading
     grid(
      columns: (auto, auto, 1fr, auto),
      column-gutter: (icon_spacing, 0.5em),
      row-gutter: 0.5em,
      align: (left + horizon, left + horizon, right + horizon),

      // first column, optional icon
      if icon != none { box(height: COMPANY_ICON_SIZE, icon) },

      // second column, school name
      context text(
        //style: "normal",
        weight: "bold",
        size: 1.1em,
        font: __get("heading-font"),
        title
      ),

      // third column,  ellipsis
          if start != none {
        repeat(h(0.3em) + "." + h(0.3em))
              } else {
        []
      },

      // fourth column, optional dates
      context text(
        weight: "bold",
        size: 1.1em,
        font: __get("heading-font"),

        if start != none {
          [#start -- #end]
        } else {
          [ ]
        }
      ),
      grid.cell(colspan: 4, body)
    )
  )
}


#let company-heading2(title, location: none, start: none, end: none, icon: none, comment: none, body) = {
 let icon_spacing = if icon != none { 0.25em } else { 0em }
block(
    below: 0.5em,
    breakable: false,
    // heading
     grid(
      columns: (auto, auto, 1fr, auto),
      column-gutter: (icon_spacing, 0.5em),
      row-gutter: 0.5em,
      align: (left + horizon, left + horizon, right + horizon),

      // first column, optional icon
      if icon != none { box(height: 1em, icon) },

      // second column, school name
      context text(
        //style: "normal",
        weight: "bold",
        size: 1.1em,
        font: __get("heading-font"),
        title
      ),

      // third column,  ellipsis
          if start != none {
        repeat(h(0.3em) + "." + h(0.3em))
              } else {
        []
      },

      // fourth column, optional dates
      context text(
        weight: "bold",
        size: 1.1em,
        font: __get("heading-font"),

        if start != none {
          [#start -- #end]
        } else {
          [ ]
        }
      ),
      grid.cell(colspan: 4, body)
    )
  )
}

#show: resume.with(
  name: "Jack Holbrook",
  tagline: "Software Engineer with a background in data engineering research and environmental science",
  keywords: "Software Engineering, Data Science, Machine Learning, Information Technology, GIS, Environmental Science",
  icon-contact-header: (
    (image("icons/email.svg"),              link("mailto:jholbroo@protonmail.com", "jholbroo@protonmail.com")),
    (image("icons/phone.svg"),              link("tel:+12062145908", "+1 206-214-5908")),
    (image("icons/gitlab-svgrepo-com.svg"), link("https://gitlab.com/jh8839")), // linky to my gitlab
    //(image("icons/linkedin.svg"), link("https://www.linkedin.com/non-existent", "Jack Holbrook")),
  ),
)

//= Motivation // -commented out becuase I did want want a section header for this.
#block()
While researching as a PhD student at New York University, I had the incredible oppurtunity to
apply probablistic data strucutres to the problem of finding related data across disparate
datasets. My skills in data engineering and tooling will become more valuable as companies
search for efficient ways to make sense of their data. I hope I can help solve your data-related
problems at (insert company name here). 

= Experience

#company-heading2("NYU's Visualization, Imaging and Data Analysis Center", start: "September 2023", end: "August 2025",
    icon: image("icons/new-york-arch-svgrepo-com.svg"))[
  #job-heading("Graduate Student Researcher", location: "Brooklyn, NY")[
    - Implemented a tool to geohash addresses as primary keys for sketch-based natural joins in
      relational databases
    - Presented my research in monthly group meetings to other lab members
  ]
]

#company-heading2("Earthdefine", start: "April 2022", end: "July 2023", icon: image("./icons/earth.svg"))[
  #job-heading("GIS Analyst", location: "Redmond, WA")[
    - Automated the translation of image files to different photometric bands, reducing product delivery time for customers
    - Created a new company dataset for road detection and classification from aerial imagery which was used for the
      training of the company’s semantic segmentation model to create its land cover product
    - Analyzed the location accuracy of addresses queried from online geo-coding providers for the development of the
      company’s building footprint data product
  ]
]

#company-heading2("Tata Consultancy services North America", start: "November 2021", end: "August 2022",
      icon: image("icons/binary-code-binary-svgrepo-com.svg"))[
  #job-heading("Software Engineer", location: "Renton, WA")[
    - Administered the Boeing Company’s Managed File Transfer Service (MFTS) which its employees used to send files
    - Set up and troubleshooted new SFTP File Transfer connections for Boeing’s business partners
  ]
]

#company-heading2("United States Geological Survey", start: "May 2021", end: "September 2021",
icon: image("icons/microscope.svg"))[
  #job-heading("Research Fellow", location: "Remote, WI",
    comment: []
  )[
    - Created and Presented an inter-annual temperature analysis on river temperature data from the Delaware River Basin
    - Ran quality assurance and quality contorl on the agency's public data releases from hydrographic monitoring stations
  ]
]

#company-heading2("University Of California Santa Barbara, MOVE Lab", start: "October 2020", end: "March 2021",
icon: image("icons/palm-tree.svg"))[
  #job-heading("Research Fellow", location: "Remote, WI",
    comment: []
  )[
    - Created maps to visualize the paths of GPS-tracked tigers in a wildlife sanctuary
    - Created a software program that pulled data from GPS-tracked tigers to supply the researchers with their newest data
  ]
]

= Open-Source Projects

// #link(
//   "insert link to st_corrsketch gitlab repo here!",
//   strong("Spatio-Temporal Correlation Sketches for Data Discovery")
// )
// #quote[A python library which uses... ]

#link(
  "insert link to SQLITE_KMV_UDF gitlab repo here!",
  strong("AKMV sketches for interacting with a sqlite database")
  )
  #emph[A python library which uses pyhton's exisiting sqlite3 connection layer to generate AKMV sketches
  (Beyer, 2007) from queyered relations in a sqlite database.]

= Technology Skills

Python3, numpy, scipy, cython, urllib3, SQLite, PostreSQL, MySQL, Javascript, D3.js, JQuery, HTML & CSS & HTTP verbs.

= Education and Achievements

#school-heading2("Georgia Institute of Technology", start: "January 2026", end: "June 2028 (Anticipated)")[
  #degree-heading("M.S. in Computer Science")[]
  //#degree-heading2("test")[]
]
#school-heading2("New York University, Tandon School of Engineering", start: "Sepetember 2023", end: "May 2025")[
  #degree-heading("No Degree Conferred, Graduate Coursework in Computer Science")[
  #h(1cm) NSF CSGRAD4US Fellowship recipient]
]
#school-heading2("Seattle University", start: "January 2021", end: "June 2022")[
  #degree-heading("Certificate, Computer Science")[]
]
#school-heading2("University of California, Santa Barbara", start: "September 2017", end: "December 2020")[
  #degree-heading("B.A. in Geography, Emphasis in Geographic Information Systems")[
  #h(1cm) Raab Writers fellowship recipient, Spring 2020]
]
