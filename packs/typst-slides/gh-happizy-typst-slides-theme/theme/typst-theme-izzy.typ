#import "@preview/zebraw:0.6.3": *

/// Attaches speaker-note content to the current slide.
///
/// `skip` moves the note forward by a number of physical continuation pages.
/// It defaults to `0`, which keeps the note on the slide's first page. Enabling
/// note panels remains the responsibility of `slides(speaker-notes: true)`.
#let speaker-note(body, skip: 0) = metadata((
  kind: "izzy-speaker-note",
  body: body,
  skip: skip,
))

// Footnotes run-in ------------------------------------------------------------
// Override #footnote to render entries in a compact run-in list at the bottom
// of the content. `newline: true` forces a line break before that entry.
// `break` is a Typst keyword, so the argument is named `newline`.
//
// This override must be defined at module scope because content passed to
// `slides(...)` is evaluated in the caller's scope before the function call.
// A wildcard import therefore shadows Typst's native `footnote` in the caller.
// The theme retains access to the native element through `__std-footnote`.
#let __std-footnote = footnote
#let __izzy-fn-breaks = state("izzy-fn-breaks", ())

/// Replaces Typst's native `footnote` after a wildcard theme import.
///
/// It accepts the native footnote arguments plus `newline: true`, which starts
/// this entry on a new line in the theme's compact run-in footnote list.
#let footnote(..args) = {
  let brk = args.named().at("newline", default: false)
  // Forward every other named argument to the native footnote.
  let fwd = (:)
  for (k, v) in args.named() {
    if k != "newline" { fwd.insert(k, v) }
  }
  // A label reference does not create a numbered entry. Record the line-break
  // flag only for real notes to stay aligned with the global footnote counter.
  let is-ref = args.pos().len() > 0 and type(args.pos().first()) == label
  if not is-ref { __izzy-fn-breaks.update(a => a + (brk,)) }
  __std-footnote(..args.pos(), ..fwd)
}

// Separator shared with #footnotes-display(). slides() updates it to the
// configured title color; this default also supports standalone use.
#let __izzy-fn-line = state("izzy-fn-line", line(length: 40% + 0pt, stroke: 0.05em + rgb("#0d44ac")))

// Whether page `pg` contains a call to #footnotes-display().
#let __izzy-page-has-display(pg) = query(metadata).any(m => (
  type(m.value) == dictionary
    and m.value.at("kind", default: "") == "izzy-footnotes-display"
    and m.location().page() == pg
))

// Build the run-in list from footnote elements. Must be called in context.
#let __izzy-render-notes(notes) = {
  let breaks = __izzy-fn-breaks.final()
  set text(0.8em)
  let out = []
  let i = 0
  for n in notes {
    let k = counter(__std-footnote).at(n.location()).first()
    let brk = if k - 1 < breaks.len() { breaks.at(k - 1) } else { false }
    let marker = super(numbering(n.numbering, k))
    if i == 0 {
      out = out + marker + h(0.35em) + n.body
    } else if brk {
      out = out + linebreak() + marker + h(0.35em) + n.body
    } else {
      out = out + h(1em) + marker + h(0.35em) + n.body
    }
    i = i + 1
  }
  out
}

/// Renders the current page's footnotes at the call site instead of at the
/// bottom of the page. Without this call, footnotes remain at the bottom.
#let footnotes-display() = context {
  let pg = here().page()
  let notes = query(__std-footnote).filter(n => n.location().page() == pg)
  if notes.len() > 0 {
    v(0.4em)
    __izzy-fn-line.get()
    v(__std-footnote.entry.clearance)
    __izzy-render-notes(notes)
  }
  metadata((kind: "izzy-footnotes-display")) // Suppress the bottom list.
}

/// Creates a visible, numbered section slide excluded from the table of
/// contents. Its child slides remain visible in the section overview.
#let hidden-section(title) = heading(
  level: 1,
  outlined: false,
  title,
)

/// Builds and styles a complete slide deck.
///
/// - `content` accepts arbitrary Typst content. Level-one headings create
///   section slides and level-two headings create content slides.
/// - `title` is required even when `first-slide` is `false`.
/// - `font` sets the presentation font; `subtitle` and `date` configure the
///   generated title slide.
/// - `authors` accepts one author or an array and supplies document metadata.
/// - `title-logo` and `content-logo` each accept one item or an array; `none`
///   entries are ignored.
/// - `ratio` controls one slide's width-to-height ratio. Slide height is fixed
///   at `10.5cm`, with `1.6cm` as the layout spacing unit.
/// - `title-color` defaults to `#0d44ac`; `bg-color` defaults to `#faf9f6`.
/// - `first-slide` controls automatic title-slide generation; `toc` controls
///   automatic table-of-contents generation.
/// - `speaker-notes` adds a notes panel beside every slide and therefore
///   doubles the physical PDF page width.
/// - `title-note` and `toc-note` accept arbitrary content for their generated
///   slides. They do not enable speaker notes. Each is ignored when its related
///   generated slide is disabled, and the ToC note appears only on its first
///   physical page.
/// - `counter-total` selects `current / total` physical-page numbering instead
///   of the current page only. Title, ToC, section, and continuation pages all
///   count.
/// - `contents-label` changes the ToC title and its footer label.
/// - `slide-label` changes the label shown only in speaker-note panels.
#let slides(
  content,
  title: none,
  font: "Alegreya",
  subtitle: none,
  date: none,
  authors: (),
  title-logo: (),
  content-logo: (),
  ratio: 4 / 3,
  title-color: none,
  first-slide: true,
  bg-color: rgb("#faf9f6"),
  toc: true,
  speaker-notes: false,
  title-note: none,
  toc-note: none,
  counter-total: true,
  contents-label: [Contents],
  slide-label: [Slide],
) = {
  let height = 10.5cm
  let space = 1.6cm
  let slide-width = ratio * height
  let width = if speaker-notes { 2 * slide-width } else { slide-width }
  let notes-margin = if speaker-notes {
    (left: 0cm, right: slide-width, top: 0cm, bottom: 0cm)
  } else {
    0cm
  }

  if type(title-logo) != array {
    title-logo = (title-logo,)
  }
  let title-logos = title-logo.filter(logo => logo != none)

  if type(content-logo) != array {
    content-logo = (content-logo,)
  }
  let content-logos = content-logo.filter(logo => logo != none)

  let page-margin = if speaker-notes {
    (
      left: 0.5 * space,
      right: slide-width + 0.5 * space,
      top: space + 1em,
      bottom: 0.6 * space,
    )
  } else {
    (x: 0.5 * space, top: space, bottom: 0.6 * space)
  }

  // Colors
  if title-color == none {
    title-color = rgb("#0d44ac")
  }
  let block-color = title-color.lighten(90%)
  let header-color = title-color.lighten(65%)
  let fill-color = title-color.lighten(50%)

  // Setup
  set text(font: font, 1em)
  set document(
    title: title,
    author: authors,
  )
  set heading(numbering: "1.a")
  let slide-counter(current, total) = if counter-total {
    [#current / #total]
  } else {
    current
  }

  // Map a note location to the page of the slide it belongs to.
  let slide-page-for(loc) = {
    let anchors = query(
      selector(heading.where(level: 1).or(heading.where(level: 2))).before(loc),
    )
    if anchors.len() > 0 {
      anchors.last().location().page()
    } else {
      loc.page()
    }
  }

  let notes-panel = context {
    let page-num = here().page()
    let total = counter(page).final().first()

    let sections = query(heading.where(level: 1))
    let section = sections.rev().find(h => h.location().page() <= page-num)

    let subsections = query(heading.where(level: 2))
    let subsection = subsections.rev().find(h => h.location().page() <= page-num)

    // A note appears on the slide's first page plus `skip`. If `skip` exceeds
    // the slide's actual continuation-page count, it lands on a later slide.
    let notes = query(metadata).filter(m => {
      let value = m.value
      (
        type(value) == dictionary
          and value.at("kind", default: "") == "izzy-speaker-note"
          and slide-page-for(m.location()) + value.at("skip", default: 0) == page-num
      )
    })

    place(
      left + top,
      dx: slide-width,
      block(
        width: slide-width,
        height: height,
        fill: bg-color,
        inset: (x: 0.5 * space, top: 0.5 * space, bottom: 0.6 * space),
      )[
        #block(
          width: 100%,
          fill: header-color,
          inset: 8pt,
          radius: 2pt,
          below: 0.6em,
        )[
          #set text(0.85em, fill: title-color)
          #if section != none { strong(section.body) } else { [—] }
          #v(0.3em)
          #if subsection != none { subsection.body } else { [—] }
          #v(0.3em)
          #text(weight: "bold")[#slide-label #slide-counter(page-num, total)]
        ]
        #if notes.len() > 0 {
          for note in notes {
            note.value.at("body")
            v(0.5em)
          }
        } else {
          set text(fill: title-color.lighten(40%))
          align(horizon)[—]
        }
      ],
    )
  }

  // PAGE----------------------------------------------
  set page(
    fill: bg-color,
    width: width,
    height: height,
    margin: page-margin,
    background: place(
      top + left,
      image(
        "theme-assets/bg-content.png",
        width: slide-width,
        height: height,
        fit: "cover",
      ),
    ),
    foreground: if speaker-notes { notes-panel } else { none },
    // HEADER
    header: context {
      let page = here().page()
      let headings = query(selector(heading.where(level: 2)))
      let heading = headings.rev().find(x => x.location().page() <= page)

      let title-content = if heading != none {
        [
          #heading.body
          #if not heading.location().page() == page [
            #{ numbering("(i)", page - heading.location().page() + 1) }
          ]
        ]
      }

      let logo-content = if content-logos.len() > 0 {
        stack(
          dir: ltr,
          spacing: 0.75em,
          ..content-logos,
        )
      }

      let header-grid = [
        #grid(
          columns: (1fr, auto),
          gutter: 0.75em,
          align: (left + horizon, right + horizon),
          if title-content != none {
            title-content
          },
          if logo-content != none {
            logo-content
          },
        )]

      [
        #v(-space)
        #set text(1.4em, weight: "bold", fill: title-color)
        #header-grid
      ]
    },
    // FOOTER ----------------------------------------------------
    footer: [
      #set text(0.7em)
      #context {
        let page-num = here().page()
        let sections = query(heading.where(level: 1))
        let section = sections.rev().find(h => h.location().page() <= page-num)
        let last = counter(page).final().first()
        let current = here().page()

        let is-toc-page = (
          query(metadata)
            .filter(m => {
              let value = m.value
              (
                type(value) == dictionary
                  and value.at("kind", default: "") == "izzy-toc-page"
                  and m.location().page() == page-num
              )
            })
            .len()
            > 0
        )

        grid(
          columns: (1fr, 1fr),
          align: (left, right),
          inset: 4pt,
          [
            #if is-toc-page {
              contents-label
            } else if section != none {
              section.body
            } else {
              [—]
            }
          ],
          [
            #text(fill: black)[#slide-counter(current, last)]
          ],
        )
      }
    ],
    footer-descent: 0.2 * space,
  )

  // SLIDES STYLING --------------------------------------------------
  // Section Slides
  show heading.where(level: 1): x => {
    pagebreak(weak: true)
    set page(header: none, footer: none, margin: notes-margin, background: place(
      top + left,
      image(
        "theme-assets/bg-section.png",
        width: slide-width,
        height: height,
        fit: "cover",
      ),
    ))
    set align(horizon)
    context {
      // Collect the level-2 headings belonging to this section:
      // everything between this level-1 heading and the next one.
      let loc = x.location()
      let ordered = query(heading.where(level: 1).or(heading.where(level: 2)))
      let subs = ()
      let in-section = false
      for h in ordered {
        if h.level == 1 {
          if h.location().page() == loc.page() {
            in-section = true
          } else if in-section {
            break
          }
        } else if in-section {
          subs.push(h)
        }
      }

      grid(
        columns: (1fr, 3fr),
        inset: 10pt,
        align: (right, left),
        fill: (title-color.opacify(-20%), bg-color),
        [#block(height: 100%)],
        [
          #text(1.2em, weight: "bold", fill: title-color)[#x]
          #if subs.len() > 0 {
            v(0.6em)
            set text(0.5em, fill: title-color)
            for sub in subs {
              link(sub.location())[
                #box(baseline: 0pt)[
                  #text(weight: "bold")[#numbering("1. 1", ..counter(heading).at(sub.location()))]
                  #h(0.4em) #sub.body
                ]
              ]
              linebreak()
            }
          }
        ],
      )
      // Drawn after the grid so the opaque cell fills don't hide it.
      place(
        bottom + right,
        dx: -0.59 * space,
        dy: -0.203 * space + 0.3pt,
        text(0.454em, fill: black, weight: "regular")[
          #slide-counter(here().page(), counter(page).final().first())
        ],
      )
    }
  }
  show heading.where(level: 2): pagebreak(weak: true) // this is where the magic happens
  show heading: set text(1.1em, fill: title-color)

  // ADDITIONAL STYLING --------------------------------------------------
  // Terms
  show terms.item: it => {
    stack(
      block(width: 100%, inset: 5pt, fill: header-color, radius: (top: 0.2em, bottom: 0cm), strong(it.term)),
      block(width: 100%, inset: 5pt, fill: block-color, radius: (top: 0cm, bottom: 0.2em), it.description),
    )
  }

  // Code
  show raw.where(block: false): it => {
    box(fill: block-color, inset: 1pt, radius: 1pt, baseline: 1pt)[#text(it)]
  }

  show: zebraw.with(
    radius: 4pt,
    lang: false,
    hanging-indent: true,
  )

  // Bullet List
  show list: set list(marker: (
    text(fill: title-color)[•],
    text(fill: title-color)[‣],
    text(fill: title-color)[-],
  ))

  // Enum
  let color_number(nrs) = text(fill: title-color)[*#nrs.*]
  set enum(numbering: color_number)

  // Quote
  set quote(block: true)
  show quote.where(block: true): it => {
    v(-5pt)
    block(
      fill: block-color,
      inset: 5pt,
      radius: 1pt,
      stroke: (left: 3pt + fill-color),
      width: 100%,
      outset: (left: -5pt, right: -5pt, top: 5pt, bottom: 5pt),
    )[#it]
    v(-5pt)
  }

  // Run-in footnotes (see the #footnote override above).
  // Native run-in layout is unavailable (typst#6965), and every footnote.entry
  // is a separate block. The first note on each page therefore renders the
  // complete run-in list while the remaining entries render nothing. This
  // keeps the list in the native footnote area and reserves the expected space.
  // Limitations: page grouping follows marker positions and may be imperfect
  // when many notes overflow; links to empty entries share one visual target.
  //
  // When a page calls #footnotes-display(), notes render at that call site and
  // the bottom list is suppressed through empty entries and no separator.
  // Because `clearance` is a non-contextual length, a small clearance-sized
  // gap remains at the bottom of those pages.
  __izzy-fn-line.update(line(length: 40% + 0pt, stroke: 0.05em + title-color))

  set __std-footnote.entry(
    clearance: .7em, // Between slide content and the separator.
    gap: 0pt, // Empty entries must not add inter-entry spacing.
    indent: 0pt,
    separator: context {
      if __izzy-page-has-display(here().page()) { none }
      else { line(length: 40% + 0pt, stroke: 0.05em + title-color) }
    },
  )

  show __std-footnote.entry: it => context {
    let loc = it.note.location()
    if __izzy-page-has-display(loc.page()) {
      [] // #footnotes-display() owns rendering on this page.
    } else {
      let notes = query(__std-footnote).filter(n => n.location().page() == loc.page())
      let this-num = counter(__std-footnote).at(loc).first()
      let first-num = counter(__std-footnote).at(notes.first().location()).first()
      if this-num != first-num {
        [] // Non-first entries add no visible content.
      } else {
        // Space between the separator and the definitions.
        v(__std-footnote.entry.clearance)
        __izzy-render-notes(notes)
      }
    }
  }

  // Link
  show link: it => {
    if type(it.dest) != str {
      // Local Links
      it
    } else {
      underline(stroke: 0.5pt + title-color)[#it] // Web Links
    }
  }

  // Outline
  set outline(
    target: heading.where(level: 1),
    indent: auto,
  )

  show outline: set heading(level: 2) // To not make the TOC heading a section slide by itself

  // Bibliography
  set bibliography(
    title: none,
  )

  // References
  show ref: it => {
    // Filter only for links, not for citations
    if it.element != none {
      let el = it.element
      set text(size: 0.7em, fill: white)
      box(
        fill: fill-color,
        outset: (x: 0.0em, y: 0.2em),
        radius: 0.8em,
        height: 0.8em,
        inset: (x: 0.5em),
      )[
        // if no supplement is passed
        #if el.func() == heading and it.supplement == auto {
          link(el.location(), el.body)
        } else if el.func() == heading {
          // if a supplement is passed
          link(el.location(), it.supplement.text)
        } else {
          // everything else (equations, figures etc)
          it
        }
      ]
    } else {
      // these are the citations
      return it
    }
  }

  // CONTENT---------------------------------------------
  // Title Slide
  if (title == none) {
    panic("A title is required")
  } else if (first-slide == false) {
    // Suppress the automatically generated title slide.
  } else {
    if (type(authors) != array) {
      authors = (authors,)
    }
    set page(footer: none, header: none, margin: notes-margin, background: place(
      top + left,
      image(
        "theme-assets/bg-title.png",
        width: slide-width,
        height: height,
        fit: "cover",
      ),
    ))
    block(
      inset: (x: 0.5 * space, top: 0.5em, bottom: 3mm),
      fill: title-color.opacify(-20%),
      width: 100%,
      height: 75%,
      align(bottom)[
        #align(left + horizon)[
          #v(1fr)
          #stack(
            dir: ltr,
            spacing: 1em,
            ..title-logos,
          )
        ]
        #v(-4mm) // Keep your vertical adjustment here if needed below the logos

        #text(2.0em, weight: "bold", fill: bg-color, title)
        #v(-5mm)
        #text(1.4em, fill: bg-color, style: "italic", subtitle)
        #v(30pt)
      ],
    )
    block(
      height: 20%,
      width: 100%,
      inset: (x: 0.5 * space, top: -3mm, bottom: 3em),
      if date != none and authors != none {
        [
          #v(10pt)
          #text(1.1em, fill: black, date)
          #v(-6pt)
          #text(1.1em, fill: black, authors.join())
        ]
      },
    )
    if title-note != none {
      speaker-note(title-note)
    }
  }

  // Outline
  if (toc == true) {
    metadata((kind: "izzy-toc-page"))
    if toc-note != none {
      speaker-note(toc-note)
    }
    outline(title: contents-label)
  }
  // The body of the slides
  content
}
