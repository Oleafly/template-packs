//  Modern Single-Column CV (2025–2026 style)
//  Pure Typst — no packages

#set page(
  paper: "a4",
  margin: (x: 1.6cm, y: 1.8cm),
  numbering: none
)

#set text(
  font: ("New Computer Modern"),
  size: 10.8pt,
  lang: "en",
  region: "us"
)

#set par(justify: true, leading: 0.52em)
#set block(above: 0.92em, below: 0.68em)

// ── Colors ───────────────────────────────────────
//#let accent   = rgb("#0066cc")   // blueish
#let accent = rgb("#b27a0c")
#let dark     = rgb("#1a1a1a")
#let gray     = rgb("#5a5a5a")
#let lightgray = rgb("#f6f6f6")


#let section(title) = {
  block(above: 1.2em, below: 0.5em)[
    #text(size: 14pt, weight: 700, fill: accent, tracking: 0.4pt)[#upper(title)]
    #v(-0.15em)
    #line(length: 100%, stroke: (paint: accent, thickness: 1.4pt))
  ]
}

#let dated-entry(
  what   : none,
  where  : none,
  when   : none,
  desc   : none
) = {
  grid(
    columns: (auto, 1fr, auto),
    gutter: 1.2em,
    align: (left + horizon, left, right + horizon),

    text(weight: 600, fill: dark)[#what],
    text(fill: gray)[#where],
    text(size: 9.8pt, fill: gray, weight: 400)[#when]
  )

  if desc != none {
    v(0.28em)
    set text(size: 10.2pt)
    pad(left: 0.1em)[#desc]
  }

  v(0.72em)
}

#let skill-category(name, items) = {
  text(weight: 600, fill: dark)[#name]
  //text(fill: gray)[#h(0.6em) • #items.join("  •  ")]
  text(fill: gray)[: #h(0.6em) #items.join("  •  ")]
  linebreak()
}

// ============================================================================
//  DOCUMENT START
// ============================================================================

#let photo = image("headshot.jpg", width: 3.4cm, height: 4.6cm)
#grid(
  columns: (auto, 1fr),
  gutter: 1.2cm,
  align(left + top)[
    #box(
      width: 3.4cm,
      height: 4.6cm,
      radius: 0.35cm,
      clip: true,
      photo
    )
  ],
  [
    #v(0.3cm)  // small vertical offset to align better with photo

    #text(38pt, weight: "semibold")[Name0 Name1] \
    #v(0.2cm)  
	#let spacing_top = 0.6mm
    #link("tel:+123456789")[+123456789]  \
    #v(spacing_top)  
	#link("mailto:your@mail.com")[your\@mail.com] \ 
    #v(spacing_top)  
	#link("https://www.linkedin.com/in/placeholder")[linkedin.com/in/placeholder]
    #v(spacing_top)  
	Waterloo, Italy \


  ]
)

// Try below without photo
/*
#align(center)[
  #text(
    size: 34pt,
    weight: 700,
    fill: dark,
    tracking: -0.5pt
  )[Name Name] \
  #v(0.18em)
  +12345678  •  London, Poland  •  #link("mailto:mail@mail.com")[mail\@mail.com]  •  #link("https://www.linkedin.com/in/")[linkedin.com/in//]
]
*/


#v(0.3cm)



// ──────────────────────────────────────────────────────

#section[Experience]

#dated-entry(
  what:  "Crane Engineer",
  where: "Cranecorp, Florida",
  when:  "Jan 2001 – Present",
  desc: [
  	- Cranes
	- More cranes
	- No animals (cranes) were harmed
  ]
)


#dated-entry(
  what:  "Trucks",
  where: "Highway, USA",
  when:  "Jan 2012 – Mar 2014",
  desc: [
    - Driving on highway
	- Sitting in a truck
  ]
)

// ──────────────────────────────────────────────────────

#section[Education]

#dated-entry(
  what:  "M.Sc. Particle Physics",
  where: "MIT",
  when:  "2002 – present",
  desc:  "Graduation project: finding higgs boson"
  //desc:  none
)

#dated-entry(
  what:  "B.Sc. Cranes",
  where: "Crane university",
  when:  "2020 – 2024",
  desc:  none
)

// ──────────────────────────────────────────────────────

#section[Competences]

#dated-entry(
  what:  "Building cranes",
  where: none,
  when:  none,
  desc:  [
- Big cranes
- Small cranes too
]
)

#dated-entry(
  what:  "Writing emails",
  where: none,
  when:  none,
  desc:  [
- This is a placeholder
- Try writing your own placeholders
]
)


// ──────────────────────────────────────────────────────

#section[Skills]

#skill-category("Languages", ("English (native)", "English (native)", "Swahili (advanced)", "French (baguette)" ))
#skill-category("Programming", ("C--", "ADA", "Language3"))
#skill-category("Interests", ("Watching cranes", "Driving", "Being employed" ))

#v(0.8em)

#set text(size: 9.4pt, fill: gray)
#align(center)[
  #let build_date = datetime.today().display("[year]-[month]-[day]")
  Build date: #build_date
]


// Optional SHA256
/*
#import "@preview/digestify:0.1.0": sha256, bytes-to-hex
#set text(size: 9.4pt, fill: gray)
#align(center)[
  #let source = read("cv.typ")
  #let hash_bytes = sha256(bytes(source))
  #let hash_str = bytes-to-hex(hash_bytes)
  #let build_date = datetime.today().display("[year]-[month]-[day]")
  SHA256: #hash_str  •  Build date: #build_date
]
*/
