#let author = "Robert Bobinson"
#let accent_color = rgb("#d43520")
#let text_size = 11.3pt
#let name_font = "P052"
#let main_font = "Lato"
#let bullet_baseline = 1.6pt

#let contact_info(linkedin, email, phone) = {
  set text(size: 12pt)
   
  // Personal Info
  align(center, [
  #h(1fr)
    #box(baseline: 25%, image(height: 16pt, "svg/linkedin.svg"))
    #link("https://www." + linkedin)[#linkedin]
    #h(1fr)
    #box(baseline: 27%, image(height: 16pt, "svg/phone.svg"))
    #text([#phone])
    #h(1fr)
    #box(baseline: 29%, image(height: 16pt, "svg/email.svg"))
    #link("mailto:" + email)[#email]
    #h(1fr)
  ])
}

#let section_header(title, accent_color) = {
  text(16pt, weight: "bold", fill: accent_color)[
    #title
  ]
  v(-13pt)
  line(length: 100%, stroke: 2pt + accent_color)
}


// Sets document metadata
#set document(author: author, title: author)

// Disable ligatures so ATS systems do not get confused when parsing fonts.
#set text(lang: "en", ligatures: false)

#set page(paper: "us-letter", margin: (x: 1cm, y: 1cm))

// Link styles
#show link: underline

#set text(font: name_font)

#align(center, text(28pt, weight: "bold")[
  #author
])

#set text(font: main_font, size: text_size)
#v(-25pt)

#set list(marker: [
  #text(7pt, weight: "bold", fill: accent_color, baseline: bullet_baseline)[▪]
], body-indent: 0.4em)

#contact_info("linkedin.com/in/robberbob", "money@for.free", "346-420-1337")

// Work ********************************
#v(-12pt)
#section_header("Work Experience", accent_color)
#v(-7pt)

// First company
#text(15pt, weight: "bold")[
  Plastroltech Inc.
] 
#h(1fr)
#text(text_size + 1pt, baseline: -1pt)[
$space$$space$$space$$space$$space$$space$$space$$space$$space$$space$$space$$space$
$space$$space$$space$$space$$space$$space$$space$$space$$space$$space$$space$$space$
$space$$space$$space$$space$
  Arvada, CO
]
#h(1fr)
#text(text_size + 1pt, style: "italic", baseline: -1pt)[
  8/2024 $dash.en$ Present
]

#pad(
  left: 0.4cm,
  [
    #v(-4pt)
    #text(14pt, weight: "bold")[
      Lead Principal Chief B2B SAAS Sales Specialist
    ] 
    #h(1fr)
    #text(text_size + 1pt, style: "italic", baseline: -1pt)[
      8/2024 $dash.en$ Present
    ]
    - Architected 46.9% product growth year over year by leveraging breakthrough snowball waterfall landfills
    - Orchestrated migration to web3 cloud-based AI platform powered by Kuberenetes
    - Spearheaded synergistic cross-functional initiatives, leveraging dynamic paradigms to optimize holistic scalability and drive unprecedented stakeholder-centric innovation across the value stream ecosystem
  ],
)

// Second company
#text(15pt, weight: "bold")[
  Doofenshmirtz Evil Incorporated
] 
#h(1fr)
#text(text_size + 1pt, baseline: -1pt)[
  Tri-state area
]
#h(1fr)
#text(text_size + 1pt, style: "italic", baseline: -1pt)[
  2021 $dash.en$ 2024
]

#pad(
  left: 0.4cm,
  [
    #v(-4pt)
    #text(14pt, weight: "bold")[
      Minion
    ] 
    #h(1fr)
    #text(text_size + 1pt, style: "italic", baseline: -1pt)[
      6/2023 $dash.en$ 8/2024
    ]
    - Pioneered disruptive evil-innovation frameworks, aligning villainous strategic objectives with core doomsday deliverables to maximize nefarious ROI and optimize cross-functional henchman synergy.
    - Led a cross-discipline team of minions to operationalize cutting-edge destruction tools, leveraging integrated malicious architectures to drive forward-thinking chaos at scale while ensuring sustained evil transformation.
    - Architected next-gen evil initiatives by orchestrating a holistic, villain-centric roadmap, enabling dynamic disarray and iterative havoc delivery within the competitive landscape of global villainy.
     
    #v(-4pt)
    #text(14pt, weight: "bold")[
      Chief Executive Officer of Unscheduled Asset Reallocation
    ] 
    #h(1fr)
    #text(text_size + 1pt, style: "italic", baseline: -1pt)[
      Summers of 2022 & 2023
    ]
    - Robbed banks
  ],
)

// Education ********************************
#v(-9pt)
#section_header("Education", accent_color)
#v(-7pt)

#text(15pt, weight: "bold")[
  Tri-State State University
]
#h(1fr)
$space$$space$$space$$space$$space$$space$$space$$space$
#text(text_size + 1pt, baseline: -1pt)[
  Hawaii
]
#h(1fr)
#text(text_size + 1pt, style: "italic", baseline: -1pt)[
  2019 $dash.en$ 2023
]
#v(-7pt)
Master of Science in Art
#h(1fr)
#text(text_size + 1pt, style: "italic", baseline: -1pt)[
  5/2023
]
#v(-7pt)
Bachelor of Arts in Science
#h(1fr)
#text(text_size + 1pt, style: "italic", baseline: -1pt)[
  12/2022
]

#pad(
  left: 0.4cm,
  [
    #v(-4pt)
    #text(14pt, weight: "bold")[
      Founder & President: Heckathon Club
    ]
    #h(1fr)
    #text(text_size + 1pt, style: "italic", baseline: -1pt)[
      2019 $dash.en$ 2023
    ]
    - 9001x heckathon winner
    - Made competitors cry on a regular basis
  ],
)

// Projects ********************************
#v(-9pt)
#section_header("Projects", accent_color)
#v(-7pt)

#text(15pt, weight: "bold")[
  Anti-speedbump car
] 
#h(1fr)
#text(text_size + 1pt, style: "italic", baseline: -1pt)[
  8/2023 $dash.en$ 9/2023
]
- Designed 48-inch active air suspension system
- Vehicle can cruise through parking lots and school zones at 120mph


// Skills ********************************
#v(-9pt)
#section_header("Skills", accent_color)
#v(-7pt)
Evil, Minecraft command block programming, having W rizz