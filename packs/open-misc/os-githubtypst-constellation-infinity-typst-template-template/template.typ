#import "@preview/ctheorems:1.1.3": *

// Macros for common snippets:
#let def = $:=$
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

// Theme style config:
#let colors = (
  cherry_red: rgb("#bf012a"),
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
  // Headings:
  heading_font: "New Computer Modern Sans", // May prefer Libertinus Serif for formality.
  heading_numbering: sym.section + "1.1.", // Something like Problem 1A) can be handy.
  // Numbering:
  eqn_numbering: "(1)", // May prefer something like (I) for style.
  eqn_ref_numbering: "(1)", // May prefer something like Eq. (1) for clarity.
  // ----------------------------------------------------------------------------------- //
  body,
) = {
  show: thmrules.with(qed-symbol: $qed$) // Must do this or theorems will format weirdly!
  set document(title: title, author: author) // Metadata.
  set par(justify: true) // Make paragraphs pretty.


  // Colored links.
  show link: it => {
    set text(if (type(it.dest) == label) { colors.cherry_red } else { blue })
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
  set heading(numbering: heading_numbering)
  show heading: it => {
    block([
      #set text(font: heading_font, size: 21pt - (it.level * 3pt))
      #if (it.numbering != none) [
        #text(colors.cherry_red, counter(heading).display())
        #h(1pt) // Space between numbering and heading text.
      ]
      #it.body
      #v(0.4em) // Space below headings.
    ])
  }

  set page(
    // Pretty header on each non-cover page with title & dots for page num.
    header: context {
      let page_num = here().page()
      if page_num > 1 [
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
      ]
    },
    // Pretty footer with author & page num.
    footer: context {
      let page_counter = counter(page)
      if (page_counter.final().at(0) == 1) { return none }
      text(weight: "bold", smallcaps[#if here().page() > 1 [#author] else [#sym.arrow.b]])
      h(1fr)
      page_counter.display(
        "1 of 1",
        both: true,
      )
    },
  )

  // Title, author, date.
  align(title_align)[
    #set text(font: heading_font)
    #block(spacing: 1.3em)[#text(24pt, weight: "bold")[#title]]
    #text(14pt)[#author (#text(colors.cherry_red)[#date])]
  ]

  v(1em) // Some vertical space.

  // Pretty table of contents if enabled.
  if toc {
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

    outline()
  }

  v(1em) // Some more vertical space.

  body
}
