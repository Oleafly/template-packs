#import "../func/header-numbering.typ": content-header-numbering
#import "../config.typ": heading-size-chapter, heading-size-section

#let numbered-header(body) = {
  set heading(numbering: content-header-numbering)
  show heading: it => {
    let f_size = if it.level == 1 { heading-size-chapter } else {
      heading-size-section
    }
    if it.level == 1 { pagebreak(weak: true) }
    set text(size: f_size)

    let heading-nums = counter(heading).at(it.location())

    // widen the number column when any number hits double digits, so "10."
    // doesn't collide with the heading text
    let has-double-digits = heading-nums.any(n => n >= 10)

    let base-indent = if it.level <= 2 { 0.5in } else if has-double-digits {
      0.65in
    } else { 0.5in }

    let (align_at, indent_at) = if it.level <= 3 {
      (0cm, base-indent)
    } else {
      (0.5in, 1in)
    }

    block(
      above: if it.level == 1 { 1em } else { 1.2em },
      below: 1.5em,
      grid(
        columns: (align_at, indent_at - align_at, 1fr),
        column-gutter: 0pt,
        row-gutter: 0.8em,
        [],
        if it.numbering != none {
          box(inset: (right: 2pt), counter(heading).display(it.numbering))
        },
        it.body,
      ),
    )
  }

  body
}

#let centered-unnumbered-header(body) = {
  show heading: it => {
    set text(size: heading-size-chapter)
    pagebreak(weak: true)
    // CONFIGURE: extra spacing below headings containing Khmer script; drop
    // this branch if the report doesn't need Khmer text
    let has-khmer = repr(it.body).contains(regex("[\u{1780}-\u{17FF}]"))
    align(center, block(below: if has-khmer { 2.5em } else { 2em }, it.body))
  }

  body
}
