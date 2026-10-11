// ==============================================================================
// 📌 AU DMin Text & Structural Elements
// ==============================================================================

#import "state.typ": *
#import "i18n.typ": *
#import "layout.typ": (
  count-title-lines, format-title, word-double-leading, word-single-leading, word-space-skip-1, word-space-skip-2,
  word-space-skip-3,
)

/// Chapter heading — Exhibit I
/// Generates: CHAPTER N [triple space] TITLE IN ALL CAPS
/// Spacing between lines of title (AU DMin Manual p. 13 & Exhibit I):
/// - 2 lines: double spacing (word-double-leading)
/// - 3+ lines: single spacing (word-single-leading)
#let dmin-chapter(title: "", lines: auto) = [
  #let num-lines = if lines != auto { lines } else { count-title-lines(title) }
  #let effective-lines = if num-lines > 1 { num-lines } else { auto }
  #dmin-chapter-lines.update(effective-lines)
  #let formatted = format-title(title)
  #heading(level: 1, numbering: "1.", outlined: true)[#formatted]
  #dmin-chapter-lines.update(auto)
  #consecutive-subhead.update(true)
]

/// Level 5 Subheading (AU Level 5): Run-in to paragraph
/// Indented 0.5", Bold, sentence style, ends with period (Ch.2 p.10)
/// Preceded by triple space (above: 28pt). Followed by double space (built into paragraph).
/// Usage: #subhead5[Students feel responsible][When the students...]
#let subhead5(title, body) = context {
  let was-subhead = consecutive-subhead.get()
  let abv = if was-subhead { 0pt } else { word-space-skip-2 }
  consecutive-subhead.update(false)
  let formatted-title = if type(title) == str {
    let t = title.trim()
    if t.ends-with(".") { t } else { t + "." }
  } else {
    let r = repr(title)
    if r.ends-with(".]") or r.ends-with(".\"") or r.ends-with(".") {
      title
    } else {
      [#title.]
    }
  }
  v(abv, weak: true)
  text(weight: "bold")[#formatted-title]
  [ ]
  body
}

/// Block Quote — Chapter 3 (p. 12)
/// 5+ lines of quoted material; single-spaced; indented 0.25in (quarter inch)
/// Double space before and after (above: 14pt, below: 14pt)
#let blockquote(body) = [
  #block(width: 100%, above: word-space-skip-1, below: word-space-skip-1)[
    #pad(left: 0.25in)[
      #set par(leading: word-single-leading, spacing: word-single-leading, first-line-indent: 0pt, justify: false)
      #set text(size: 12pt)
      #body
    ]
  ]
]

/// DMin Table — Chapter 2 (p. 7-8) & Chapter 3 (p. 13) & Exhibit F
/// Quadruple space (skip 3 lines = 42pt) before/after when on page with text
#let dmin-table(number: auto, title: "", table-content, note: none, breakable: false) = context {
  let s = dmin-get-strings(au-dmin-lang.get())
  let formatted = format-title(title)
  let content = [
    #table-content
    #if note != none [
      #v(6pt, weak: true)
      #set text(size: 10pt)
      #set par(leading: word-single-leading, first-line-indent: 0pt)
      #note
    ]
  ]
  figure(
    content,
    caption: figure.caption(position: top)[#formatted],
    kind: table,
    supplement: s.table,
  )
}

/// DMin Isolated Table — Chapter 2 (p. 7, Rule 3) & Exhibit F
/// Placed on its own separate page (pagebreak before and after; no body text sharing the page)
#let dmin-table-isolated(number: auto, title: "", table-content, note: none) = [
  #pagebreak(weak: true)
  #dmin-table(number: number, title: title, table-content, note: note)
  #pagebreak()
]

/// DMin Figure — Chapter 2 (p. 7-8) & Chapter 3 (p. 13) & Exhibit F
/// Quadruple space (skip 3 lines = 42pt) before/after when on page with text
#let dmin-figure(number: auto, caption: "", figure-content, source: none, breakable: false) = context {
  let s = dmin-get-strings(au-dmin-lang.get())
  let formatted = format-title(caption)
  let content = [
    #figure-content
    #if source != none [
      #v(6pt, weak: true)
      #set text(size: 10pt, weight: "regular")
      #set par(leading: word-single-leading, first-line-indent: 0pt)
      #source
    ]
  ]
  figure(
    content,
    caption: figure.caption(position: bottom)[#formatted],
    kind: image,
    supplement: s.figure,
  )
}

/// DMin Isolated Figure — Chapter 2 (p. 7, Rule 3) & Exhibit F
/// Placed on its own separate page (pagebreak before and after; no body text sharing the page)
#let dmin-figure-isolated(number: auto, caption: "", figure-content, source: none) = [
  #pagebreak(weak: true)
  #dmin-figure(number: number, caption: caption, figure-content, source: source)
  #pagebreak()
]

/// Appendix Section — Chapter 2 (p. 11)
/// If cover-sheet: true, creates a centered divider sheet (APPENDIX A + TITLE) and puts body on next page without repeating heading.
/// If cover-sheet: false (default), starts page with APPENDIX A + TITLE at top (2" margin) and body below.
#let appendix-section(title: "", cover-sheet: false, body) = [
  #let formatted = format-title(title)
  #appendix-counter.step()
  #if cover-sheet [
    #pagebreak(weak: true)
    #set page(footer: none)
    #v(2.5in)
    #align(center)[
      #set text(size: 12pt)
      #context {
        let s = dmin-get-strings(au-dmin-lang.get())
        [#s.appendix #appendix-counter.display("A") \ ]
      }
      #v(word-space-skip-2)
      #context {
        let test-m = measure(block(width: 100%)[
          #set text(size: 12pt)
          #set par(leading: 0pt, first-line-indent: 0pt)
          #upper(formatted)
        ])
        let title-leading = if test-m.height >= 35pt { word-single-leading } else { word-double-leading }
        block(width: 100%)[
          #set par(leading: title-leading, first-line-indent: 0pt)
          #upper(formatted)
        ]
      }
    ]
    #heading(level: 1, numbering: "A.", supplement: [Appendix-cover], outlined: true)[#formatted]
    #pagebreak()
    #set par(leading: word-double-leading, spacing: word-double-leading, first-line-indent: 0.5in, justify: false)
    #body
  ] else [
    #heading(level: 1, numbering: "A.", supplement: [Appendix], outlined: true)[#formatted]
    #set par(leading: word-double-leading, spacing: word-double-leading, first-line-indent: 0.5in, justify: false)
    #body
  ]
]

/// Reference List — Chapter 5 & Appendix A
#let dmin-bibliography(bib-file, style: "../csl/andrews-university-dmin-author-date.csl", title: auto) = [
  #context {
    let s = dmin-get-strings(au-dmin-lang.get())
    let display-title = if title == auto { s.ref_list } else { upper(title) }
    heading(level: 1, numbering: none, outlined: true)[#display-title]
  }

  // Забороняє розривати будь-яке окреме джерело навпіл між сторінками
  #show bibliography: set grid.cell(breakable: false)

  #set par(
    leading: word-single-leading,
    spacing: word-space-skip-2,
    hanging-indent: 0.5in,
    first-line-indent: 0pt,
    justify: false,
  )
  #bibliography(bib-file, style: style, title: none)
]
