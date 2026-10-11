#import "@preview/ctheorems:1.1.3": *
#import "@preview/quick-maths:0.2.1": shorthands
#import "@preview/marginalia:0.3.1" as marginalia

// Macros for common snippets:
#let def = $:=$
#let st = $"s.t."$
#let iff = $<==>$
#let bij = $<->$
#let inj = $arrow.r.hook$
#let surj = $arrow.r.twohead$
#let QED = [#h(1fr)$qed$]
#let section = sym.section
#let divider = [#line(length: 100%)]
#let note(body) = [*#smallcaps("Note"):*~#body]
#let case(title, body) = [+ #block[*#title*#parbreak()#body]]
#let todo(body) = [#block(fill: orange, inset: 4pt, text(size: 2em)[*TODO:* #body])]
#let bar(x) = $overline(#x)$
#let card(x) = $\#(#x)$
#let inv(x) = $#x^(-1)$
#let cmath(color, body) = text(fill: color)[$#body$]
#let mics = $upright(mu s)$
// Sidenotes share one sequence with footnotes so numbers never collide.
#let sidenote = marginalia.note.with(
  counter: counter(footnote),
  numbering: (..n) => super(numbering("1", ..n)),
  flush-numbering: true, // Number inline at the start of the note, not hanging into the gap.
  // Force size/weight/style so notes don't pick up formatting from where their marker sits.
  text-style: (size: 9pt, weight: "regular", style: "normal"),
)
#let sn = sidenote
#let s = sidenote
#let fn = footnote
// Block spanning the text and sidenote columns; notes shift to avoid it. Normal width without sidenotes.
#let wideblock = marginalia.wideblock
// Use as `#show: page_per_h1` to start every following level-1 heading on a fresh page.
#let page_per_h1(rest) = { show heading.where(level: 1): it => pagebreak(weak: true) + it; rest }

// Theme style config:
#let margin_presets = (
  default: (left: 2.5cm, right: 2.5cm, top: 2.5cm, bottom: 2.5cm), // Typst's default for A4.
  compact: (left: 1.5cm, right: 1.5cm, top: 2cm, bottom: 2cm),
)

#let colors = (
  cherry_red: rgb("#ba0017"),
  powder_pink: rgb("#FEF2F4"),
  salmon_pink: rgb("#EE6983"),
  cream: rgb("#FFF4E0"),
  peach: rgb("#F4B183"),
  pale_blue: rgb("#F7FBFC"),
  light_blue: rgb("#769FCD"),
  pale_sage: rgb("#F3F7ED"),
  sage: rgb("#98B475"),
)

#let thmbox_args = (
  titlefmt: title => [
    #place(top + right)[#text(12pt)[#smallcaps[#title]]]
    #sym.wj
    #h(0pt, weak: true)
  ],
  namefmt: name => [#text(12pt, weight: "bold")[#name]],
  separator: none,
  bodyfmt: body => [#v(-1pt)#body],
  padding: (top: 0em, bottom: 0em),
  inset: (top: 0.7em, rest: 8pt),
)

// Boxes from ctheorems:
#let theorem = thmbox(
  "theorem",
  "Theorem",
  fill: colors.powder_pink,
  stroke: colors.salmon_pink,
  ..thmbox_args,
)

#let lemma = thmbox(
  "lemma",
  "Lemma",
  fill: colors.cream,
  stroke: colors.peach,
  ..thmbox_args,
)

#let corollary = thmbox(
  "corollary",
  "Corollary",
  fill: colors.pale_blue,
  stroke: colors.light_blue,
  ..thmbox_args,
)

#let example = thmbox(
  "example",
  "Example",
  fill: colors.pale_blue,
  stroke: colors.light_blue,
  ..thmbox_args,
)

#let definition = thmbox(
  "definition",
  "Definition",
  fill: colors.pale_sage,
  stroke: colors.sage,
  ..thmbox_args,
)

#let proof = thmproof(
  "proof",
  "Proof",
  inset: 0pt,
  titlefmt: title => [*#smallcaps(title)*],
)

// Theme loader:
#let themed_document(
  // ----------------------------------------------------------------------------------- //
  // Title:
  title: "An Untitled Note",
  author: "Anonymous",
  date: datetime.today().display("[month repr:long] [day], [year]"),
  title_align: center, // May prefer left for more casual documents.
  toc: false,
  margins: none, // none for the Typst default, or a preset name from `margin_presets`.
  sidenotes: false, // Reserves extra right margin for #sidenote[...] and moves the TOC there.
  sidenote_width: 5cm, // Added to the right margin when sidenotes are enabled.
  // Headings:
  heading_font: "Libertinus Sans", // Others: New Computer Modern Sans, Libertinus Serif.
  heading_numberings: (sym.section + "1.1.",), // Per-level numbering; falls back to last.
  // Numbering:
  eqn_numbering: "(1)", // May prefer something like (I) for style.
  eqn_ref_numbering: "(1)", // May prefer something like Eq. (1) for clarity.
  // ----------------------------------------------------------------------------------- //
  body,
) = {
  // Shorthands for math equations.
  show: shorthands.with(
    ($,,$, $thin$),
  )

  show: thmrules.with(qed-symbol: $qed$) // Must do this or theorems will format weirdly!
  set document(title: title, author: if author == none { "Unknown" } else { author }) // Metadata.
  set par(justify: true) // Make paragraphs pretty.


  // Colored links.
  show link: it => {
    set text(if (type(it.dest) == str) { blue } else { colors.cherry_red })
    it
  }

  // Make theorem, equation, etc references links.
  show ref: it => {
    if it.element == none { return it }

    if it.element.func() == figure and it.element.kind == "thmenv" {
      // From: https://github.com/sahasatvik/typst-theorems/theorems.typ
      let supplement = it.element.supplement
      if it.citation.supplement != none { supplement = it.citation.supplement }
      let thms = query(selector(<meta:thmenvcounter>).after(it.element.location()))
      let number = thmcounters.at(thms.first().location()).latest

      link(it.target, [#supplement~#numbering(it.element.numbering, ..number)])
    } else if it.element.func() == math.equation {
      link(it.target, [#numbering(eqn_ref_numbering, ..counter(math.equation).at(it.target))])
    } else { it }
  }

  // Number equations, but only number equations with labels attached.
  set math.equation(numbering: eqn_numbering)
  show math.equation: it => {
    // Idea from: https://forum.typst.app/t/how-to-conditionally-enable-equation-numbering-for-labeled-equations
    if it.block and it.numbering != none and not it.has("label") [
      #counter(math.equation).update(v => v - 1)
      #math.equation(it.body, block: true, numbering: none)
    ] else { it } // Only show equation numbers when they are labeled and have numbering.
  }

  // Seperate and color heading numbers differently from heading text.
  set heading(numbering: heading_numberings.first())
  show heading: it => {
    block([
      #set text(font: heading_font, size: 21pt - (it.level * 2.5pt))
      #if (it.numbering != none) [
        #text(colors.cherry_red)[#counter(heading).display(heading_numberings.at(
          calc.min(it.level, heading_numberings.len()) - 1,
        ))]
        #h(3pt) // Space between numbering and heading text.
      ]
      #it.body
      #v(0.4em) // Space below headings.
    ])
  }

  // Page margins, widened on the right if sidenotes are enabled.
  let margin = margin_presets.at(if margins == none { "default" } else { margins })
  if sidenotes { margin.right += sidenote_width }
  let full_width = 100% + (margin.right - margin.left) // Text width plus the sidenote area.

  // Sidenote column in the right margin, with outer padding mirroring the left page margin.
  // Marginalia sets the page margins from this, so it must agree with `margin` above.
  let note_sep = 1.5em // Gap between the text and the sidenote column.
  show: marginalia.setup.with(
    inner: (far: margin.left, width: 0pt, sep: 0pt),
    outer: if sidenotes {
      (far: margin.left, width: margin.right - margin.left - note_sep, sep: note_sep)
    } else { (far: margin.right, width: 0pt, sep: 0pt) },
    top: margin.top,
    bottom: margin.bottom,
  )

  // Figure captions go in the sidenote column, top-aligned with the figure (from marginalia's README).
  set figure(gap: 0pt) if sidenotes // Caption is in the margin, so no gap below the figure.
  set figure.caption(position: top) if sidenotes
  show figure.caption.where(position: top): it => if sidenotes {
    sidenote(
      alignment: "top", counter: none, shift: "avoid", keep-order: true,
      dy: -0.01pt, // So the caption is placed above wide figures rather than pushed below them.
      it,
    )
  } else { it }

  set page(
    // Pretty header on each non-cover page with title & dots for page num.
    header: context {
      let page_num = here().page()
      if page_num > 1 { block(width: full_width)[
        *#smallcaps[#title]*
        #h(1fr)
        #box(
          inset: (bottom: 1pt),
          (
            calc.min(page_num, 50) // Too many dots is bad for long docs.
              * (
                box(
                  circle(
                    radius: 2pt,
                    fill: black,
                  ),
                ),
              )
          ).join(h(2pt)),
        )
      ] }
    },
    // Pretty footer with author & page num.
    footer: context {
      let page_counter = counter(page)
      if (page_counter.final().at(0) == 1) { return none }
      block(width: full_width)[
        #text(weight: "bold", smallcaps[#if here().page() > 1 [#author] else [#sym.arrow.b]])
        #h(1fr)
        #page_counter.display("1 of 1", both: true)
      ]
    },
  )

  // Title, author, date (centered on the page even if the margins are asymmetric).
  block(width: full_width, align(title_align)[
    #set text(font: heading_font)
    #block(spacing: 1.3em)[#text(25pt, weight: "bold")[#title]]
    #text(15pt)[
      #if author == none [
        #text(colors.cherry_red)[#date]
      ] else [
        #author (#text(colors.cherry_red)[#date])
      ]
    ]
  ])

  v(1em) // Some vertical space.

  // Pretty table of contents if enabled.
  if toc {
    let contents = {
      show outline: it => {
        show heading: it => {
          set text(font: heading_font)
          set par(first-line-indent: 0em)
          it.body
          v(0.75em)
        }
        show outline.entry.where(level: 1): it => {
          text(colors.cherry_red)[#strong[#it]]
        }
        show outline.entry: it => {
          v(0.1em)
          text(font: heading_font, colors.cherry_red)[#it]
        }
        it
      }

      outline(indent: if sidenotes { 0.6em } else { auto }) // Narrow notes can't afford auto indents.
    }

    if sidenotes {
      place(sidenote(counter: none, alignment: "top", box(width: 100%, align(left, contents))))
    } else { contents }
  }

  v(1em) // Some more vertical space.

  body
}
