// April Kidd's Resume Template
// Based off Jake's Resume

// ==========================================
// CONFIGURATION & STYLING
// ==========================================

#set page(
  paper: "us-letter",
  margin: (x: 0.5in, y: 0.5in),
)

#set text(
  font: "New Computer Modern",
  size: 10.8pt,
  lang: "en",
)

// Paragraph and list spacing
#set par(leading: 0.55em, justify: true)
#set list(indent: 1.5em, body-indent: 0.5em, spacing: 0.6em)

// ==========================================
// HELPER FUNCTIONS (MACROS)
// ==========================================

#let section_header(title) = {
  v(0.8em)
  text(size: 12pt, weight: "bold", smallcaps(title))
  v(-0.6em)
  line(length: 100%, stroke: 0.6pt + black)
  v(0.2em)
}

#let resume_subheading(title, date, org, loc) = {
  block(width: 100%, breakable: false)[
    #grid(
      columns: (1fr, auto),
      align(left)[*#title*], align(right)[#date],
    )
    #v(-0.5em)
    #grid(
      columns: (1fr, auto),
      align(left)[#emph(org)], align(right)[#emph(loc)],
    )
  ]
}

#let resume_project_heading(title, date) = {
  block(width: 100%, breakable: false)[
    #grid(
      columns: (1fr, auto),
      align(left)[#title], align(right)[#date],
    )
    #v(-0.5em)
  ]
}

#let education_entry(uni, degree, awards, gpa, date, loc) = {
  grid(
    columns: (1fr, auto),
    align(left)[
      *#uni* \
      #emph(degree) \
      #text(size: 0.9em)[#awards] \
      #text(size: 0.9em)[*#gpa*]
    ],
    align(right)[
      #date \
      #loc
    ],
  )
}

// ==========================================
// DOCUMENT CONTENT
// ==========================================

// --- Header ---
#align(center)[
  #v(-1em)
  #text(size: 20pt, weight: "bold", "NAME PLACEHOLDER") \
  #v(0.2em)
  #text(size: 10pt)[
    +61 000 000 000 $|$
    #link("mailto:email@example.com")[email\@example.com] $|$
    #link("https://linkedin.com/in/username")[linkedin.com/in/username] $|$
    #link("https://github.com/username")[github.com/username]
  ]
]

// --- Education ---
#section_header("Education")

#education_entry(
  "University Name",
  "Degree Name (Major)",
  "Honours, Scholarships, or Notable Awards",
  "GPA: X.XX / 7.00",
  "Month Year - Present",
  "Location, State",
)

// --- Experience ---
#section_header("Experience")

#resume_subheading(
  "Job Title",
  "Month Year - Present",
  "Company Name",
  "Location, State",
)
#list(
  [Action verb oriented description of your primary responsibility.],
  [Quantifiable achievement using specific tools or methodologies.],
  [Collaborated with teams to achieve a specific business or technical outcome.],
)

#resume_subheading(
  "Job Title",
  "Month Year - Month Year",
  "Company Name",
  "Location, State",
)
#list(
  [Developed and maintained [System/Software] using [Languages/Tools].],
  [Improved [Metric] by [Percentage] through refactoring or optimisation.],
)

// --- Projects and Competitions ---
#section_header("Projects and Competitions")

#resume_project_heading(
  [*Project Name* $|$ _Tech Stack (e.g., Python, C++)_],
  "Month Year",
)
#list(
  [Briefly describe the goal of the project or competition.],
  [Highlight a specific technical challenge solved or a ranking achieved.],
)

#resume_project_heading(
  [*Competition Name*],
  "Month Year",
)
#list(
  [Award, Ranking, or notable achievement in the competition context.],
)

// --- Technical Skills ---
#section_header("Technical Skills")
#list(
  marker: none,
  indent: 0pt,
  body-indent: 0pt,
  [
    *Languages*: Python, C++, Java, R \
    *Libraries/Frameworks*: NumPy, pandas, PyTorch, scikit-learn \
    *Tools*: Git, Docker, Linux, LaTeX
  ],
)
