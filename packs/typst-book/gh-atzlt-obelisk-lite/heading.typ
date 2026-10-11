// Heading and outline rendering.

#import "settings.typ": settings
#import "layout.typ": blank-page, place-node

// Section (level 1) pages.
#let section-emblem-size = 7cm
#let section-emblem-overhang = 10pt
#let section-emblem-font = 120pt
#let section-emblem-stroke = 3pt
#let section-border = 0.75pt
#let section-title-scale = 3.5
#let section-lead = 3 // in grid steps
#let section-title-space = 2 // blank steps below the title

// Subheadings, in grid steps.
#let h2-gap = (above: 4, below: 3)
#let h3-gap = (above: 3, below: 2)

#let outline-rule = 0.25pt

// Text drawn twice in the page color — once outlined, once filled — so it reads
// as a glyph with a bold inner border.
#let outlined-text(body, stroke: luma(180), ..args) = context {
  let page = settings.get().theme.page
  box(
    place(text(body, stroke: stroke, fill: page, ..args))
      + text(body, stroke: none, fill: page, ..args),
  )
}

// The divider page that opens a section.
#let section-page(title, symbol, margin, texts) = context {
  let s = settings.get()
  let step = texts.step
  blank-page(weak: true)

  let emblem = box(
    width: section-emblem-size,
    height: section-emblem-size,
    stroke: section-border + s.theme.line,
    fill: s.theme.page,
    align(
      center + horizon,
      outlined-text(
        font: s.fonts.sans,
        size: section-emblem-font,
        stroke: section-emblem-stroke + s.theme.line,
        [#symbol],
      ),
    ),
  )
  place(
    top + left,
    dx: -margin.e - section-emblem-overhang,
    dy: -margin.t - step - section-emblem-overhang,
    emblem,
  )

  v(step * section-lead * 4)
  set par(leading: step * section-lead, justify: false)
  set block(
    above: step * section-lead,
    below: step * section-title-space,
    breakable: false,
  )
  text(
    size: texts.size * section-title-scale,
    font: s.fonts.sans,
    align(right, title),
  )
  v(step * section-lead)
}

#let contents-icon = "<?xml version=\"1.0\" encoding=\"utf-8\"?><svg width=\"800px\" height=\"800px\" viewBox=\"0 0 24 24\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M4 6H20M4 12H14M4 18H9\" stroke=\"#eaeaea\" stroke-width=\"2\" stroke-linecap=\"square\"/></svg>"

// One outline entry: a clickable title, a leader line, and a page number.
#let outline-entry(it, step) = {
  let location = it.element.location()
  let numbers = counter(heading).at(location)
  let title = {
    show linebreak: ""
    it.element.body
  }
  let label = if it.level == 1 {
    [Section #numbering("1", ..numbers) #title]
  } else {
    [#numbering("1.1.1", ..numbers) #title]
  }

  let entry = link(location, label)
  if it.fill != none {
    entry += [ ] + box(width: 1fr, it.fill) + [ ]
  } else {
    entry += h(1fr)
  }
  entry += link(location, it.page())

  block(
    if it.level == 1 {
      v(step) + strong(entry)
    } else {
      h(1.5em * (it.level - 2)) + entry
    },
  )
}

// Installed by `init` via `show: heading-rules`.
#let heading-rules(it) = context {
  let (margin, fonts, texts, headings, theme) = settings.get()
  let step = texts.step

  // Headings are set in the sans face.
  show heading: it => {
    set text(font: fonts.sans)
    it
  }

  // Level 1 opens the section on its own divider page.
  show heading.where(level: 1): it => context {
    let number = counter(heading).at(here()).at(0)
    section-page(
      [#text(weight: "light")[Section #number]\ #text(weight: "extrabold", it)],
      number,
      margin,
      texts,
    )
  }

  // Level 2: a marker in the margin, then the heading text.
  show heading.where(level: 2): it => {
    set text(size: texts.size * headings.h2.size)
    set block(
      above: step * h2-gap.above,
      below: step * h2-gap.below,
      breakable: false,
    )
    set par(leading: step, justify: false)
    block(breakable: false)[#place-node(
        $#headings.h2.sym$,
        dy: headings.h2.dy,
      ) #h(2pt)#box(it)]
  }

  // Level 3: the same, one step tighter.
  show heading.where(level: 3): it => {
    set text(size: texts.size * headings.h3.size)
    set block(
      above: step * h3-gap.above,
      below: step * h3-gap.below,
      breakable: false,
    )
    set par(leading: step, justify: false)
    block(breakable: false)[#place-node(
        $#headings.h3.sym$,
        dy: headings.h3.dy,
      ) #it]
  }

  // The outline gets a divider page of its own.
  show outline: it => {
    show heading: _ => section-page(
      [Table of Contents],
      image(bytes(contents-icon), format: "svg", width: 60%),
      margin,
      texts,
    )
    it
  }

  set outline.entry(fill: line(length: 100%, stroke: outline-rule + theme.line))
  show outline.entry: it => outline-entry(it, step)

  it
}
