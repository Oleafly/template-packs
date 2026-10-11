// A Typst template for formal letters in Hebrew.
//
// Everything here is direction-agnostic. `is-rtl` is threaded through every
// function rather than read from a global, so one source tree can render a
// Hebrew original and an English translation with identical page geometry —
// same margins, same rule above the footer, same "page N of M" — differing only
// in text direction and in the mirrored running order of the footer. That
// symmetry is the point: when the two editions are read side by side, nothing
// about the layout suggests one of them is the afterthought.
//
// David Libre is used for everything, and the reason is coverage rather than
// taste: it covers Hebrew and Latin in the same face. Formal Hebrew writing
// constantly embeds Latin into RTL sentences — email addresses, reference
// numbers, product names, citations — and a Hebrew-only face falls back
// mid-word to whatever the system offers, producing a page that looks assembled
// from two typewriters. Do not substitute one without checking coverage.
//
// Build with --font-path fonts (see build.sh).

#import "sender.typ": sender

#let ink = rgb("#1a1a1a")
#let muted = rgb("#5f5f5f")
#let rule = rgb("#c8c8c8")
#let accent = rgb("#1a4d7a")

#let serif = "David Libre"

// A Hebrew letter often carries both calendars, Hebrew first in the Hebrew
// edition. `dual-date` renders the pairing; it does not compute it.
//
// Typst has no Hebrew calendar, so the Hebrew date is passed in as a string.
// That is deliberate rather than lazy: a wrong Hebrew date on a document whose
// whole claim is care is worse than no Hebrew date at all. Convert once,
// per document, against a source you trust, and record the pairing next to the
// letter — see docs/typesetting-hebrew.md.
#let dual-date(hebrew: none, gregorian: none, is-rtl: false) = {
  if is-rtl { hebrew + " · " + gregorian } else { gregorian + " (" + hebrew + ")" }
}

// The sender's own details, as a block for the details table. Address, ID and
// phone all come from src/sender.typ, so they cannot disagree between the
// details block, the signature and the page footer of the same letter.
#let sender-block(labels: (:), is-rtl: false) = {
  let name = if is-rtl { sender.name-he } else { sender.name }
  let address = if is-rtl { sender.address-he } else { sender.address }
  [
    #name#if sender.id != "" [, #labels.id #sender.id] \
    #address \
    #labels.phone #sender.phone · #sender.email
  ]
}

// Document head — the centred, underlined block at the top of page one.
// `body` is the addressee or the document's own title; `subtitle` a single grey
// line under it saying what kind of document this is.
#let doc-head(body: none, subtitle: none, is-rtl: false) = {
  set align(center)
  set text(dir: if is-rtl { rtl } else { ltr })
  block(above: 0pt, below: 6pt)[
    #set text(size: 14pt, weight: "bold")
    #underline(offset: 4pt, stroke: 0.7pt)[#body]
  ]
  if subtitle != none {
    block(above: 0pt, below: 0pt)[
      #set text(size: 10pt, fill: muted)
      #subtitle
    ]
  }
  v(14pt)
}

// Details block — label/value rows for sender, addressee, reference and date,
// closed by a full-width rule. `rows` is an array of (label, value) pairs;
// value may be content, so an addressee can carry an address block under its
// name and a date row can carry a `dual-date`.
#let details(rows: (), is-rtl: false) = {
  set text(dir: if is-rtl { rtl } else { ltr })
  block(width: 100%)[
    #set text(size: 10.5pt)
    // The label column is declared first and lands on the correct edge in both
    // directions without any mirroring code: Typst lays grid columns out along
    // the text direction, so "first" is the right-hand edge under RTL.
    #grid(
      columns: (auto, 1fr),
      column-gutter: 18pt,
      row-gutter: 8pt,
      align: if is-rtl { (right, right) } else { (left, left) },
      ..rows
        .map(r => (text(weight: "bold")[#r.at(0):], r.at(1)))
        .flatten(),
    )
  ]
  v(10pt)
  line(length: 100%, stroke: 0.7pt + ink)
  v(12pt)
}

// The subject line — the הנדון. Centred and underlined, one line. It is worth
// spending time on: in a long letter it is often the only line read before
// somebody decides who should deal with the thing.
#let subject-line(text-body: none, is-rtl: false) = {
  set align(center)
  set text(dir: if is-rtl { rtl } else { ltr })
  block(width: 100%, above: 0pt, below: 14pt)[
    #set text(size: 12pt, weight: "bold")
    #underline(offset: 3pt, stroke: 0.6pt)[#text-body]
  ]
}

// Standing notice — the tinted, rule-flanked block between the subject line and
// the body, for something the reader has to take in before reading anything
// else: what this letter is and is not, what it supersedes, what is
// deliberately not being asked for.
#let notice(body, is-rtl: false) = {
  block(
    width: 100%,
    fill: rgb("#f4f6f8"),
    stroke: (
      left: if is-rtl { none } else { 2.5pt + accent },
      right: if is-rtl { 2.5pt + accent } else { none },
    ),
    inset: (x: 12pt, y: 10pt),
    breakable: false,
  )[
    #set text(dir: if is-rtl { rtl } else { ltr }, size: 9.5pt)
    #body
  ]
  v(10pt)
}

// Contents block. A long letter gets read by people looking for one section, so
// it earns a short tinted list on page one rather than a title page — which a
// letter, however long, should not have.
#let contents(title: none, is-rtl: false) = {
  block(
    width: 100%,
    fill: rgb("#f4f6f8"),
    stroke: (
      left: if is-rtl { none } else { 2pt + accent },
      right: if is-rtl { 2pt + accent } else { none },
    ),
    inset: (x: 12pt, y: 10pt),
    breakable: false,
  )[
    #set text(dir: if is-rtl { rtl } else { ltr })
    #block(above: 0pt, below: 6pt)[
      #set text(size: 10pt, weight: "bold", fill: accent)
      #title
    ]
    #set text(size: 9.5pt)
    #outline(title: none, depth: 2)
  ]
  v(6pt)
}

// Sign-off. `ref` is your own reference — the one you want quoted back at you —
// and is omitted when a letter opens a correspondence rather than continuing one.
#let signature(name: none, ref: none, labels: (:), is-rtl: false) = {
  block(breakable: false)[
    #set text(dir: if is-rtl { rtl } else { ltr })
    #labels.regards

    #v(18pt)

    #text(weight: "bold", size: 11pt)[#if name == none {
      if is-rtl { sender.name-he } else { sender.name }
    } else { name }]

    #v(3pt)

    #text(size: 9pt, fill: muted)[
      #if sender.id != "" [#labels.id #sender.id \ ]
      #sender.phone \
      #sender.email
      #if ref != none [\ #labels.ours #ref]
    ]
  ]
}

// `footer-note` carries the status of a translated edition — "this is a
// convenience translation; the Hebrew text governs" and nothing more. It lives
// in the footer rather than the body deliberately: a paragraph of
// throat-clearing about which text governs reads as apologetic and invites the
// reader to weigh the document's provenance instead of its contents. A standing
// footer line states the same fact once per page and argues with nobody.
#let formal-doc(
  lang: "he",
  is-rtl: true,
  title: none,
  strings: (:),
  footer-note: none,
  body,
) = {
  set document(title: title, author: sender.name)

  set page(
    paper: "a4",
    margin: (x: 2.4cm, top: 2.2cm, bottom: 2.5cm),
    footer: context {
      let n = counter(page).at(here()).first()
      let total = counter(page).final().first()
      set text(size: 8pt, fill: muted, dir: if is-rtl { rtl } else { ltr })
      line(length: 100%, stroke: 0.4pt + rule)
      v(4pt)
      let reach = sender.phone + " · " + sender.email
      let folio = (strings.page-of)(n, total)
      // Mirrored so the folio always sits on the outer edge.
      if is-rtl {
        grid(columns: (1fr, auto), align: (right, left), reach, folio)
      } else {
        grid(columns: (1fr, auto), align: (left, right), reach, folio)
      }
      if footer-note != none {
        v(2pt)
        set text(size: 7.5pt, style: "italic")
        align(if is-rtl { right } else { left }, footer-note)
      }
    },
  )

  set text(
    font: serif,
    size: 11pt,
    fill: ink,
    lang: lang,
    dir: if is-rtl { rtl } else { ltr },
  )

  set par(justify: true, leading: 0.72em, spacing: 1.1em)

  // Numbering the paragraphs is worth the small ugliness: a reply that says
  // "regarding paragraph 14" is answering something specific, and a reply that
  // skips paragraph 14 is visibly skipping it. Unnumbered prose gets answered
  // in the round, or not at all.
  set enum(numbering: "1.", indent: 0pt, body-indent: 8pt, spacing: 1.1em)
  set list(indent: 0pt, body-indent: 8pt)

  show heading: it => {
    set text(fill: accent, weight: "bold")
    block(above: 1.6em, below: 0.8em, sticky: true, it)
  }
  show heading.where(level: 1): set text(size: 12.5pt)
  show heading.where(level: 2): set text(size: 11pt)

  // A formal letter is read as a sequence of self-contained assertions. A block
  // split across a page break reads as one that was not finished.
  set block(breakable: false)
  show figure: set block(breakable: false)

  // Quotations here are usually something being relied on — a clause, a term,
  // something you were told — so they get a rule on the reading edge rather
  // than an indent, which in RTL is easy to mistake for a list.
  show quote: it => block(
    fill: rgb("#f4f6f8"),
    stroke: (
      left: if is-rtl { none } else { 2pt + accent },
      right: if is-rtl { 2pt + accent } else { none },
    ),
    inset: (x: 10pt, y: 8pt),
    width: 100%,
    it.body,
  )

  body
}
