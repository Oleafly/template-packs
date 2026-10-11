// UBC Thesis Style v1.0.0
//
// Please contribute improvements at https://github.com/njericha/ubc-thesis-typst-template
//
// Copyright 2026 Nicholas Joseph Emile Richardson
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// Use the package hydra to get running headers with the current section title
#import "@preview/hydra:0.6.2": hydra

// Cleaver Referencing (e.g. #Cref[@sec-a @sec-b] => Sections 1 and 2)
#import "@preview/smartaref:0.1.0": Cref, cref

// Abbreviations
#import "@preview/abbr:0.3.0"

// Theorems
#import "@preview/ctheorems:1.1.3": thmrules, thmbox, thmproof, qedhere, thmcounters

// Theorem Definitions:
// Can change italic to regular if preferred
#let thmbox = thmbox.with(inset: 0.75em, radius: 0.5em, base_level: 1, bodyfmt: it => {
    set text(style: "italic")
    it
    },
    padding: (top: -0.25em, bottom: -0.25em),
    separator: [#h(0.1em):#h(0.1em) ]
)
// Can change these colours to your preference
#let definition = thmbox("definition", "Definition", stroke: color.hsv(250deg, 50%, 75%))
#let proposition = thmbox("proposition", "Proposition", stroke: color.hsv(42deg, 50%, 75%))
#let lemma = thmbox("lemma", "Lemma", stroke: color.hsv(190deg, 50%, 75%))
#let theorem = thmbox("theorem", "Theorem", stroke: color.hsv(100deg, 50%, 75%))
#let corollary = thmbox("corollary", "Corollary", stroke: color.hsv(300deg, 50%, 75%))

#let assumption = thmbox("assumption", "Assumption", stroke: color.hsv(0deg, 50%, 75%))
#let proof = thmproof("proof", "Proof", separator: [#h(0.1em):#h(0.25em)])
#let remark = thmproof("remark", "Remark", inset: 0em, bodyfmt: it => it, separator: [#h(0.1em):#h(0.25em)])

// Auto format text in math-mode to italics if appropriate (like in theorems) and ensure the specified font is used
#let mathtext(it, font: "Libertinus Serif") = context {
    let format = text.style
    let last-par = query(selector(par).before(here())).last()
    // let font = text.font
    if format == "italic" [#show regex(".{2,}"): set text(font: font)
        #math.italic(it) //#h(0.3em)
    ] else [
      #show regex(".{2,}"): set text(font: font)
        #it
    ]
}

#let current_font() = text.font
#let my_font = state("my_font_name", context current_font())

// TODO use the global font
// TODO fix mathtext to work on one letter words "a" but not variables x

// Smart Referencing

// Parse a sequence of references in content `[@ref1 @ref2 @ref3]` into an array of their labels (`<ref1>, <ref2>, <ref3>)`
// Credit: https://github.com/mewmew/smartaref-typ/blob/c09ab0598c97979e05c4971af652a6d5979d9b79/src/lib.typ#L179
#let parse_ref_list(..args) = {
  let refs = ()
	for arg in args.pos() {
		let children = ()
		if arg.has("children") {
			children = arg.children
		} else {
			children.push(arg)
		}
		for child in children {
			if child.has("target") {
				refs.push(child)
			}
		}
	}
  return refs.map(it => it.target)
}

// Theorems

// gets the correct counter for theorem environments
// factors in counter resets at the start of level 1 headings
// label is the <tag> and identifier is "theorem" or "lemma" etc.
#let get_thm_count(label, identifier) = {
    let prev_count = thmcounters.at(label).at("counters").at(identifier, default: (0,0))
    let header_count = counter(heading).at(label).first()
    if header_count == prev_count.at(0) {
        return (prev_count.at(0), prev_count.at(-1) + 1) // safe to count up by one
    } else { // assume the counter was at the end of the previous section, or hit the first entry and has the default value (0, 0)
        return (header_count, 1)
    }
}

// Theorems like Proposition, Definition, etc. just need an "s", but Corollaries needs their own pluralization.
#let thm_plural(it) = {
    if it == [Corollary] [Corollaries] else {it + [s]}
}

// Use it like `#thm_ref[@thm-1 @thm-2 @thm-3]` to get "Theorems 1.1, 1.2, and 1.3".
// Works with all theorem environments (Propositions, Lemmas, Corollaries, etc.) as long as they are all the same type
// Automatically sorts the list (`#thm_ref[@thm-3 @thm-1 @thm-2]` displays the same result as the previous example)
// Cannot use Cref because of this issue https://github.com/mewmew/smartaref-typ/issues/7
#let thm_ref(..args) = {
  let refs = parse_ref_list(..args)
  context {
    let thm = query(refs.at(0)).at(0).fields()
    let supplement = thm_plural(thm.at("supplement"))
    let identifier = thm.body.children.at(-2).value
    let refs_and_numbers = refs.map(it => (ref: it, number: get_thm_count(it, identifier)))

    let sorted_refs = refs_and_numbers.sorted(key: it => it.number)
    let ref_list = sorted_refs.map(it => link(it.ref)[#numbering("1.1", ..it.number)])
    let n_refs = refs.len()
    if n_refs > 2 [#supplement #ref_list.join(", ", last: ", and ")] else [#supplement #ref_list.join(" and ")]
  }
}

// Equation Numbering and Referencing

#let block_equation_counter = counter("block_equation")
#block_equation_counter.update(0)
#let equation_numbering(it) = context {
    let heading_count = counter(heading.where(level: 1)).at(it).first()
    let count = block_equation_counter.at(it)
    return numbering("1.1", heading_count,..count)
}

// Use it like `#eq_ref[@eq-1 @eq-2 @eq-3]` to get "Equations 1.1, 1.2, and 1.3".
// Cannot use Cref because of this issue https://github.com/mewmew/smartaref-typ/issues/7
#let eq_ref(..args) = {
  let refs = parse_ref_list(..args)
  let ref_list = refs.map(it => link(it)[#equation_numbering(it)])
  let n_refs = refs.len()
  if n_refs > 2 [Equations #ref_list.join(", ", last: ", and ")] else [Equations #ref_list.join(" and ")]
}

// Flexible Captions

#let in-outline = state("in-outline", false)
// `long` appears in the main body, `short` appears in table of contents, list of figures etc.
// credit: https://sitandr.github.io/typst-examples-book/book/snippets/chapters/outlines.html#long-and-short-captions-for-the-outline
#let flex-caption(long, short) = context if in-outline.get() { short } else { long }

// Committee page

// Define the committee page.
// `examining-committee` and `addition-members` should be arrays of tuples containing each member's role, and credentials
#let committee-page(
  thesis-title: "Thesis Title",
  name: "Firstname Lastname",
  degree: "My Degree",
  program: "My Program",
  examining-committee: (("Supervisor", "My Supervisor's Name, Professor, Department of My Program, UBC"),),
  additional-members: (("Supervisory Committee Member", "Committee Member 1, Professor, Department of My Program, UBC"),)
) = [
  #let format-member(role, credentials) = {
    grid(
      columns: 1fr,
      rect[#credentials],
      grid.hline(),
      rect[#role],
    )
  }

  The following individuals certify that they have read, and recommend to the Faculty of Graduate and Postdoctoral Studies for acceptance, the dissertation entitled:

  #set rect(stroke: none)
  #grid(
    columns: 1fr,
    rect[#thesis-title],
    grid.hline()
  )

  #grid(
    columns: (auto, 1fr, auto), // may need to adjust the middle column for longer names
    row-gutter: 1em,

    grid.hline(start: 1, end: 2, position: bottom),
    rect[submitted by],
    rect[#name],
    rect[in partial fulfilment of the requirements for],

    grid.hline(start: 1, position: bottom),
    rect[the degree of],
    rect[#degree],
    rect[],

    grid.hline(start: 1, position: bottom),
    rect[in],
    rect[#program],
  )
  \
  #strong[Examining Committee:]

  #grid(
    columns: 1fr,
    row-gutter: 1em,
    for (role, credentials) in examining-committee {
      format-member(role, credentials)
    }
  )
  \
  #strong[Additional Supervisory Committee Members:]

  #grid(
    columns: 1fr,
    row-gutter: 1em,
    for (role, credentials) in additional-members {
      format-member(role, credentials)
    }
  )
]

// Create subsections with headings that are different in the body (longtitle), and table of contents and the PDF bookmarks (title)
// Idea inspired by https://github.com/typst/typst/issues/1889#issuecomment-3005941977
#let subsection_alt(title, longtitle, my_ref) = {
  [#[#heading({
    title
    [#metadata((title: title, longtitle: longtitle))<altheading>] // a special tag so we can extract the long title
  }, level: 3)] #label(my_ref)]
}

// Display large section numbers.
// Also ensures sections still start on a new page and the equation counter is updated
#let big-section-numbers(doc) = {
  show heading.where(level: 1): it => context {
    pagebreak(weak: true)
    block_equation_counter.update(1)
    [#set text(size: 4em); #numbering(it.numbering, ..counter(heading).get())#sym.space.quarter]
    it.body
    parbreak()
  }
  doc
}

// Main thesis formatting function. Add the following at the start of the thesis:
// ```
// #show: thesis.with(thesis-title: "My Thesis Title")
// ```
//
// The defaults are:
// ```#let thesis(
//   font: "libertinus serif",
//   paper-size: "us-letter",
//   font-size: 12pt,
//   table-of-contents-depth: 2,
//   number-unlabelled-equations: false,
//   thesis-title: "My Thesis Title",
//   name: "Firstname Lastname",
//   degree: "Doctor of Philosophy",
//   program: "My Program",
//   cover-page: [MY THESIS by ME],
//   examining-committee: (("Supervisor", "My Supervisor's Name, Professor, Department of My Program, UBC"),),
//   additional-members: (("Supervisory Committee Member", "Committee Member 1, Professor, Department of My Program, UBC"),),
//   abstract: [Your thesis abstract. 350 words max.],
//   lay-summary: [Your lay summary intended for the general public here. 150 words max.],
//   preface: [This dissertation is original, unpublished...],
//   list-of-symbols: none,
//   abbreviations: none,
//   acknowledgements: none,
//   dedication: none,
//   doc
// )```
#let thesis(
  font: "libertinus serif",
  paper-size: "us-letter",
  font-size: 12pt,
  table-of-contents-depth: 2,
  number-unlabelled-equations: false,
  thesis-title: "My Thesis Title",
  name: "Firstname Lastname",
  degree: "Doctor of Philosophy",
  program: "My Program",
  cover-page: [MY THESIS by ME],
  examining-committee: (("Supervisor", "My Supervisor's Name, Professor, Department of My Program, UBC"),),
  additional-members: (("Supervisory Committee Member", "Committee Member 1, Professor, Department of My Program, UBC"),),
  abstract: [Your thesis abstract. 350 words max.],
  lay-summary: [Your lay summary intended for the general public here. 150 words max.],
  preface: [This dissertation is original, unpublished...],
  list-of-symbols: none,
  abbreviations: none,
  acknowledgements: none,
  dedication: none,
  doc
) = {
  // Set Metadata
  set document(title: thesis-title, author: name)

  // Basic Page Setup
  set page(paper: paper-size,
    header: context {set align(center); emph[#hydra(1)]}) // level 1 section names
  set text(region: "CA", hyphenate: auto, font: font, size: font-size)
  set par(justify: true)

  // Format tables
  set table(inset: 6pt, stroke: none)
  set table.cell(align: horizon)

  // Can use other symbols like square.filled instead of square to end proofs
  show: thmrules.with(qed-symbol: $square$)

  // Format code blocks
  show raw.where(block: true): set block(
      width: 100%,
      inset: 8pt,
      radius: 2pt,
      fill: color.hsl(0deg, 0%, 95%, 100%),
      breakable: false,
  )

  // Lets us check if we are inside a Table of Contents, List of Figures, etc.
  show outline: it => {
    in-outline.update(true)
    it
    in-outline.update(false)
  }

  // Start level 1 sections on a new page
  show heading.where(level: 1): it => {
    pagebreak(weak: true) + it
  }

  // Custom in-text Equation references
  // In-text we have: Equation 1.1
  // While equation label are: (1.1)
  show ref: it => {
    // provide custom reference for equations
    if it.element != none and it.element.func() == math.equation {
      let heading_count = counter(heading.where(level: 1)).at(it.target).first()
      let count = block_equation_counter.at(it.target)
      link(it.target)[Equation~#equation_numbering(it.target)]
    } else {
      it
    }
  }

  // Reset equation counter at the start of each level 1 section
  show heading.where(level: 1): it => {
      block_equation_counter.update(1)
      // counter(math.equation).update((1,1))
      it
  }

  // Label block equations as (X.Y) for section X and equation Y.
  set math.equation(numbering: it => {
      block_equation_counter.step()
      [(#equation_numbering(here()))]
  })

  // Hide labels when equations don't have a reference tag
  show math.equation.where(block: true): it => {
    if number-unlabelled-equations or it.has("label") {
      it
    } else [
      // #counter(math.equation).display()

      // #counter(math.equation).update(n => n - 1) // not numbering so need to revert counter
      #math.equation(it.body, block: true, numbering: none)
      #label("none") // give it an unused label to avoid an infinite loop
    ]
  }

  // Start of Document
  [
  #set heading(numbering: none)
  #set page(numbering: "i")

  // Cover Page
  #[
  #set align(center + horizon)
  #set par(spacing: 3em) // adjust as needed
  #set page(numbering: none) // do not show on cover page
  #cover-page
  ]

  #committee-page(thesis-title:thesis-title,name:name,degree:degree,program:program,examining-committee:examining-committee,additional-members:additional-members)

  = Abstract
  <abstract>
  #abstract

  = Lay Summary
  <lay-summary>
  #lay-summary

  = Preface
  <preface>
  #preface

  #outline(
    title: [Table of Contents],
    indent: 2em,
    depth: table-of-contents-depth
  )

  #[
  // Auto hide List of Tables and Figures if they are empty
  // Credit https://forum.typst.app/t/how-to-hide-an-outline-if-there-are-no-entries/3667/4
  #show outline: it => if query(it.target) != () { it }

  #outline(
    title: [List of Tables],
    target: figure.where(kind: table),
  )

  #outline(
    title: [List of Figures],
    target: figure.where(kind: image),
  )
  ]

  // List of Symbols
  #{if list-of-symbols != none [
  = List of Symbols
  <list-of-symbols>
  #list-of-symbols
  ]}

  // List of Abbreviations
  #show: abbr.show-rule
  #abbr.make(..abbreviations)
  #abbr.config(space-char: sym.space.nobreak)
  #abbr.config(style: it => text(black, it)) // can change the colour if preferred
  #{if abbreviations != none [
  #set text(hyphenate: false)
  #set par(justify: false)
  // Title set in here to ensure title stays on the same page as the list
  #abbr.list(title: [List of Abbreviations], columns: 1)
  ]}

  #{if acknowledgements != none [
  = Acknowledgements
  <acknowledgements>
  #acknowledgements
  ]}

  // Dedication
  #{if dedication != none [

  #show heading: it => [] // Hide the heading in body, but still show in Table of Contents
  #set page(header: none)
  #pagebreak() // manual page break because we suppress the Dedication heading
  #set align(center + horizon)
  = Dedication
  <dedication>
  #emph[#dedication]
  #pagebreak()
  ]}

  // Page setup for main body
  #set page(numbering: "1")
  #counter(page).update(1)
  #set heading(numbering: "1.1.1.i")

  #doc

  ]
}

// Appendices //

// The title "Appendices" is a level 1 section, each appendix is a level 2 section, and subsections are level 3 sections.
// We use `set heading(offset: 1)` so only one equals is needed for each appendix, and two for a subsection

// Start the appendix. Add the following right before the appendix.
// ```
// #show: appendices
// ```
// Can set the appendix title with
// ```
// #show: appendices(title: "My Appendix Title")
// ```
#let appendices(title: "Appendices", body) = {
  // Running headers for appendices
  set page(header: context {set align(center); emph[#hydra(2)]})

  // Appendix Numbering
  let appendix_numbering(..number) = [Appendix #numbering("A", number.at(1)):]
  let appendix_numbering_minor(..number) = {numbering("A.1", number.at(1), number.at(2))}
  set heading(numbering: none)

  // Start the appendices
  [= #title]

  // "Offset" lets us use a single equals sign, "= The First Appendix", for
  // "Appendix A: The First Appendix"
  // And two equals, "== My Subsection", for a subsection "A.1 My Subsection"
  set heading(offset: 1)

  show heading.where(level: 2): set heading(numbering: appendix_numbering, supplement: [])
  show heading.where(level: 2): it => {
      let heading_count = counter(heading).at(here())
      [#appendix_numbering(..heading_count) #it.body]
  }
  set heading(
    numbering: appendix_numbering_minor,
    supplement: {
      set text(hyphenate: false)
      [Appendix]
    }
  )
  counter(heading).update(0)

  // Display the long heading only in main body, and short headings in Table of Contents and PDF bookmarks
  // Credit https://github.com/typst/typst/issues/1889#issuecomment-3005941977
  let findtitle(body) = {
    if body.has("children") and type(body.children.at(-1, default: none)) == content {
      let mt = body.children.at(-1)
      if mt.func() == metadata and mt.at("label", default: none) == <altheading> {
        return mt.value.longtitle
      }
    }
  }

  show heading.where(level: 3): it => {
    let longtitle = findtitle(it.body)
    block({
      if it.numbering != none {
        numbering(it.numbering, ..counter(heading).get())
        h(0.3em)
      }
      if longtitle != none { longtitle } else { it.body }
    })
  }

  // Make sure any new appendix starts on a new page
  // But need the first appendix to appear on the same page as "Appendices"
  show heading.where(level: 2): it => context {
      let previous-heading = query(selector(heading).before(here())).at(-2).body
      if previous-heading == [#title] {
          it
      } else {
      pagebreak(weak: true) + it + previous-heading
      }
  }

  body
}
