#import "drafting.typ": *

// == LAYOUT ==
#let margin-right = 8cm

// == BRAND ==

#let sans-fonts = (
  "IBM Plex Sans",
)

#let heading-fonts = (
  "PP Formula",
)

// Colors
#let mlb-turquoise = rgb("#007083")
#let mlb-marin = rgb("#04313E")
#let mlb-calming-blue = rgb("#90B4C2")
#let mlb-yellow = rgb("#FAFD6F")

#let wideblock(content) = block(width:100%+2.5in,content)
#let styledbox(color: mlb-turquoise.lighten(90%), content) = block(
  below: 3em,
  above: 3em,
  box(
    width: 100%,
    fill: color,
    radius: 8pt,
    inset: (x: 16pt, y: 14pt),
    content
  )
)

// == Outcome / Showcase blocks ==

#let outcome(
  number: none,
  suffix: none,
  color: mlb-turquoise.lighten(90%),
  accent: mlb-turquoise,
  height: auto,
  content
) = box(
  width: 100%,
  height: height,
  fill: color,
  radius: 8pt,
  inset: (x: 16pt, y: 16pt),
  {
    set text(font: sans-fonts)
    set par(first-line-indent: 0em, justify: false, leading: 0.55em)
    if number != none {
      text(font: heading-fonts, size: 2.6em, weight: "regular", fill: accent, features: ("ss02", "ss03"), number)
      if suffix != none {
        text(font: heading-fonts, size: 1.6em, fill: accent, suffix)
      }
      v(0.5em, weak: false)
      text(size: 0.8em, fill: mlb-marin, content)
    } else {
      box(width: 1.4em, height: 0.25em, fill: accent, radius: 999pt)
      v(2.2em, weak: false)
      text(size: 0.8em, weight: "regular", fill: mlb-marin, content)
    }
  }
)

// Items are passed as closures `h => outcome(..., height: h)[...]` so the
// grid can render each one twice: once at auto-height to measure it at
// the real column width, then again pinned to the tallest measured height.
#let outcomes-grid(columns: 2, gutter: 6pt, ..items) = wideblock(
  layout(size => context {
    let col-width = (size.width - gutter * (columns - 1)) / columns
    let heights = items.pos().map(item => measure(box(width: col-width, item(auto))).height)
    let max-height = calc.max(..heights)
    block(
      breakable: false,
      grid(
        columns: (1fr,) * columns,
        column-gutter: gutter,
        row-gutter: gutter,
        align: (top, top),
        ..items.pos().map(item => item(max-height))
      )
    )
  })
)

// == TEMPLATE ==
#let template(
  language: none,
  title: [Report Title],
  shorttitle: none,
  subtitle: none,
  cover: none,
  category: none, // e.g. "Media Trends" — shown as the kicker line, like the blog's topic eyebrow
  authors: (
    (
      name: "First Last",
      role: none,
      organization: none,
      location: none,
      email: none
    ),
  ),
  contact-img: none, // path to an author image; if omitted, a placeholder frame is drawn (like the blog's author image space)
  tags: none, // e.g. ("Journalismus", "New Work", "Strategie") — shown as small outlined pills, like the blog's topic tags
  date: datetime.today(),
  document-number: none,
  draft: none,
  distribution: none,
  abstract: none,
  publisher: none,
  contact: false,
  toc: none,
  author-bio: none, // dict: (name: "...", bio: "...", image: none) — closing "Artikel geschrieben von" note; image is optional, a rounded placeholder is drawn if omitted
  impressum: true,
  bib: none,
  doc
) = {
  // Document metadata
  let first_author = if type(authors) == array {
    authors.first()
  } else {
    authors
  }

  set document(
    title: title,
    author: if type(first_author) == dictionary {
      first_author.name
    } else {
      first_author
    },
  )

  // Headings
  
  show heading: set text(hyphenate: false)

  // H1
  show heading.where(level: 1): it => {
    set text(size: 2.4em, weight: "regular", fill: mlb-marin, font: heading-fonts, features: ("ss02", "ss03"))
    set par(leading: 0.3em)
    block(above: 1.5em, below: 1em, it.body)
  }

  // H2
  show heading.where(level: 2): it => {
    set text(size: 1.3em, weight: "bold", fill: mlb-marin)
    v(1em, weak: false)
    block(
      above: 1em,
      below: 1em,
      it.body,
    )
  }

  // H3 — Subsections ("So sind die Plattformen miteinander verbunden")
  show heading.where(level: 3): it => {
    set text(size: 1.1em, weight: "bold", fill: black)
    block(above: 1.5em, below: 1em, it.body)
  }

  // H4 — Step/list-style sub-headers ("Die richtige Plattform wählen")
  show heading.where(level: 4): it => {
    set text(size: 1em, weight: "bold", fill: mlb-turquoise)
    block(above: 1em, below: 0.4em, it.body)
  }

  // Tables and figures
  set figure(numbering: none)
  show figure: set align(left)
  show figure.where(kind: image): set figure(numbering: none)
  show figure.where(kind: image): set figure(
    numbering: none,
    supplement: none
  )
  show figure: set figure.caption(separator: [.#h(0.5em)])
  show figure: set block(spacing: 1.5em)
  show figure.caption: set align(left)
  show figure.caption: set text(font: sans-fonts, size: 0.75em, fill: mlb-turquoise)

  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): set figure(numbering: "I")
  show figure.where(kind: table): it => wideblock(it)
  show table: it => wideblock(it)

  show figure.where(kind: image): set figure(supplement: [Figure], numbering: none)

  show figure.where(kind: raw): set figure.caption(position: top)
  show figure.where(kind: raw): set figure(supplement: [Code], numbering: "1")
  show raw: set text(font: sans-fonts, size: 10pt)

  // Image Styling
  show image: it => {
  let src = it.source

  // Try to safely detect file extension
  let is-svg = if type(src) == str {
    src.ends-with(".svg")
  } else if type(src) == path {
    str(src).ends-with(".svg")
  } else {
    false
  }

  if is-svg {
    it
  } else {
    box(
      radius: 4pt,
      clip: true,
      it
    )
  }
}

  // Table styling: horizontal rules only, brand-neutral gray
  set table(
    stroke: (x, y) => (
      top: if y == 0 { 0pt + gray } else { none },
      bottom: 0.5pt + gray,
    ),
    inset: (x: 8pt, y: 6pt),
    align: left + top
  )

  // Table typography styling
  show table.cell.where(y: 0): set text(weight: "bold", size: 0.8em)
  show table.cell.where(y: 0): upper
  show table.cell: set par(justify: false)
  show table.cell: set text(font: sans-fonts, size: 0.75em)

  // Equations
  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 0.65em)

  show link: underline

  // Lists
  set enum(
    indent: 1em,
    body-indent: 1em,
  )
  show enum: set par(justify: false)
  set list(
    indent: 1em,
    body-indent: 1em,
  )
  show list: set par(justify: false)

  // Page setup
  set page(
    paper: "a4",
    columns: 1,
    margin: (
      left: 2cm,
      right: margin-right,
      top: 3cm,
      bottom: 2.5cm,
    ),
    header: context {
      if counter(page).get().first() > 1 {
        box(
        width: 100% + margin-right - 2cm,
        grid(
          columns: (1fr, auto),
          align: (left + top, right + top),
          [
            #text(
              fill: mlb-turquoise,
              font: sans-fonts,
              size: 8pt,
              tracking: 0.02em,
            )[
              #if document-number != none { 
                box(
                  stroke: 0.6pt + mlb-turquoise,
                  inset: (x: 9pt, y: 4pt),
                  radius: 999pt,
                  text(size: 0.75em, upper(document-number)),
                ) 
              }
              #h(1em)
              #if shorttitle != none { upper(shorttitle) } else { upper(title) }
              #if publisher != none {
                linebreak()
                upper(publisher)
              }
            ]
          ],
          image(
            "../../../assets/logos/MLB-1-line.svg",
            width: 4cm,
            fit: "contain",
          )
        ),
        )
      } else {
        image(
            "../../../assets/logos/MLB-1-line-white.svg",
            width: 6cm,
            fit: "contain",
          )
      }
    },
    footer: context {
      let pagenum = counter(page).get().first()
      box(
        width: 100% + margin-right - 2cm,
        {
          set text(fill: mlb-turquoise, font: sans-fonts, size: 8pt)
          if pagenum == 1 {
            if draft [
              Draft document, #date.display().
              #linebreak()
            ]
            if distribution != none [
              #strong(distribution)
            ]
          } else {
            grid(
              columns: (1fr, auto),
              align: (left + horizon, right + horizon),
              {
                if draft [
                  Draft document, #date.display().
                  #linebreak()
                ]
                if distribution != none [
                  #strong(distribution)
                ]
              },
              box(
                radius: 999pt,
                inset: (x: 6pt, y: 3pt),
                stroke: (paint: mlb-turquoise, thickness: 0.6pt),
                text(fill: mlb-turquoise, weight: "bold", size: 7.5pt, [#pagenum])
              )
            )
          }
        }
      )
    },
    background: context {
      let pagenum = counter(page).get().first()
      if draft {
        rotate(45deg, text(font: sans-fonts, size: 200pt, fill: rgb("FFEEEE"))[DRAFT])
      }
})

  // Set default text and paragraph styles for the body of the report
  set text(
    font: sans-fonts,
    style: "normal",
    weight: "regular",
    hyphenate: true,
    size: 11pt,
    lang: language,
  )
  set par(
    justify: false,
    leading: 0.65em,
    first-line-indent: 1em
  )
  show par: set par(
    spacing: 0.65em
  )

  // === Title Pages ===

  let titlepage(title, subtitle, category, date, document-number, tags, cover, authors) = {
    set text(fill: white)
    set page(fill:mlb-turquoise)
    wideblock({
    box(width: 100%, height: 100%, fill: mlb-turquoise, radius: 18pt, {
      pad(x: 0pt, y: 20pt, {
        set par(spacing: 0pt)
        set block(spacing: 0pt)
        if cover != none {
          box(width: 100%, height: 14cm, radius: 8pt, clip: true,
            image(cover, width: 100%, height: 14cm, fit: "cover"))
          v(3em, weak: true)
        }
        if category != none {
          set par(first-line-indent: 0pt, spacing: 0em)
          text(font: sans-fonts, size: 9pt, fill: white, tracking: 0.08em, upper(category))
          v(3em, weak: true)
        }
        set text(hyphenate: false, size: 6em, font: heading-fonts, weight: "regular", fill: white, features: ("ss02", "ss03"))
        set par(leading: 0.15em, first-line-indent: 0pt)
        title
        linebreak()
        v(0.5em, weak: true)
        if subtitle != none {
          set par(leading: 0.8em, first-line-indent: 0pt)
          set text(size: 0.15em, font: sans-fonts, fill: mlb-calming-blue)
          subtitle
        }
      })
    })
    })
  }

  // === Frontmatter ===

  let titleblock(title: none, subtitle: none) = wideblock({
      set text(
        hyphenate: false,
        size: 40pt,
        font: heading-fonts,
        weight: "regular"
      )
      set par(
        justify: false,
        leading: 0.2em,
        first-line-indent: 0pt
      )
      title
      if subtitle != none {
        set text(size: 11pt, weight: "regular", font: sans-fonts)
        v(-0.5em)
        subtitle
      }
    })

  let tagsblock(tags) = wideblock({
    if tags.len() > 0 {
      v(0.8em)
      set text(font: sans-fonts, size: 8pt, fill: mlb-turquoise, tracking: 0.03em)
      for (i, tag) in tags.enumerate() {
        box(
          stroke: 0.6pt + mlb-turquoise,
          inset: (x: 9pt, y: 4pt),
          radius: 999pt,
          upper(tag)
        )
        if i < tags.len() - 1 {h(4pt)}
      }
    }
  })

  // Cover image — a wide, rounded rectangle at the top of the report
  let coverimageblock(cover) = wideblock({
    v(0.5em)
    let frame-height = 2.2in
    if cover != none {
      box(
        width: 100%,
        height: frame-height,
        radius: 8pt,
        clip: true,
        image(cover, width: 100%, height: frame-height, fit: "cover")
      )
    } else {
    }
  })
  // Info block
  let infoblock(category, date, document-number) = wideblock({
    if category != none or date != none {
          h(16pt)
          text(
            font: sans-fonts,
            size: 0.6em,
            fill: mlb-turquoise,
            tracking: 0.05em,
            {
              if category != none {upper(category)}
              if category != none and date != none {[ #sym.dot.c ]}
              if date != none {date.display("[day].[month].[year]")}
              if document-number != none {
                [ #sym.dot.c ]
                upper(document-number)
              }
            }
          )
        }
      })

  // Author blocks
  let authorblock(authors, columns) = wideblock({
    set text(font: sans-fonts, size: 0.8em)
    v(0em)
    box(
      fill: mlb-turquoise.lighten(90%),
      radius: 8pt,
      inset: (x: 16pt, y: 14pt),
      {
        if authors.len() == 1 {
          text(size: 0.8em, weight: "bold", fill: mlb-turquoise, tracking: 0.05em, upper[Author])
        } else {
          text(size: 0.8em, weight: "bold", fill: mlb-turquoise, tracking: 0.05em, upper[Authoren])
        }
        v(0.8em)
        for i in range(calc.ceil(authors.len() / columns)) {
          let end = calc.min((i + 1) * columns, authors.len())
          let is-last = authors.len() == end
          let slice = authors.slice(i * columns, end)
          grid(
            columns: slice.len() * (1fr,),
            gutter: 1em,
            align: (top, top),
            ..slice.map(author => align(left, {
              strong(author.name)
              if "role" in author [
                \ #author.role
              ]
              if "organization" in author [
                \ #author.organization
              ]
              if "email" in author [
                \ #author.email
              ]
              v(0.5em, weak: false)
            }))
          )
          if not is-last {
            v(16pt, weak: true)
          }
        }
      }
    )
  })

  // Closing contact field — always appended at the very end of the
  // report (after references, if any), showing each author's name
  // and how to reach them.
  
  let contactblock(authors) = wideblock({
  let authors-list = if type(authors) == array {authors} else {(authors,)}
  let author = authors-list.first()
  v(2em, weak: true)
  set par(first-line-indent: 0em)
  box(
    width: 75%,
    fill: mlb-yellow,
    radius: 8pt,
    inset: (x: 8pt, y: 8pt),
    {
      grid(
        columns: (100pt, 1fr),
        gutter: 2em,
        box(
          width: 100pt,
          height: 100pt,
          clip: true,
          radius: 4pt,
          image(contact-img, width: 100pt, height: 100pt, fit: "cover")
        ),
        {
          v(0.3em,weak: false)
          text(font: sans-fonts, size: 8pt, fill: mlb-marin, tracking: 0.05em, strong(upper[Kontakt]))
          v(0.6em, weak: false)
          text(font: sans-fonts, size: 1.2em, weight: "bold", author.name)
          if "role" in author and author.at("role") != none [
            #linebreak()
            #v(0.4em)
            #text(font: sans-fonts, size: 1em, author.role)
          ]
          if "email" in author and author.at("email") != none [
            #linebreak()
            #v(0.4em)
            #text(font: sans-fonts, size: 1em, author.email)
          ]
        },
      )
    }
  )
})

  let abstractblock(abstract) = styledbox(color: mlb-turquoise.lighten(90%), {
    set text(font: sans-fonts)
    set par(first-line-indent: 0em)
    text(size: 0.64em, weight: "bold", fill: mlb-turquoise, tracking: 0.05em, upper[Zusammenfassung])
    v(0.8em)
    abstract
  })

  // TOC
  let tocblock() = wideblock(context {
    set text(font: sans-fonts, size: 0.8em)
    
    show link: it => it.body

    text(size: 0.8em, weight: "bold", fill: mlb-turquoise, tracking: 0.05em, upper[Inhaltsverzeichnis])
    v(0.8em)

    let sections = query(heading)
    for (i, it) in sections.enumerate() {
      let pagenum = counter(page).at(it.location()).first()

      pad(left: (it.level - 1) * 1em)[
        #link(it.location(), grid(
          columns: (auto, 1fr, auto),
          column-gutter: 0.4em,
          align: (left + horizon, horizon, right + horizon),
          it.body,
          box(width: 1fr, repeat(text(fill: luma(180), size: 8pt)[.])),
          text(fill: mlb-turquoise, str(pagenum))
        ))
      ]
    }
    v(3em, weak: true)
  })
  titlepage(title, subtitle, category, date, document-number, tags, cover, authors)

  //titleblock(title: title, subtitle: subtitle)
  //tagsblock(tags)
  //coverimageblock(cover)
  //v(1.5em, weak: true)
  if abstract != none {
    grid(
      columns: (0.5fr, 0.1fr),
      gutter: 1em,
      align: (top, top),
      {
        abstractblock(abstract)
      },
      {
        box(width: 100%, {
          authorblock(authors, 1)
          infoblock(category, date, document-number)
        })
      }
    )
  } else {
    authorblock(authors, 2)
    infoblock(category, date, document-number)
  }
  if toc {
    v(3em, weak: false)
    tocblock()
  }
  pagebreak()

  doc

  // ------------------------------------------------------------
  // Author bio — closing note mirroring the blog's "Artikel
  // geschrieben von" section, including a space for the author's
  // portrait (rounded, like the site's circular avatar). If no
  // image is supplied, a rounded placeholder is drawn instead.
  // ------------------------------------------------------------
  if author-bio != none {
    wideblock({
      v(2em, weak: true)
      line(length: 100%, stroke: 0.4pt + mlb-turquoise)
      v(1em)
      let avatar-size = 0.85in
      let avatar-image = author-bio.at("image", default: none)
      grid(
        columns: (avatar-size, 1fr),
        gutter: 12pt,
        align: (top, top),
        if avatar-image != none {
          box(
            width: avatar-size, height: avatar-size,
            radius: 999pt, clip: true,
            image(avatar-image, width: avatar-size, height: avatar-size, fit: "cover")
          )
        } else {
          box(
            width: avatar-size, height: avatar-size,
            radius: 999pt,
            stroke: (paint: mlb-turquoise, thickness: 0.6pt, dash: "dashed"),
            fill: luma(250),
            align(center + horizon, text(
              font: sans-fonts, size: 7pt, style: "italic", fill: luma(150),
              [Foto]
            ))
          )
        },
        {
          text(font: sans-fonts, size: 8pt, fill: mlb-turquoise, tracking: 0.05em, upper[Artikel geschrieben von])
          v(0.5em)
          text(font: sans-fonts, size: 11pt, weight: "bold", author-bio.name)
          v(0.4em)
          text(font: sans-fonts, size: 10pt, emph(author-bio.bio))
        }
      )
    })
  }

  show bibliography: set text(font: sans-fonts)
  show bibliography: set par(justify: false)
  set bibliography(title: none)
  if bib != none {
    heading(level: 1, [References])
    bib
  }
  if contact {
  v(4em, weak: true)
  contactblock(authors)
  }
  if impressum {
    pagebreak()
    v(1fr)
    wideblock(
    styledbox(color: mlb-turquoise.lighten(95%),
    {
      box(width:60%, {
        set text(fill: mlb-marin.lighten(25%), size: 0.8em)
      set par(first-line-indent: 0em)
      heading(level: 4)[Impressum]
      linebreak()
      [*Medien.Bayern GmbH* \
      Balanstr. 73 / Haus 11 \
      81541 München \
      hi\@media-lab.de
      \
      \
      © MEDIA LAB BAYERN #date.display("[year]")]
      linebreak()
      linebreak()
      [V.I.S.D.P.: Annette Kümmel.]
      linebreak()
      linebreak()
      [Das Media Lab Bayern eine ist Initiavite der Medien.Bayern GmbH und wird gefördert durch die Bayerische Landeszentrale für neue Medien und die Bayerische Staatskanzlei.]
      })
    })
  )
  }
}

/* Sidenotes
Display content in the right margin with the `note()` function.
Takes 2 optional keyword and 1 required argument:
  - `dy: length | auto` Adjust the vertical position (default `auto`, which lets
    `drafting`'s built-in collision avoidance stack consecutive notes instead of
    overlapping them). Pass an explicit length only when you want to hand-tune a
    single note's position.
  - `numbered: bool` Display a footnote-style number in text and in the note (default `true`).
  - `content: content` The content of the note.
*/
#let notecounter = counter("notecounter")

#let sidenote-lift = -2em
#let sidenote-color = luma(100)
// Sidenote markers reuse the single brand accent instead of the
// original template's separate red, keeping the palette to one
// restrained accent color throughout the document.
#let sidenote-number-color = mlb-turquoise

#let note(dy:auto, numbered:true, content) = {
  if numbered {
    notecounter.step()
    text(weight:"regular",fill:sidenote-number-color,super(context notecounter.display()))
  }
  text(size:0.75em,font: sans-fonts,fill:sidenote-color,{
    show emph: it => smallcaps(text(style: "normal", it.body))
    box(move(dy: sidenote-lift, margin-note(if numbered {
      text(weight:"regular",font:sans-fonts,size:0.75em,fill:sidenote-number-color,{
        context notecounter.display()
        h(1em, weak: true)
      })
      content
    } else {
      content}
      ,dy:dy,
      stroke: none,
      side: right,
      margin-right: margin-right - 2cm,
      margin-left: margin-right - 4cm,
      page-width: margin-right + 2cm,
      page-offset-x: 0in,
    )))
  })
  }

/* Sidenote citation
Display a short citation in the right margin with the `notecite()` function.
Takes 2 optional keyword and 1 required argument.
  - `dy: length | auto` Adjust the vertical position (default `auto`, same
    stacking behavior as `note()` above).
  - `supplement: content` Supplement for the in-text citation (e.g., `p.~7`), (default `none`).
  - `key: label` The bibliography entry's label.

CAUTION: if no bibliography is defined, then this function will not display anything.
*/
#let notecite(dy:auto,supplement:none,key) = context {
  let elems = query(bibliography)
  if elems.len() > 0 {
    cite(key,supplement:supplement,style:"ieee")
    note(
      cite(key,form: "full",style: "short_ref.csl"),
      dy:dy,numbered:false
    )
  }
}

// == EXPLAINER ==

#let explainer(dy: auto, content) = {
  box(move(dy: sidenote-lift, margin-note(
    box(
      width: 100%,
      fill: gray.lighten(90%),
      radius: 8pt,
      inset: (x: 9pt, y: 9pt),
      {
        set text(size: 0.75em)
        content
      }
    ),
    dy: dy,
    stroke: none,
    side: right,
    margin-right: margin-right - 2cm,
    margin-left: margin-right - 4cm,
    page-width: margin-right + 2cm,
    page-offset-x: 0in,
  )))
}

// == Quotes ==

#let quote(attribution: none, color: mlb-turquoise.lighten(92%), accent: mlb-turquoise, content) = {
  box(
    width: 100%,
    inset: (x: 1em, y: 1em),
    {
      // Quote text
      set text(
        font: sans-fonts,
        size: 1.0em,
        weight: "regular",
        fill: mlb-marin,
        hyphenate: false,
        features: ("ss02", "ss03")
      )
      set par(leading: 0.6em, first-line-indent: 0pt)

      content + if attribution != none {
        h(0.5em, weak: false)
        set text(
          font: sans-fonts,
          size: 8pt,
          weight: "bold",
          fill: accent,
          tracking: 0.04em
        )
        upper(attribution)
      }
    }
  )

  v(0.5em, weak: false)
}

#let marginquote(attribution: none, dy: auto, content) = {
  box(move(dy: sidenote-lift, margin-note(
    {
      set text(font: heading-fonts, size: 18pt, hyphenate: false, weight: "regular", fill: mlb-turquoise, features: ("ss02", "ss03"))
      set par(leading: 0.4em, first-line-indent: 0pt)
      content
      if attribution != none {
        linebreak()
        v(3pt, weak: false)
        set text(
          font: sans-fonts,
          size: 8pt,
          weight: "bold",
          fill: gray,
          tracking: 0.04em
        )
        upper(attribution)
      }
    },
    dy: dy,
    stroke: none,
    side: right,
    margin-right: margin-right - 2cm,
    margin-left: margin-right - 4cm,
    page-width: margin-right + 2cm,
    page-offset-x: 0in,
  )))
}

#let pullquote(attribution: none, content) = wideblock({
  v(1.5em, weak: false)
  set text(font: sans-fonts, size: 1.5em, weight: "bold", fill: mlb-marin, hyphenate: false)
  set par(leading: 0.6em, first-line-indent: 0pt, justify: false)
  box(width: 85%, {
    content
  })
  if attribution != none {
        linebreak()
        v(6pt, weak: false)
        set text(
          font: sans-fonts,
          size: 8pt,
          weight: "bold",
          fill: mlb-turquoise,
          tracking: 0.04em
        )
        upper(attribution)
      }
  v(0.5em, weak: false)
})

#let largequote(attribution: none, content) = wideblock({
  v(3em, weak: false)
  set text(font: heading-fonts, size: 4em, weight: "regular", fill: mlb-marin, hyphenate: false, features: ("ss02", "ss03"))
  set par(leading: 0.3em, first-line-indent: 0pt, justify: false)
  box(width: 75%, {
    content
  })
  if attribution != none {
    linebreak()
    v(0.3em, weak: false)
    text(font: sans-fonts, size: 10pt, weight: "bold", fill: mlb-turquoise, tracking: 0.03em, attribution)
  }
  v(0.5em, weak: false)
})