#let FONT   = "New Computer Modern" 
#let SIZE   = 12pt        
#let INDENT = 1.4em

#let chapter = [Chapter]
#let def = [Definition]
#let thm = [Theorem]
#let lem = [Lemma]
#let exp = [Example]
#let exr = [Exercise]
#let sol = [Solution]
#let prf = [Proof]
#let rmk = [Remark]

#let adversa(
  title: none, 
  author: none,
  subtitle: none,
  contents-title: none,
  show-date: false,
  body
) = {
  set text(font: FONT, size: SIZE, fill: rgb("#1A1A1A"))
  set par(first-line-indent: INDENT, justify: true)
  set terms(hanging-indent: INDENT)
  set enum(numbering: "1)")
  set list(indent: 1em, marker: [#text(size: 1.1em, [*#sym.dot*])])
  set document(author: if author != none { author } else { () }, title: title)
  set heading(numbering: "1.", supplement: none)
  set page(fill: rgb("#FDFBF7"), margin: (left: 12%, right: 12%))  

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    set text(weight: "regular", hyphenate: false)
    set par(first-line-indent: 0em)
    block(
      inset: (left: -0.2em, bottom: -3em),
      {
        set text(size: 2em, spacing: 0.5em)
        (emph(it.body))
      } 
      + if it.outlined {
        emph[
          #v(0.9em, weak: true)
          #smallcaps[#chapter] #counter(heading).display()
        ]
      }
    )
    v(6em, weak: true)
  }
  show heading.where(level: 2): it => {
    v(2em)
    block(
      sticky: true,
      (
        emph(text(size: 0.8em, counter(heading).display()))
        + h(0.5em)
        + emph(text(size: 1.05em, it.body))
        + box(
            width: 1fr, 
            align(
              right, line(
                length: 100% - 0.8em, start: (0%, -0.225em), 
                stroke: (
                  paint: black,
                  cap: "round",
                )
              )
            )
          )
      )
    )
    v(2em, weak: true)
  }
  show heading.where(level: 3): it => {
    block(
      sticky: true,
      (
        if it.supplement != auto { smallcaps(text(size: 1.15em, it.supplement + " ")) }
        + text(size: 1.05em, counter(heading).display())
        + h(0.5em)
        + emph(text(weight: "thin", it.body))
      )
    )
    v(1.5em, weak: true)
  }
  show outline.entry.where(level: 3): it => {
    let supplement = it.element.supplement
    if supplement != auto {
      let prefix = [#it.prefix() #supplement]
      link(it.element.location())[
        #text(
          size: 0.85em, 
          it.indented(
            none, 
            prefix + h(0.3em) + 
            it.inner())
          )
      ]
    } 
    else { it }
  }
  show enum: it => {
    pad(x: 0.75em)[
      #it
    ]
  }
  show list: it => {
    pad(x: -1em)[
      #it
    ]
  }

  // Title page styling
  page[ 
    #place(horizon + center, dy: -15%)[
      #set par(spacing: 0.7em, leading: 0.2em, justify: false)
      #align(center)[
        #if title != none [
          #text(size: 4em, smallcaps(title), weight: "regular", hyphenate: false)
          #v(2.5%, weak: true)
        ]
        #if subtitle != none [
          #text(size: 2em, smallcaps(subtitle))
          #v(2.5%, weak: true)
        ]
      ]
    ]
    
    #if author != none [
      #align(bottom + center, text(size: 1.5em, smallcaps(author)))
    ]

    #if show-date == true [
      #align(bottom+center, text(size: 1.2em)[
        #smallcaps(datetime.today().display("[day] [month repr:long] [year]"))
      ])
    ]
  ]
  
  // Contents
  {
    show heading.where(level: 1): it => {
      block(
        above: 2em,
        below: 1em,
        text(size: 1.5em, spacing: 0.5em, smallcaps(it.body))
      )
    }
    outline(title: contents-title)
  }

  pagebreak()
  
  // Footer & page size
  set page(
    height: auto,
    footer: context [
      #place(horizon + center)[#smallcaps(title)]
      #place(horizon + right)[#smallcaps(counter(page).display("1/1", both: true))]
    ]
  )
  body
}

// Wrap code in around
#let code = (source) => {
  pad(
    x: 0.5em,
    block(
      fill: rgb("#FDFBF7"),
      radius: 4pt,
      above: 2em,
      below: 2em
    )[
      #source
    ]
  )
}

// Tablef taken from mousse-notes, will tweak it to my liking soon
#let tablef(..args) = {
  set table.hline(stroke: 0.5pt)
  table(
    align: left,
    stroke: (x, y) => {
      if (y == 0) {
        (
          top: 1pt,
          bottom: 0.5pt,
        )
      }
    },
    ..args.named(),
    ..(args.pos() + (table.hline(stroke: 1pt),)),
  )
}
  
// Prologue function for topic introductions
#let prologue(body) = {
  pad(
    x: 2em,
    top: 0.5em,
    bottom: 1.5em,
    block(
      width: 100%,
      stroke: (left: 2pt + rgb("#b3b3b3")),
      inset: (left: 1.2em, top: 0.2em, bottom: 0.2em),
      text(size: 1.05em, style: "italic", fill: rgb("#4d4d4d"), body)
    )
  )
}

// Citation function
#let cit(source) = {
  align(right)[
    #v(-0.5em)
    #text(size: 0.85em, fill: rgb("#666666"))[
      #sym.dash.em #smallcaps[Source:] #source
    ]
  ]
}

// Styled Hyperlink function
#let hyperlink(url, display-text) = {
  link(url)[
    #text(fill: rgb("#3b6e8f"))[
      #underline(stroke: 0.5pt, offset: 2pt)[#display-text]
    ]
  ]
}

// Theorem environment inspired by mousse-notes but remade so it shows up
// in the contents table as well added few extra visual tweaks.
// Theorem environment inspired by mousse-notes but remade so it shows up
// in the contents table as well added few extra visual tweaks.
#let env(name, color) = {
  return (..args) => {
    let pos = args.pos()
    let title = none
    let body = none

    if pos.len() == 2 {
      title = pos.at(0)
      body = pos.at(1)
    } 
    else if pos.len() == 1 {
      body = pos.at(0)
    }
    
    align(center)[
      #block(
        width: 102%,
        fill: color,
        radius: 10pt,
        inset: (x: 2.5em, y: 2.5em),
        stroke: rgb(color.to-hex().slice(0, 7)).darken(40%),
        align(left)[ 
          #if title != none [
             #heading(level: 3, supplement: name)[#text(size: 1.1em, title)]
             #line(length: 100%, stroke: 0.3pt)
          ]
          #body
        ]
      )
      #v(1em)
    ]
  }
}

#let definition = env("Definition", rgb("#6a9ace1d"))
#let theorem = env("Theorem", rgb("#6aceb71d"))
#let lemma = env("Lemma", rgb("#c46ace1d"))
#let example = env("Example", rgb("#d1a6aa1d"))
#let exercise = env("Exercise", rgb("#ce946a1d"))
#let solution = env("Solution", rgb("#8dce6a1d"))
#let proof = env("Proof", rgb("#6a9fce1d"))
#let remark = env("Remark", rgb("#6ac2ce1d"))
