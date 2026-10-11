#set document(author: "Your Name", title: "Resume")
#set page(margin: (x: 0.8cm, y: 1cm))
#set text(font: "New Computer Modern", size: 10pt, lang: "en")

// Color scheme
#let primary-color = rgb("#2563eb")
#let secondary-color = rgb("#64748b")
#let accent-color = rgb("#0ea5e9")
#let light-gray = rgb("#f8fafc")
#let dark-gray = rgb("#334155")

// Custom styling for the header
#show heading.where(level: 1): it => block(width: 100%)[
  #set align(center)
  #set text(2.2em, weight: "bold", fill: primary-color)
  #it.body
  #v(0.3em)
]

// Section headers with modern styling
#show heading.where(level: 2): it => block(
  width: 100%,
  inset: (bottom: 0.5em, top: 1em)
)[
  #set text(1.1em, weight: "bold", fill: primary-color)
  #grid(
    columns: (auto, 1fr),
    gutter: 0.5em,
    align: (left, horizon),
    text(fill: primary-color)[#it.body],
    line(length: 100%, stroke: 2pt + primary-color)
  )
]

// Skill badge with modern design
#let skill-badge(name, color: primary-color) = {
  box(
    fill: color.lighten(90%),
    stroke: 1pt + color.lighten(60%),
    inset: (x: 8pt, y: 4pt),
    radius: 6pt,
    text(
      fill: color.darken(10%), 
      size: 8.5pt, 
      weight: "medium"
    )[#name]
  )
}

// Modern project card
#let project-card(name, desc, tech, link: none, featured: false) = {
  let card-fill = if featured { light-gray } else { white }
  let border-color = if featured { primary-color } else { secondary-color.lighten(40%) }
  
  box(
    width: 100%,
    fill: card-fill,
    stroke: 1pt + border-color,
    radius: 8pt,
    inset: 1em
  )[
    #grid(
      columns: (1fr, auto),
      align: (left, right),
      gutter: 0.5em,
      [
        #text(size: 11pt, weight: "bold", fill: dark-gray)[#name]
        #if featured [
          #h(0.3em)
          #box(
            fill: accent-color,
            inset: (x: 6pt, y: 2pt),
            radius: 4pt,
            text(fill: white, size: 7pt, weight: "bold")[FEATURED]
          )
        ]
      ],
      if link != none {
        text(size: 8pt, fill: accent-color, style: "italic")[#link]
      }
    )
    #v(0.3em)
    #text(size: 9.5pt, fill: secondary-color)[#desc]
    #v(0.5em)
    #box[#tech.map(t => skill-badge(t, color: accent-color)).join(h(4pt))]
  ]
}

// Contact info styling
#let contact-item(icon, content) = {
  grid(
    columns: (auto, 1fr),
    gutter: 0.3em,
    align: (center, left),
    text(fill: primary-color, size: 10pt)[#icon],
    text(size: 9.5pt)[#content]
  )
}

// Experience entry with modern layout
#let experience-entry(title, company, duration, location, responsibilities) = {
  box(
    width: 100%,
    inset: (left: 1em, right: 1em, top: 0.8em, bottom: 0.8em),
    stroke: (left: 3pt + accent-color),
    fill: light-gray.lighten(50%)
  )[
    #grid(
      columns: (1fr, auto),
      align: (left, right),
      [
        #text(weight: "bold", size: 11pt, fill: dark-gray)[#title]
        #linebreak()
        #text(size: 10pt, fill: primary-color, style: "italic")[#company]
      ],
      [
        #text(size: 9pt, fill: secondary-color)[#duration]
        #linebreak()
        #text(size: 9pt, fill: secondary-color)[#location]
      ]
    )
    #v(0.4em)
    #for responsibility in responsibilities [
      • #text(size: 9.5pt)[#responsibility]
      #linebreak()
    ]
  ]
}

// Header section
#align(center)[
  = [Your Name]
  
  #v(-0.5em)
  #text(size: 12pt, fill: secondary-color, style: "italic")[[Your Professional Title]]
  
  #v(0.8em)
  #grid(
    columns: 4,
    gutter: 2em,
    align: center,
    contact-item("📧", "[your.email@example.com]"),
    contact-item("📱", "[+1 (555) 123-4567]"),
    contact-item("💼", "[linkedin.com/in/yourprofile]"),
    contact-item("🔗", "[github.com/yourusername]")
  )
]

#v(0.5em)

// Professional Summary with modern card
#box(
  width: 100%,
  fill: gradient.linear(primary-color.lighten(95%), accent-color.lighten(95%), angle: 45deg),
  stroke: 1pt + primary-color.lighten(70%),
  radius: 10pt,
  inset: 1.2em
)[
  == Professional Summary
  #v(-0.5em)
  #text(size: 10.5pt, fill: dark-gray)[
    [Write a compelling 2-3 sentence professional summary that highlights your key skills, experience, and career objectives. Focus on what makes you unique and the value you bring to potential employers.]
  ]
]

== Technical Skills

#grid(
  columns: 1,
  gutter: 0.8em,
  
  [
    *Languages & Core Technologies*
    #v(0.3em)
    #("[Add your programming languages here]", "[e.g., JavaScript]", "[TypeScript]", "[Python]", "[etc.]").map(skill => skill-badge(skill)).join(h(4pt))
  ],
  
  [
    *Frontend & UI Frameworks* 
    #v(0.3em)
    #("[Frontend technologies]", "[e.g., React]", "[Next.js]", "[Vue.js]", "[etc.]").map(skill => skill-badge(skill, color: rgb("#7c3aed"))).join(h(4pt))
  ],
  
  [
    *Backend & Infrastructure*
    #v(0.3em) 
    #("[Backend frameworks]", "[e.g., Node.js]", "[Django]", "[Express]", "[etc.]").map(skill => skill-badge(skill, color: rgb("#dc2626"))).join(h(4pt))
  ],
  
  [
    *Development & Tools*
    #v(0.3em)
    #("[Development tools]", "[e.g., Git]", "[Docker]", "[VS Code]", "[etc.]").map(skill => skill-badge(skill, color: rgb("#059669"))).join(h(4pt))
  ]
)

== Featured Projects

// Example project card - replace with your projects
#grid(
  columns: 2,
  gutter: 1em,
  
  project-card(
    "[Project Name 1]",
    "[Brief description of your project, what it does, and why it's significant. Mention key features or achievements.]",
    ("[Tech1]", "[Tech2]", "[Tech3]"),
    link: "[github.com/yourusername/project1]",
    featured: true
  ),
  
  project-card(
    "[Project Name 2]", 
    "[Another project description. Highlight the problem it solves and your role in developing it.]",
    ("[Tech1]", "[Tech2]", "[Tech3]"),
    link: "[github.com/yourusername/project2]",
    featured: true
  ),
  
  project-card(
    "[Project Name 3]",
    "[Third project description. Focus on technical challenges overcome and results achieved.]",
    ("[Tech1]", "[Tech2]", "[Tech3]"),
    link: "[github.com/yourusername/project3]"
  ),
  
  project-card(
    "[Project Name 4]",
    "[Fourth project description. Mention any metrics, user impact, or recognition received.]",
    ("[Tech1]", "[Tech2]", "[Tech3]"),
    link: "[github.com/yourusername/project4]"
  )
)

#v(0.5em)

== Additional Projects

#grid(
  columns: 2,
  gutter: 1.2em,
  [
    #box(inset: 0.5em, stroke: (left: 2pt + secondary-color))[
      *[Project Name A]* – [Brief one-line description of the project and its purpose]
      
      *[Project Name B]* – [Another project with key technologies or achievements mentioned]
      
      *[Project Name C]* – [Third project focusing on what makes it unique or valuable]
    ]
  ],
  [
    #box(inset: 0.5em, stroke: (left: 2pt + secondary-color))[
      *[Project Name D]* – [Fourth project with emphasis on technical skills demonstrated]
      
      *[Project Name E]* – [Fifth project highlighting any special recognition or impact]
      
      *[Project Name F]* – [Sixth project showing range of abilities and interests]
    ]
  ]
)

== Professional Experience

// Example experience entry - replace with your experience
#experience-entry(
  "[Job Title]",
  "[Company Name]",
  "[Start Date] - [End Date]",
  "[City, State/Country]",
  (
    "[Describe a key responsibility or achievement with specific metrics if possible]",
    "[Another accomplishment that demonstrates your skills and impact]",
    "[Technical contribution or project you led/contributed to significantly]",
    "[Any process improvements, team collaboration, or leadership examples]"
  )
)

#v(0.5em)

#experience-entry(
  "[Previous Job Title]",
  "[Previous Company]",
  "[Start Date] - [End Date]", 
  "[City, State/Country]",
  (
    "[Previous role responsibility showing career progression]",
    "[Achievement that relates to your target position]",
    "[Technical or soft skill demonstration from this role]"
  )
)

== Education & Achievements

#grid(
  columns: (1fr, 1fr),
  gutter: 2em,
  [
    *Education*
    #box(inset: 0.8em, fill: light-gray, radius: 6pt)[
      *[Degree Name, e.g., Bachelor of Science in Computer Science]*
      #linebreak()
      [University Name] • [Graduation Year]
      #linebreak()
      #text(size: 9pt, fill: secondary-color)[Relevant coursework: [List key courses], GPA: [if above 3.5]]
    ]
  ],
  [
    *Key Achievements*
    #box(inset: 0.8em, fill: light-gray, radius: 6pt)[
      • [Notable achievement, certification, or award]
      #linebreak()
      • [Open source contributions, publications, or speaking]  
      #linebreak()
      • [Technical certifications or professional recognition]
      #linebreak()
      • [Leadership roles, volunteer work, or community involvement]
    ]
  ]
)

// Optional: Add certifications section
== Certifications

#grid(
  columns: 2,
  gutter: 1em,
  [
    • *[Certification Name]* - [Issuing Organization], [Year]
    • *[Another Certification]* - [Organization], [Year]
  ],
  [
    • *[Third Certification]* - [Organization], [Year] 
    • *[Professional Certification]* - [Organization], [Year]
  ]
)