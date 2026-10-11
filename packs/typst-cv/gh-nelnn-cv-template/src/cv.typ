#import "template.typ": *

#import "@preview/fontawesome:0.6.0": *

#show: template_cv

#let config = toml("../config.toml")

#align(center)[
  #text(size: 14pt)[#config.me.name] #h(0.2em)
  #text(size: 10pt, style: "italic", fill: rgb("#626262"))[(#config.me.pronouns)]
  #v(-0.2em)

  #fa-house() #(config.me.address) • #fa-mobile-screen() #(config.me.phone)
  #v(-0.5em)

  #fa-envelope() #link("mailto:" + config.me.email)[#config.me.email]
  • #link(config.me.github)[#fa-github() GitHub]
  • #link(config.me.website)[#fa-earth-asia() #(config.me.website)]
  #v(0.5em)
]


// = Summary
#box(inset: (x: 0.2in))[
  #text(size: 10pt, style: "italic")[
    #set par(justify: true)
    Visionary multidisciplinary technologist with 500+ years of experience
    across engineering, design, and applied sciences. Proven track record of
    delivering innovative solutions ahead of market demand. Passionate about
    pushing boundaries and disrupting industries with out-of-the-box thinking.
    Looking to leverage my cross-functional expertise in a dynamic tech environment.
  ]
]


= EXPERIENCE

#experience(config.exp.job2)
- Architected and deployed 15+ large-scale military engineering projects including
  tanks, helicopters, and siege weapons—demonstrating full-stack hardware/software
  integration capabilities
- Led cross-functional teams of 50+ artisans, implementing agile methodologies
  centuries before Scrum was invented
- Optimized workflows through innovative project management techniques,
  reducing delivery time by 40% using just papyrus and quills

#experience(config.exp.job1)
- Consulted for aristocratic clients on complex engineering challenges
- Developed proofs-of-concept for flying machines, submarines, and solar
  power—validating feasibility through rigorous mathematical modeling
- Managed end-to-end product lifecycle from ideation to prototyping


= PROJECTS

#table(
  columns: (1fr, 3fr, 1fr),
  inset: (x: 6pt, top: 5pt),
  stroke: 0pt,
  [*The Last Supper™*],
  [
    - Led high-stakes frontend redesign for high-profile client (Jesus + 12)
    - Implemented rapid iteration cycles to meet tight deadline
    - Delivered scalable visual solution with lasting cultural impact
  ],
  [
    #fa-paintbrush() UI/UX \
    #fa-palette() Color Theory
  ],
  table.hline(stroke: (paint: gray, thickness: 0.5pt, dash: "dotted")),
  [*Mona Lisa MVP*],
  [
    - Built revolutionary user interface featuring smile toggle
    - Achieved 500+ year user retention (still going strong)
    - Launched to critical acclaim and sustained viral engagement
  ],
  [
    #fa-paintbrush() Frontend \
    #fa-brain() Deep Learning \
    #fa-eye() Computer Vision
  ],
  table.hline(stroke: (paint: gray, thickness: 0.5pt, dash: "dotted")),
  [*Flying Machine Prototype*],
  [
    - First-mover in aerial mobility sector, 400 years before competitors
    - Conducted extensive user research (observing birds)
    - Pivoted from helicopter to ornithopter based on feedback
  ],
  [
    #fa-plane() Aerospace \
    #fa-flask() Prototyping \
    #fa-bug() Simulation
  ],
  table.hline(stroke: (paint: gray, thickness: 0.5pt, dash: "dotted")),
  [*Notebooks Collection*],
  [
    - Maintained 5,000+ pages of technical documentation in reverse
      handwriting (mirror script)
    - Self-coded encryption using unique cipher for IP protection
    - Demonstrates advanced DevOps and secrets management
  ],
  [
    #icon("linux") Linux \
    #fa-code() Cryptography \
    #fa-book() Technical Writing
  ],
)


= SKILLS

#table(
  columns: (0.25fr, 1fr),
  inset: (x: 6pt, y: 5pt),
  stroke: 0pt,
  [*#fa-paintbrush() Design*],
  [
    - UI/UX: #skills(
        (fa-palette(), "Color Theory"),
        (fa-eye(), "Visual Composition"),
        (fa-paintbrush(), "Illustration"),
      )
    - Tools: #skills(
        (fa-pen(), "Pen & Ink"),
        (fa-paintbrush(), "Chiaroscuro"),
        (fa-palette(), "Sfumato"),
      )
  ],

  [*#fa-cogs() Engineering*],
  [#skills(
    (fa-gears(), "Mechanical"),
    (fa-bolt(), "Electrical"),
    (fa-hammer(), "Materials"),
    (fa-bridge(), "Structural"),
  )],

  [*#fa-flask() Science*],
  [#skills(
    (fa-dna(), "Genetics"),
    (fa-mountain(), "Geology"),
    (fa-leaf(), "Botany"),
    (fa-bone(), "Anatomy"),
  )],

  [*#fa-brain() AI/ML*],
  [
    - Pioneer in humanoid robotics and machine learning concepts
    - #skills(
        (fa-robot(), "Autonomous Systems"),
        (fa-eye(), "Computer Vision"),
        (fa-feather(), "NLP (reverse handwriting)"),
      )
  ],

  [*#fa-language() Languages*],
  [#skills(
    (fa-earth-europe(), "Italian (native)"),
    (fa-earth-americas(), "Latin (fluent)"),
    (fa-earth-asia(), "Mirror Script (expert)"),
  )],

  [*#fa-users() Soft Skills*],
  [
    - Stakeholder management (worked with popes, dukes, and kings)
    - Cross-functional leadership (50+ person teams)
    - Client relations (high-profile aristocratic portfolio)
  ],
)



= EDUCATION

#education(config.edu.uni1)
- Mastered painting, sculpture, architecture, music, mathematics, engineering,
  literature, anatomy, geology, astronomy, botany, paleontology, and cartography
- Specialised in human-centred design principles and observational research
- Thesis: "Why Left-Handedness is Actually an Advantage in Technical Drawing"


