/**
 * Typst template for the Master's Dissertation at
 * the faculty of Engineering and Architecture at Ghent University
 *
 * Made-by: Caspar Nuël <casparnuel@yandex.com, Caspar.Nuel@UGent.be>
 */

/*
  TODOs:
  [ ] Multilingual support (probably hard to do?)
      Currently just adding some `tl-...` fields to allow translating certain English words at the users will.
  [ ] Represent persons as a dictionary (custom type -> may need to wait for future typst version) that also contains their e-mail, faculty, ...
    - Allows the user to re-use the "person" struct, and for receiving functions to extract the email, facutly etc of a person and place it correctly. Current workaround is ordered lists but this is cumborsome for the user.
  [ ] Share parameters of the main template function with sub-functions:
    - Allows the user to define authors, counsellors, supervisors, ... only once, and reuse throughout the document. Ideally, functions that take these default parameters still allow them to be overwritten (as for example the abstracts may need an English title and a Dutch title)
      Possible solutions/leads:
        https://forum.typst.app/t/how-to-share-settings-between-template-functions/4608
        https://forum.typst.app/t/how-can-i-have-global-configuration-parameters-for-a-module-package/3365

      Saving these parameter arguments in a state is not really a solution as they require context, causing issues with any template function that later requires to "get" the values of the state. Wrapping the entire template in context is not desireable. Better approaches probably exist, should be looked into.
        
  [ ] Fix the spacing for Appendices titles. Ideally, appendix numbering would be "Appendix A: some-title" and (without a body) "Appendix B" (note the absence of a colon). Currently this breaks the outline as there is not enough space to fit "Appendix A", it causes a newline. As a compromise, appendices are currently only numbered as "A", "B", ... but this shortcomming should be fixed

  [ ] Outline highlighting fixen om dubbele entry/link boxes te vermeiden. Line 151. Mogelijke fix de outline anders bouwen door in de outline-niveau show-rule voor iedere originele entry een eigen entry te tonen met aangepaste inhoud, ipv de links manueel te bouwen zoals nu gedaan wordt.
*/

 
// ============================================================================
//                             HELPER FUNCTIONS                
// ============================================================================

#let todo(
  width: 100%,
  inset: .4em,
  stroke: (paint: black, thickness: 2pt),
  content
) = {
  box(
    fill: yellow,
    width: width,
    inset: inset,
    stroke: stroke,
    content
  )
}

#let current-chapter-title() = context {
  let headings-before = query(heading.where(level: 1).before(here()))
  if headings-before == () {
    return
  }
  // See if a heading was defined on the current page
  let heading-on-this-page = query(heading.where(level: 1)).any(it => it.location().page() == here().page())
  if (not heading-on-this-page) {
    text(str(counter(heading).at(here()).at(0)) + "  " + headings-before.last().body, size: 1.2em)
  }
}

#let title-page(
  title-numbering: none,
  page-numbering: none,
  outlined: true,
  font-size: 18pt,
  alignment: center + horizon,
  title
) = {
  set page(numbering: page-numbering)
  set text(font-size)
  pagebreak(weak: true)
  align(
    alignment,
    heading(
      numbering: title-numbering,
      outlined: outlined,
      title
    )
  )
}

#let reset-figure-counters() = {
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
}

// ============================================================================
//                         MAIN TEMPLATE SHOW RULE
// ============================================================================

/**
 * Core template rules. This should be applied to the entire document.
*/
#let ugent-masterproef-template(
  title: "Title",
  authors: ("John Doe", "Jane Smith", "David Moore"),
  supervisors: ("Prof. Jacob Major", "Dr. Susan Smith"),
  counsellors: ("David Blogg", ),
  academic-years: (2025, 2026),
  language: "en",
  margin: 2.5cm,
  paper: "a4",
  highlight-links: false,
  highlight-internal-links-color: red.lighten(50%),
  highlight-external-links-color: blue.lighten(50%),
  doc
) = {
  set page(
    margin: margin,
    paper: paper,
    numbering: "1"
  )
  set text(
    size: 12pt,
    font: "UGent Panno Text",
    spacing: 135%,
    lang: language
  )
  set bibliography(style: "institute-of-electrical-and-electronics-engineers")
  set heading(numbering: "1.1")
  set par(spacing: 1.6em, leading: .7em, justify: true)
  set list(indent: 2em, spacing: 1.5em)
  set enum(indent: 2em, spacing: 1.5em)
  show heading.where(level: 2): h => {
    set block(above: 2em, below: 1.5em)
    set text(size: 1.3em)
    h
  }
  show heading.where(level: 3): h => {
    set block(above: 1.4em, below: 1em)
    set text(size: 1.2em)
    h
  }
  show heading.where(level: 4): set heading(numbering: none)
  show heading.where(level: 4): set text(size: 13.5pt)
  show link: l => {
    if highlight-links {
      if type(l.dest) == str {
        box(l, stroke: highlight-external-links-color)
      } else {
        box(l, stroke: highlight-internal-links-color)
      }
    } else {
      l
    }
  }
  show ref: r => {
    if highlight-links {
      box(r, stroke: highlight-internal-links-color)
    } else {
      r
    }
  }
  show outline.entry: e => {
    if highlight-links {
      box(e, stroke: highlight-internal-links-color)
    } else {
      e
    }
  }
  show footnote: f => {
    if highlight-links {
      box(f, stroke: highlight-internal-links-color)
    } else {
      f
    }
  }
  set figure(numbering: (..num) =>
    numbering("1.1", counter(heading).get().first(), num.pos().first())
  )
  show figure.where(kind: raw): f => {
    align(left, f.body)
    align(center, f.caption)
  }
  show figure.where(kind: table): set figure.caption(position: top)
  show figure: block.with(breakable: false)
  let style-number(number) = text(gray)[#number]
  show raw.where(block: false): it => {
    box(it, fill: gray.lighten(85%), outset: (x: 2pt, y:3pt), radius: 5pt)
  }
  show raw.where(block: true): it => {
    block(
      fill: gray.lighten(85%),
      width: 100%,
      above: 3em,
      inset: 1em,
      radius: .8em,
      [
        #place(text(it.lang, fill: gray), top + right, dy: -2em, dx: .5em)
        #grid(
          columns: 2,
          align: (right, left),
          gutter: 0.5em,
          ..it.lines
            .enumerate()
            .map(((i, line)) => (text(gray, str(i + 1)), line))
            .flatten()
        )
      ]
    )
  }

  show emph: it => {
    box(skew(it, ax: -14deg))
  }
  
  show raw: set text(font: "Cascadia Mono", spacing: 100%, size: 9pt)
  show "->": sym.arrow.r
  show "<-": sym.arrow.l
  doc
  
  set page(numbering: none, header: none, footer: none)
  pagebreak(to: "even", weak: true) // Backside of last page should be blank
}

// ============================================================================
//                        TEMPLATE PARTS SHOW RULES
// ============================================================================
#let ugent-masterproef-frontpage(
  frontpage
) = {
  set page(
    margin: 0pt,
    numbering: none
  )

  frontpage
}

#let ugent-masterproef-preliminary-pages(
  prelim
) = {
  // The prelim page numbering starts at 1 again, this time as roman numerals
  counter(page).update(1)
  set page(numbering: "i")
  set heading(numbering: none)
  show outline: set heading(outlined: true)
  show heading.where(level: 1): h => {
    set block(spacing: 2em)
    pagebreak(weak: true)
    h
  }

  // wrapping in selector(...) is a fix for a known bug
  // See https://github.com/typst/typst/issues/4741
  show outline.where(target: selector(heading)): o => {
    set heading(outlined: false)
    show outline.entry: e => {
      let width = 3em
      let weight = "regular"
      let above = 0.75em

      if e.level == 1 {
        weight = "bold"
        above = 1.5em
      } else if e.level == 2 {
        width = 3em
      } else if e.level == 3 {
        width = 4em
      }

      text(
        weight: weight,
          if (e.prefix() != none) {
            if (e.prefix() != none) {
              block(above: above,
                link(e.element.location())[#box(e.prefix(), width: width) #e.element.body #box(width: 1fr, repeat(" .  . ")) #h(.5em) #e.page()]
              )
            } else {
              block(above: above,
                link(e.element.location())[#e.element.body #box(width: 1fr, repeat(" .  . ")) #h(.5em) #e.page()]
              )
            }
          } else {
            block(above: above,
              link(e.element.location())[#e.element.body #box(width: 1fr, repeat(" .  . ")) #h(.5em) #e.page()]
            )
          }
      )
    }
    o
  }
  prelim
}

#let ugent-masterproef-abstract(
  // Translations
  tl-by: "By",
  tl-academic-year: "Academic Year",
  tl-supervisors: "Supervisors",
  tl-counsellors: "Counsellors",
  tl-abstract: "Abstract",
  tl-keywords: "Keywords",
  tl-and: "and",
  // Arguments
  title: "Title",
  authors: ("John Doe", "Jane Smith", "David Moore"),
  supervisors: ("Prof. Jacob Major", "Dr. Susan Smith"),
  counsellors: ("David Blogg", ),
  academic-years: ("2025", "2026"),
  argument: "Master’s dissertation submitted in order to obtain the academic degree of Master of Science in Information Engineering Technology ",
  association: "Faculty of Engineering and Architecture",
  institution: "Ghent University",
  keywords: ("Keyword", "Science", "Engineering"),
  abstract
) = {
  set heading(outlined: false)
  pagebreak(weak: true)
  set page(numbering: none)
  
  align(
    center + horizon,
    block(
      width: 80%,
      [
        #set par(spacing: 2.4em, leading: 1.2em)
        #text(24pt, title, )
        #v(-1cm)
        #tl-by
        #v(-.4cm)
        #authors.join(", ", last: " " + tl-and + " ")

        #argument

        #tl-academic-year #academic-years.join("-")

        #tl-supervisors: #supervisors.join(", ", last: " " + tl-and + " ") #linebreak()
        #tl-counsellors: #counsellors.join(", ", last: " " + tl-and + " ")

        #association #linebreak()
        #institution
      ]
    )
  )

  v(1cm)
  
  text(tl-abstract, weight: "bold") + " - " + abstract

  v(0pt)
  
  text(tl-keywords + ": ", weight: "bold") + keywords.join(", ")
  pagebreak(weak: true)
}

#let ugent-masterproef-extended-abstract(
  extended-abstract
) = {
  // TODO!
  extended-abstract
}

#let ugent-masterproef-body(
  body
) =  {
  // The body page numbering starts at 1 again, this time as numbers
  counter(page).update(1)
  set page(
    numbering: "1",
    header: align(right, current-chapter-title())
  )
  show heading.where(level: 1): h => {
    pagebreak(weak: true)
    h
  }
  show heading.where(level: 1): h => {
    reset-figure-counters()
    if (counter(heading).at(here()).at(0) != 1) {
      pagebreak(weak: true)
    }
    block(
      breakable: false,
      below: 40pt,
      { if numbering != none {
          align(
            left + top,
            text(
              80pt,
              font: "Latin Modern Roman 9",
              weight: "bold",
              fill: color.rgb(50%, 50%, 50%),
              str(counter(heading).at(here()).at(0))
            )
          )
        }
      }
    )
    set text(size: 25pt)
    block(
      above:52pt,
      below: 52pt,
      h.body
    )
  }
  body
}

#let ugent-masterproef-appendix(
  title: "Appendices",
  appendix
) = {
    show heading.where(level: 1): h => {
    pagebreak(weak: true)
    h
  }
  counter(heading).update(0)
  title-page(title)
  set figure(numbering: (..num) =>
    numbering("A.1", counter(heading).get().first(), num.pos().first())
  )
  set heading(numbering: "A.1 ")
  appendix
}