// Typst-Phi-Resume — typst port of Jake's Resume
// Original: https://github.com/jakegut/resume
// Font (Tex Gyre Termes) download:
// https://www.gust.org.pl/projects/e-foundry/tex-gyre/termes/tg_termes-otf-2_609-31_03_2026.zip

#set document(title: "Resume")
#set page(paper: "us-letter", margin: (x: 0.5in, y: 0.5in))

// FILE MAP
//
//   Documentation    STRUCTURE · SPACING · DESIGN SYSTEM comments
//                    How this file is organized. Read once.
//
//   Design system    body-size, ratio, spacing constants
//                    Change body-size to rescale the whole document.
//
//   Functions        top-matter, new-section, entry, minor-entry, ...
//                    Layout primitives. Edit only to change behavior.
//
//   Content          HEADER section onward
//                    Your resume data.

// SPACING
//
//   [section-leading-margin]          
//   Section Title
//   [title-rule-gap]
//   ──────────────────────────────────────────────────
//   [rule-bottom-margin]
//       [row-leading-margin]
//       Row / Entry
//           Primary line
//           [entry-line-gap]
//           Secondary line

// DESIGN SYSTEM
//
// Two free parameters drive the entire document:
//   - body-size: base font size; everything visual derives from this
//   - ratio: proportional step between sizes/spaces (golden, ≈ 1.618)
// First derived value:
//   - line-height: vertical rhythm atom; controls all line and block spacing

// USAGE
// 1. fill in your info, use "" for fields you don't need
// 2. (optional) adjust body-size to fit text on the page better
// 3. run `typst compile <your-doc-name>.typ

// POP CULTURE REFERENCES (in order)
// Jackdaws love my big sphinx of quartz (pangram)
// The Rifleman's Creed, Army of Darkness, Mallrats, Monty Python and the Holy Grail, Enter the Dragon
// 16 Tons by Tenesee Ernie Ford (music), Deltron 3030 (music)
// Broadway Barbara (youtube), Rick Roll lyrics
// Wax-On/Wax-Off - Karate Kid (movie)
// Hands Across the Universe (Sifl and Olly - S01E19)

// =====================================================================
// DESIGN SYSTEM
// =====================================================================
#let body-size = 11pt                // change this to scale everything
#let ratio = (1 + calc.sqrt(5)) / 2  // golden ratio, closed form
#let line-height = body-size / ratio

#let name-size = body-size * calc.pow(ratio, 1.5)
#let label-size = body-size * 1.1   // measured for TeX Gyre Termes small-caps
#let i-unit = body-size / ratio     // horizontal step indent

#let section-leading-margin = line-height               // above each section title
#let title-rule-gap         = body-size / ratio / ratio // section title → hrule
#let rule-bottom-margin     = line-height / 2           // hrule → first row
#let row-leading-margin     = line-height / 2           // above each row
#let entry-line-gap         = line-height               // primary → secondary line

#set text(font: "TeX Gyre Termes", size: body-size)
#set par(leading: line-height, spacing: line-height)
#set list(tight: true, spacing: line-height)

// ===== Top matter =====
#let top-matter(name, ..contacts) = {
    align(center)[
        #text(size: name-size, weight: "bold", name) \
        #v(line-height / ratio)
        #text(size: label-size, contacts.pos().join("  ·  "))
    ]
}

// ===== Section Frame =====
// Tight spacing above hrule, looser below.
#let new-section(title) = {
  v(section-leading-margin)
  block(below: title-rule-gap,
      text(size: label-size, features: ("smcp",), title))
  block(above: 0pt, below: rule-bottom-margin,
      line(length: 100%, stroke: 0.3pt))
}

// ===== Row frame =====
// Generic frame: indents by i-unit, emits trailing gap. All section rows flow through here.
#let row(header, body: none) = {
    v(row-leading-margin)
    pad(left: i-unit, {
        header
        if body != none {
            pad(left: i-unit, body)
        }
    })
}

// ===== Entry =====
// Universal shape: primary, optional secondary, optional summary, optional body.
#let entry(
    primary,
    primary-right,
    secondary: none,
    secondary-right: none,
    summary: none,
    body: none,
) = {
    let header = grid(
        columns: (1fr, auto),
        row-gutter: entry-line-gap,
        align: (left+horizon, right+horizon),
        strong(primary), primary-right,
        ..if secondary != none or secondary-right != none {
            (emph(secondary), emph(secondary-right))
        } else { () }
    )
    row(
        header,
        body: if summary != none or body != none {
            {
                if summary != none { summary }
                if body != none { body }
            }
        } else { none },
    )
}

// ===== Skills block =====
#let skills-block(..rows) = {
    let lines = rows.pos().map(r => [*#r.at(0)*: #r.at(1)])
    row(lines.join([\ ]))
}

// ===== Minor Entry =====
// "Role Org" + dates, no secondary line.
// use "" to blank org if you don't need it
#let minor-entry(role, org, dates, body: none) = {
    row(
        grid(
            columns: (1fr, auto),
            align: (left+horizon, right+horizon),
            [*#role* #org], dates,
        ),
        body: body,
    )
}

// ===== Content helpers =====
#let bullets(..items) = list(..items.pos())

#let pro-summary(text-content) = row(text-content)

// =====================================================================
// HEADER
// =====================================================================
#top-matter(
    "Jackdaws O'Quartz",
    [#link("mailto:jackdaws@sphinxofquartz.com")[jackdaws\@sphinxofquartz.com]],
    [#link("tel:1234567890")[123.456.7890]],   
    [#link("https://github.com/jd-soq")[github.com/jd-soq]]
)

// =====================================================================
// SUMMARY
// =====================================================================
#new-section[Professional Summary]

#pro-summary("This is my text. There are many like it, but this one is mine. Shop smart, shop 'S-Mart'. Hey what's that on your face? She called you callow. What's that mean? It means frightened and weak-willed. I thought that was the only part of the letter that was complimentary. We are the Knights Who Say Ni! It's like a finger pointing at the moon. Don't focus on the finger or you'll miss all that heavenly glory.")

// =====================================================================
// EXPERIENCE
// =====================================================================
#new-section[Experience]

#entry(
    "Ernie Ford Coal Mine Company Store", "2010 - Present",
    secondary: "Manager",
    secondary-right: "Ernie Ford, TN",
    summary: "Responsible for managing 5 other employees, scheduling, meeting sales goals",
    body: bullets(
        [Loaded 16 tons daily], 
        [30,000% ROI YOY through soul sales],
        [One fist of iron, one of steel]
    ),
)

#entry(
    "Deltron Zero Crew", "1999 - 3030",
    secondary: "Staff Hacker",
    secondary-right: "Outer Space, Your Environments",
    summary: "Responsible for gray matter upgrades and other technological feats",
    body: bullets(
        [Consulted on combustible rust clusters], 
        [Repaired gear damaged in ballistic rap battles],
        [Pioneered new techniques to make Deltron the perfect blend of technology and magic]
    ),
)

// =====================================================================
// EDUCATION
// =====================================================================
#new-section[Education]

#entry(
  "Bob Fosse Dance School", "May 2020 - May 2021",
  secondary: "Theater dance instruction, certified in 'Grease Fire' style",
  secondary-right: "Pawtucket, PA",
)

#entry(
  "Richard Roller Surprise Academy", "Apr. 2014 - Aug. 2019",
  secondary: "Training in never giving you up, specalized in never letting you down.",
  secondary-right: "Miami, FL",
)

// =====================================================================
// SKILLS & INTERESTS
// =====================================================================
#new-section[Skills & Interests]

// Pro Tip: keep these lines short enough so they don't wrap
#skills-block(
    ("Languages", "Creole, Jambalaya, French Mongolianese"),
    ("Frameworks", "NodeJS, Timber"),
    ("Procedures", "Wax-On (completed 4/2025), Wax-Off (in progress)"),
)

// =====================================================================
// COMMUNITY SERVICE
// =====================================================================
#new-section[Community Service]

#minor-entry(
    "Bored Member", "@ Non-Profit for Cats", "2024 - Present",
    body: bullets(
        [Biscuit baker],
        [Catnip shaker],
    ),
)

#minor-entry(
    "Volunteer", "@ Hands Across The Universe", "1994 - 1995",
    body: bullets(
        [Organized vendors for yearly planetary alignment events],
        [Logistical support for dwarf planets],
    ),
)
