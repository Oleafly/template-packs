#import "elements.typ": *

#show quote: it => {
  set par(spacing: 0pt)

  block(
    it.body,
    below: 1em,
    above: 1em,
    inset: (right: 1em, left: 1em)
  )
}

#set par(spacing: 0.6em)
#show heading.where(
level: 1
): it => block(width: 100% )[
    #set align(center + horizon)
    #set text(font: "IBM Plex Sans", weight: 500)
    #it.body
  ]

#show heading.where(
  level: 2
): it => block(width: 100%, above: 2em, below: 1em)[
  #set align(center)
    #set par(leading: .5em)
  #set text(font: "IBM Plex Sans", size: 28pt, weight: 600)
  #it.body
]

#show heading.where(
  level: 3
): it => block(width: 100%, above: 2em, below: 1em)[
    #set align(center)
    #set text(font: "IBM Plex Sans", weight: 700, size: 14pt)
    #it.body
  ]

#set footnote.entry(gap: 0.5em, clearance: .25em,)
#show footnote.entry: it => {
  let loc = it.note.location()

  set align(left)
  numbering(
    "1. ",
    ..counter(footnote).at(loc)
  )
  it.note.body
}

#show outline.entry.where(level: 2): it => {
  if it.element.body == [Paul B. Anderson, Nikolai Berdyaev, and Russian Christian
Culture] {
    box(width: 100%)[
      #text(size: 10pt, font: "IBM Plex Sans", stretch: 75%)[Paul B. Anderson, Nikolai Berdyaev, and Russian Christian
Culture] 
      #linebreak()
      #grid(
        columns: (auto, 1fr, auto),
        gutter: 0pt,
        text(size: 10pt, font: "IBM Plex Sans", stretch: 75%, weight: 300)[_by_ Matthew Lee Miller #h(0.5em)],
        box(width: 98%)[#v(-0.7em)#h(1fr) #repeat([.], gap: 0.15em) #h(-1.5em)],
        text(size: 10pt, font: "IBM Plex Sans")[#it.element.location().page()]
      )
    ]
  } else {
    it
  }
}

#show outline.entry.where(level: 2): it => {
  if it.element.body == [Paul B. Anderson, Nikolai Berdyaev, and Russian Christian
Culture] {
    box(width: 100%)[
      #text(size: 10pt, font: "IBM Plex Sans", stretch: 75%)[Paul B. Anderson, Nikolai Berdyaev, and Russian Christian
Culture] 
      #linebreak()
      #grid(
        columns: (auto, 1fr, auto),
        gutter: 0pt,
        text(size: 10pt, font: "IBM Plex Sans", stretch: 75%, weight: 300)[_by_ Matthew Lee Miller #h(0.5em)],
        box(width: 98%)[#v(-0.7em)#h(1fr) #repeat([.], gap: 0.15em) #h(-1.5em)],
        text(size: 10pt, font: "IBM Plex Sans")[#it.element.location().page()]
      )
    ]
  } else {
    it
  }
}

#show outline.entry.where(level: 2): it => {
  if it.element.body == [Friedrich Schleiermacher and Semyon Frank] {
    box(width: 100%)[
      #text(size: 10pt, font: "IBM Plex Sans", stretch: 75%)[Friedrich Schleiermacher and Semyon Frank: On Religion and Dignity] 
      #linebreak()
      #grid(
        columns: (auto, 1fr, auto),
        gutter: 0pt,
        text(size: 10pt, font: "IBM Plex Sans", stretch: 75%, weight: 300)[_by_ Annette G. Aubert #h(0.5em)],
        box(width: 98%)[#v(-0.7em)#h(1fr) #repeat([.], gap: 0.15em) #h(-1.5em)],
        text(size: 10pt, font: "IBM Plex Sans")[#it.element.location().page()]
      )
    ]
  } else {
    it
  }
}

#show outline.entry.where(level: 2): it => {
  if it.element.body == [#emph[Sobornost'] and Christian Order:] {
    box(width: 100%)[
      #text(size: 10pt, font: "IBM Plex Sans", stretch: 75%)[#emph[Sobornost'] and Christian Order: On Dignity, Rights, and Responsibility in Milbank and Frank] 
      #linebreak()
      #grid(
        columns: (auto, 1fr, auto),
        gutter: 0pt,
        text(size: 10pt, font: "IBM Plex Sans", stretch: 75%, weight: 300)[_by_ Nathaniel Wood #h(0.5em)],
        box(width: 98%)[#v(-0.7em)#h(1fr) #repeat([.], gap: 0.15em) #h(-1.5em)],
        text(size: 10pt, font: "IBM Plex Sans")[#it.element.location().page()]
      )
    ]
  } else {
    it
  }
}

#show outline.entry.where(level: 2): it => {
  if it.element.body == [#emph[Sobornost'] and Christian Order:] {
    box(width: 100%)[
      #text(size: 10pt, font: "IBM Plex Sans", stretch: 75%)[#emph[Sobornost'] and Christian Order: On Dignity, Rights, and Responsibility in Milbank and Frank] 
      #linebreak()
      #grid(
        columns: (auto, 1fr, auto),
        gutter: 0pt,
        text(size: 10pt, font: "IBM Plex Sans", stretch: 75%, weight: 300)[_by_ Nathaniel Wood #h(0.5em)],
        box(width: 98%)[#v(-0.7em)#h(1fr) #repeat([.], gap: 0.15em) #h(-1.5em)],
        text(size: 10pt, font: "IBM Plex Sans")[#it.element.location().page()]
      )
    ]
  } else {
    it
  }
}

#show outline.entry.where(level: 2): it => {
  if it.element.body == [Whose Right?:] {
    box(width: 100%)[
      #text(size: 10pt, font: "IBM Plex Sans", stretch: 75%)[Whose Right?: The Law of Nature and the Law of Nations in
Grotian Legal Genealogy] 
      #linebreak()
      #grid(
        columns: (auto, 1fr, auto),
        gutter: 0pt,
        text(size: 10pt, font: "IBM Plex Sans", stretch: 75%, weight: 300)[_by_ Megan Brand #h(0.5em)],
        box(width: 98%)[#v(-0.7em)#h(1fr) #repeat([.], gap: 0.15em) #h(-1.5em)],
        text(size: 10pt, font: "IBM Plex Sans")[#it.element.location().page()]
      )
    ]
  } else {
    it
  }
}

#show outline.entry.where(level: 2): it => {
  if it.element.body == [Human Rights and Orthodox Christianity:] {
    box(width: 100%)[
      #text(size: 10pt, font: "IBM Plex Sans", stretch: 75%)[Human Rights and Orthodox Christianity: Learning from our Differences] 
      #linebreak()
      #grid(
        columns: (auto, 1fr, auto),
        gutter: 0pt,
        text(size: 10pt, font: "IBM Plex Sans", stretch: 75%, weight: 300)[_by_ John Witte Jr. #h(0.5em)],
        box(width: 98%)[#v(-0.7em)#h(1fr) #repeat([.], gap: 0.15em) #h(-1.5em)],
        text(size: 10pt, font: "IBM Plex Sans")[#it.element.location().page()]
      )
    ]
  } else {
    it
  }
}


#show outline.entry.where(level: 2): it => {
  if it.element.body == [Freedom and Rights in the Thought of Ivan Ilyin] {
    box(width: 100%)[
      #text(size: 10pt, font: "IBM Plex Sans", stretch: 75%)[Freedom and Rights in the Thought of Ivan Ilyin] 
      #linebreak()
      #grid(
        columns: (auto, 1fr, auto),
        gutter: 0pt,
        text(size: 10pt, font: "IBM Plex Sans", stretch: 75%, weight: 300)[_by_ Paul Robinson #h(0.5em)],
        box(width: 98%)[#v(-0.7em)#h(1fr) #repeat([.], gap: 0.15em) #h(-1.5em)],
        text(size: 10pt, font: "IBM Plex Sans")[#it.element.location().page()]
      )
    ]
  } else {
    it
  }
}

#show outline.entry.where(level: 2): it => {
  if it.element.body == [Russian Religious Philosophy] {
    box(width: 100%)[
      #text(size: 10pt, font: "IBM Plex Sans", stretch: 75%)[Russian Religious Philosophy] 
      #linebreak()
      #grid(
        columns: (auto, 1fr, auto),
        gutter: 0pt,
        text(size: 10pt, font: "IBM Plex Sans", stretch: 75%, weight: 300)[_by_ Paul Valliere #h(0.5em)],
        box(width: 98%)[#v(-0.7em)#h(1fr) #repeat([.], gap: 0.15em) #h(-1.5em)],
        text(size: 10pt, font: "IBM Plex Sans")[#it.element.location().page()]
      )
    ]
  } else {
    it
  }
}
#show outline.entry.where(level: 2): it => {
  if it.element.body == [Russian Religious Philosophy] {
    box(width: 100%)[
      #text(size: 10pt, font: "IBM Plex Sans", stretch: 75%)[Russian Religious Philosophy] 
      #linebreak()
      #grid(
        columns: (auto, 1fr, auto),
        gutter: 0pt,
        text(size: 10pt, font: "IBM Plex Sans", stretch: 75%, weight: 300)[_by_ Paul Valliere #h(0.5em)],
        box(width: 98%)[#v(-0.7em)#h(1fr) #repeat([.], gap: 0.15em) #h(-1.5em)],
        text(size: 10pt, font: "IBM Plex Sans")[#it.element.location().page()]
      )
    ]
  } else {
    it
  }
}

#show outline.entry.where(level: 2): it => {
  if it.element.body == [Dissenting Views] {
    box(width: 100%)[
      #text(size: 10pt, font: "IBM Plex Sans", stretch: 75%)[Secular Liberals, Soviet Christians, and Socialist Humanism in
the Brezhnev Era] 
      #linebreak()
      #grid(
        columns: (auto, 1fr, auto),
        gutter: 0pt,
        text(size: 10pt, font: "IBM Plex Sans", stretch: 75%, weight: 300)[_by_ Alexander J. McConnell #h(0.5em)],
        box(width: 98%)[#v(-0.7em)#h(1fr) #repeat([.], gap: 0.15em) #h(-1.5em)],
        text(size: 10pt, font: "IBM Plex Sans")[#it.element.location().page()]
      )
    ]
  } else {
    it
  }
}
#show outline.entry.where(level: 2): it => {
  if it.element.body == [Paul B. Anderson, Nikolai Berdyaev, and Russian Christian Culture] {
    box(width: 100%)[
      #text(size: 10pt, font: "IBM Plex Sans", stretch: 75%)[Paul B. Anderson, Nikolai Berdyaev, and Russian Christian Culture] 
      #linebreak()
      #grid(
        columns: (auto, 1fr, auto),
        gutter: 0pt,
        text(size: 10pt, font: "IBM Plex Sans", stretch: 75%, weight: 300)[_by_ Matthew Lee Miller #h(0.5em)],
        box(width: 98%)[#v(-0.7em)#h(1fr) #repeat([.], gap: 0.15em) #h(-1.5em)],
        text(size: 10pt, font: "IBM Plex Sans")[#it.element.location().page()]
      )
    ]
  } else {
    it
  }
}

#show outline.entry.where(level: 2): it => {
  if it.element.body == [The Hidden Russia \ in Western Philosophy] {
    box(width: 100%)[
      #text(size: 10pt, font: "IBM Plex Sans", stretch: 75%)[The Hidden Russia in Western Philosophy: An Outline for Future Research] 
      #linebreak()
      #grid(
        columns: (auto, 1fr, auto),
        gutter: 0pt,
        text(size: 10pt, font: "IBM Plex Sans", stretch: 75%, weight: 300)[_by_ Ana Siljak #h(0.5em)],
        box(width: 98%)[#v(-0.7em)#h(1fr) #repeat([.], gap: 0.15em) #h(-1.5em)],
        text(size: 10pt, font: "IBM Plex Sans")[#it.element.location().page()]
      )
    ]
  } else {
    it
  }
}

#show outline.entry.where(level: 2): it => {
  if it.element.body == [#emph[Sobornost'] and Christian Order] {
    box(width: 100%)[
      #text(size: 10pt, font: "IBM Plex Sans", stretch: 75%)[#emph[Sobornost'] and Christian Order: On Dignity, Rights, and Responsibility in Milbank and Frank] 
      #linebreak()
      #grid(
        columns: (auto, 1fr, auto),
        gutter: 0pt,
        text(size: 10pt, font: "IBM Plex Sans", stretch: 75%, weight: 300)[_by_ Nathaniel Wood #h(0.5em)],
        box(width: 98%)[#v(-0.7em)#h(1fr) #repeat([.], gap: 0.15em) #h(-1.5em)],
        text(size: 10pt, font: "IBM Plex Sans")[#it.element.location().page()]
      )
    ]
  } else {
    it
  }
}

#show outline.entry.where(level: 2): it => {
  if it.element.body == [Ecologies of Care] {
    box(width: 100%)[
      #text(size: 10pt, font: "IBM Plex Sans", stretch: 75%)[Ecologies of Care: \Gregory of Nyssa & Sergii Bulgakov on Human Dignity and Responsibility] 
      #linebreak()
      #grid(
        columns: (auto, 1fr, auto),
        gutter: 0pt,
        text(size: 10pt, font: "IBM Plex Sans", stretch: 75%, weight: 300)[_by_ Daniel Adam Lightsey #h(0.5em)],
        box(width: 98%)[#v(-0.7em)#h(1fr) #repeat([.], gap: 0.15em) #h(-1.5em)],
        text(size: 10pt, font: "IBM Plex Sans")[#it.element.location().page()]
      )
    ]
  } else {
    it
  }
}

#let subtitle(body) = {
  set align(center)
  set text(font: "IBM Plex Sans")
  [#body]
}

#set page(
  paper: "a4",
  margin: (top: 2cm, bottom: 3cm, left: 2cm, right: 2cm),
)

#set footnote.entry(
  separator: line(length: 100%, stroke: 0.5pt),

)

#set text(font: "Libertinus Serif", hyphenate: true, costs: (widow: 10000%, orphan: 10000%, hyphenation: 10%), size: 12pt, spacing: 50% + 100%)
#set par(justify: true, first-line-indent: 1.5em)

// Import and display copyright page
#let copyright-content = include("./copyright-page.typ")
#copyright-content

#show outline.entry.where(level: 1): it => {
  v(12pt, weak: true)
  box(width: 100%)[
    #text(font: "IBM Plex Sans", size: 14pt, stretch: 75%, weight:300)[#it.element.body]
  ]
  v(4pt, weak: true)
}

#pagebreak()

#outline(depth: 2, indent: 0em, title: text(stretch: 75%, size: 20pt)[#upper()[Table of Contents#v(1em)]])

#pagebreak()
#let siljak = include("./siljak.typ")
#siljak

#pagebreak()
#let clay = include("./clay.typ")
#clay

#pagebreak()
#let lightsey = include("./lightsey.typ")
#lightsey


#pagebreak()
#let robinson = include("./robinson.typ")
#robinson

#pagebreak()
#let aubert = include("./aubert.typ")
#aubert

#pagebreak()
#let wood = include("./wood.typ")
#wood

#pagebreak()
#let miller = include("./miller.typ")
#miller

#pagebreak()
#let dissenting-views = include("./mcconnell.typ")
#dissenting-views

#pagebreak()
#let brand = include("./brand.typ")
#brand

#pagebreak()
#let witte = include("./witte.typ")
#witte

#pagebreak()
#let valliere = include("./valliere.typ")
#valliere
